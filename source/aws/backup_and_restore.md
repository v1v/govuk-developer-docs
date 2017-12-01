# Backup and restore

Overview of datastores (maybe a table?)

Time to restore dbs

## RDS backup and restore

http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_CommonTasks.BackupRestore.html

Automated RDS backups and SQL dumps

Requirements to restore a RDS backup: sec group, param group, VPC id, DNS CNAME, subscription, events

### Restore an RDS instance from RDS db snapshot with Terraform

The `rds_instance` module accepts a parameter to create a new database from an existing snapshot.

We can pass this parameter from any of the app projects that manage databases,  
```
 $ TF_VAR_snapshot_identifier=<snapshot-id> ./tools/build-terraform-project.sh -d ../govuk-aws-data/data -e <environment> -s <stackname> -p <project-name> -c apply
```

```
Thu 30 Nov 2017 16:40:15 GMT
...
module.mysql_primary_rds_instance.aws_db_instance.db_instance: Destruction complete after 4m6s
module.mysql_primary_rds_instance.aws_db_instance.db_instance: Creation complete after 10m19s
...
Thu 30 Nov 2017 16:56:00 GMT
```

The replica cannot update the source id, we'll need to delete the previous replica before running Terraform to force a new resource
pointing to the new master:

```
* aws_db_instance.db_instance_replica: cannot elect new source database for replication
```

Removing the TF_VAR_snapshot_identifier environment variable in the next run forces
a new db resource again

### Restore an RDS instance from RDS db snapshot with AWS cli


- List of snapshots, select by aws_migration, aws_environment, aws_stackname

```
 $ SNAPSHOTS=$(aws rds describe-db-snapshots --query 'DBSnapshots[].DBSnapshotArn' | jq -r '@csv' | tr ',' ' ' | tr -d '"')
 $ for I in $SNAPSHOTS ; do echo -ne "\n-- $I -- " ;  aws rds list-tags-for-resource --resource-name $I | jq -r '.TagList[] | [.Key, .Value] | @csv' | tr -d '"' | grep Name ; done
```

- Find security_group id, parameter_group id and subnet group name

```
 $ aws rds describe-db-snapshots --db-snapshot-identifier arn:aws:rds:xxx:snapshot:rds:mydb-2017-12-01-01-11 --query 'DBSnapshots[].DBInstanceIdentifier'
[
    "mydb-xxx"
]

 $ aws rds describe-db-instances --db-instance-identifier mydb-xxx --query 'DBInstances[].[VpcSecurityGroups[].VpcSecurityGroupId,DBParameterGroups[].DBParameterGroupName,DBSubnetGroup.DBSubnetGroupName]'
[
    [
        [
            "sg-12345678"
        ],
        [
            "mydb-xxxyyyy"
        ]
    ]
    "mydb-subnet-group"
]
```

- Update DNS, metrics, logs, events


```
aws rds restore-db-instance-from-db-snapshot \
    --db-subnet-group-name mydb-subnet-group
    --db-instance-identifier restored-mydb-2017-12-01-01-11 \
    --db-snapshot-identifier arn:aws:rds:xxx:snapshot:rds:mydb-2017-12-01-01-11

```

```
aws rds modify-db-instance \
    --db-instance-identifier restored-mydb-2017-12-01-01-11 \
    --vpc-security-group-ids sg-12345678 \
    --db-parameter-group-name mydb-xxxyyyy

```

```
 $ aws rds describe-db-instances --db-instance-identifier restored-mydb-2017-12-01-01-11 --query 'DBInstances[].Endpoint'
[
    {
...
        "Address": "xxxxxxxxxxxx.rds.amazonaws.com"
    }
]

 $ aws route53 list-hosted-zones-by-name --dns-name <integration-internal-domain> --max-items 1
{
    "DNSName": "<integration-internal-domain>",
    "HostedZones": [
        {
            "ResourceRecordSetCount":  ...
...
            "Id": "/hostedzone/ZAAAAAAAAAAAAA",
        }
    ],
...
}

cat /var/tmp/update_dns.json <<EOF
{
    "Comment": "Manual DB restore",
    "Changes": [
        {
            "Action": "UPSERT",
            "ResourceRecordSet": {
                "Name": "mysql-primary.<stack-integration-internal-domain>.",
                "Type": "CNAME",
                "TTL": 300,
                "ResourceRecords": [
                    {
                        "Value": "xxxxxxxxxxxx.rds.amazonaws.com",
                    }
                ]
            }
        }
    ]
}
EOF


aws route53 change-resource-record-sets --hosted-zone-id ZAAAAAAAAAAAAA --change-batch file:///var/tmp/update_dns.json
```

aws cli commands + import db resources in TF state file


$ terraform import aws_db_instance.default mydb-rds-instance



### Point in time restore of an RDS instance from RDS db snapshot with AWS cli

```

$ DBS=$(aws rds describe-db-instances --query 'DBInstances[].DBInstanceArn' | jq -r '@csv' | tr ',' ' ' | tr -d '"')
$ for I in $DBS ; do echo -ne "\n-- $I -- " ;  aws rds list-tags-for-resource --resource-name $I | jq -r '.TagList[] | [.Key, .Value] | @csv' | tr -d '"' | grep Name ; done

aws rds restore-db-instance-to-point-in-time \
    --db-subnet-group-name mydb-subnet-group
    --source-db-instance-identifier mysourcedbinstance \
    --target-db-instance-identifier mytargetdbinstance \
    --restore-time 2017-12-01T14:45:00.000Z
```

### Restore an RDS instance from S3 SQL dump with AWS cli



### Restore a Mysql instance (local) from S3 SQL dump with AWS cli

### Restore a Postgresql instance (local) from S3 SQL dump with AWS cli


## Elasticsearch backup and restore

https://www.elastic.co/guide/en/elasticsearch/reference/2.4/modules-snapshots.html

Snapshots and dumps

https://docs.publishing.service.gov.uk/manual/elasticsearch-dumps.html

govuk_elasticsearch/manifests/dump.pp
govuk_elasticsearch/manifests/backup.pp

### Restore ES from snapshot 

### Point in time restore from snapshot

### Restore ES from dump file (AWS)

### Restore ES from dump (local)


## Mongodb backup and restore

Explain current dumps daily and regular

https://docs.mongodb.com/v2.4/tutorial/backup-with-mongodump/

## Restore Mondodb from S3 dump (AWS and local)

https://docs.publishing.service.gov.uk/manual/mongodb.html#header

mongodb/manifests/aws_backup.pp

