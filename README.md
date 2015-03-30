# Elasticbeanstalk zero downtime deployment

ElasticBeanstalk zero downtime deployment helper

Repository contains bash script, which will help you to do zero downtime deployment. 
It makes zero-downtime deployment half-automatically.
It is called ```zerodd.sh```. 
To make a zero-downtime deployment, follow these steps:

* Install EB Command Line Tools (http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3-getting-set-up.html). 
Type ```eb --version``` and check if you have at least v3.0 version.
* ```eb init``` - setup project directory to use EB CLI, select application region, fill in your credentials
* ```zerodd.sh clone PROD``` - it will clone existing ```PREFIX-PROD``` environment into ```PREFIX-PROD-RC```
* ```zerodd.sh swap-urls PROD``` - it will swap urls - RC environment will be now published
* do a deploy to ```PREFIX-PROD``` environment
* ```zerodd.sh swap-urls PROD``` - it will swap urls again - PROD environment will be now published
* ```zerodd.sh terminate-rc PROD``` - it will terminate ```PREFIX-PROD-RC``` environment
