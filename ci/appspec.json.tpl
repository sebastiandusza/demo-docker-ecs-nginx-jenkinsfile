{
  "version": 0.0,
  "Resources": [
  {
    "TargetService": {
      "Type": "AWS::ECS::Service",
      "Properties": {
        "TaskDefinition": "arn:aws:ecs:eu-west-1:769910020948:task-definition/newweb-experiment:4",
        "LoadBalancerInfo": {
          "ContainerName": "newweb-experiment-nginx",
          "ContainerPort": 80
        }
      }
    }
  }
  ]
}