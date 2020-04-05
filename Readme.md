This repo is about my learning from terraform.

## Terrform folder structure
```
- modules/project
  - main.tf
  - variables.tf
  - output.tf
```

## Provider

- Represent any of the cloud provider
- Provider block allows you to define provider and the configuration for it. 
```tf
provider "aws" {
  region = "eu-west-2"
}
```

## resource 

- Different resource avaliable from your cloud provider.
- e.g aws has resource like ec2-instance, vpc, elb etc 
- terrafrom has its own naming convention but all aws resource will have corresponding option in terrafrom

```tf
resource "aws_instance" "my_test_ec2" {
  ami = "ami-43242fsd"
  instance_type = "t2-micro"
}
```


## data

- Every resource has some metadata about it. E.g every ec2 instance has ami, instance_type, key_pair etc. 
- If you want to have know and use this information, `data` is the terrafrom way to do it.
- Using data to get information about a resource is two step process.
- First you have to tell which type of resource you are to get infromation about.
- Second then use filters to narrow down the to the specific resource, about which you need information.

``` tf
data "aws_instance" "myec2data" {
  tags {
    name = "welcome"
  }
}
```
- In example above we are trying to find metadata about a aws ec2 instance which is taggged as `name = "welcome"`
- using `data` is simple. 
```tf
  resource "aws_instance" "myec2instance" {
  ami = "ami-43242fsd"
  instance_type = "t2-micro"
  key_name = data.aws_instance.myec2data.key_name
}
```

## variable

- This is terraform way to make your script dynamic. Allows values to be passed on fly.
- You can define variables using `variable` tf resource and then use it in your other tf resrouces.
- variable can have default values or you can pass them as argument to your tf script.

```tf
variable "myec2tag" {
  default = "awesometag"
  description = "this is the awesome way to tag a ec2 instance"
  type =  string
}
```
- using variable in your main tf script

```tf
resource "aws_instance" "myec2instance" {
  ami = "ami-43242fsd"
  instance_type = "t2-micro"
  tags {
    name = var.myec2tag
  }
}
```

- passing variable from command line 

```bash
terrafrom plan -var="myec2tag=besttagever"
```

## locals

- locals are like constant in programming language. 
- They allow us to have central places to define common values which be used accross all other terrafrom resource.

```tf 
locals {
  ec2-instnce-type = "t2.micro"
}
```
- using locals is simple

```tf
resource "aws_instance" "myec2instance" {
  ami = "ami-43242fsd"
  instance_type = local.ec2-instnce-type
}

```

## tfvars

- `tfvars` are ways to provide values to your `variable`s defined. 
- Come handy when you have hunderds of variables as using `--var="var1=value1" wont be visuablly astetic nor easy to write.
- `tfvars` allow you to create a file and define values for your variables. 
- you can pass this file to your tf script as below
- tfvars file is key value pair file, where key is your `variable` name and value si the value. 
- tf file are stored with extention `tfvars`. Sample file `dev.tfvars` will look like this
```
myec2tag = dev-instance
```
- using `tfvars` file in your terrafrom plan/apply 
```bash
terrafrom plan -var-file="dev.tfvars"
```

## variable interpolation
- interpolation systax is "${something}"
- variable interpolation was primarly used in Terraform 0.11 and has a sysntax like below 

```tf
"${var.myec2tag}"
```
- can used in the scenario when you have to prefix or suffix someting to a variable or want to perform some conditional assignment.

## Expressions
- Read [this](https://www.terraform.io/docs/configuration/expressions.html)


## Comman Parameters
- `count` to iterate/loop over a resurce
- `for_each`
- `for`

## Command inbuilt function

- `length` to determine the lenght of any array, string, etc
- `upper` to change the case of a string to uppper
- `toset` to flatten a arrar
- `map

## Useful terrafrom commands

- `terraform fmt` - format our terrafrom files. 








