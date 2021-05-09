import 'package:flutter/material.dart';

List<DropdownMenuItem<dynamic>> skills = [
  "Affiliate Marketing	",
  "B2B Marketing	",
  "B2C Marketing	",
  "Content Marketing	",
  "Demand Generation	Marketing",
  "Eloqua	Marketing",
  "Email Marketing	",
  "Event Marketing	",
  "Excel	",
  "Google AdWords	",
  "Google Analytics	",
  "Google Tag Manager	",
  "Marketing Automation	",
  "Marketo	",
  "Paid Social	",
  "Pardot	",
  "Pay Per Click	",
  "Product Marketing	",
  "Programmatic Display Advertising	",
  "Segment	",
  "SEM	",
  "SEO	",
  "Salesforce",
  "SQL	",
  "Wordpress	",
  "CSS	",
  "HTML	",
  "Javascript	",
  ".NET	",
  "Android	",
  "Angular	",
  "Angular.js	",
  "AWS	",
  "C	",
  "C#	",
  "C++	",
  "Cassandra	",
  "Chef	",
  "DevOps	",
  "Django	",
  "Docker	",
  "Drupal",
  "ElasticSearch	",
  "Elixir	",
  "ES6	",
  "Go lang	",
  "Google Cloud	",
  "Hadoop	",
  "iOS	",
  "Java	",
  "Jenkins	",
  "Kafka	",
  "Kotlin	",
  "Kubernetes	",
  "Laravel	",
  "Linux	",
  "Machine Learning	",
  "MapReduce	",
  "Microsoft Azure	",
  "MongoDB	",
  "MySQL	",
  "Node.js	",
  "PHP	",
  "PostgreSQL	",
  "Puppet	",
  "Python	",
  "R	",
  "React.js	",
  "Redis",
  "Ruby	",
  "Ruby On Rails	",
  "Scala	",
  "Serverless	",
  "Spark	",
  "SQL	",
  "SQL Server	",
  "Swift	",
  "Symphony	",
  "Vue.js	",
  "Graphic Design	",
  "Mobile Design	",
  "Photoshop	",
  "Product Design	",
  "Sketch	",
  "UI Design	",
  "UX Design	",
  "Wireframes "
].map<DropdownMenuItem<String>>((String value) {
  return DropdownMenuItem<String>(
    value: value,
    child: Text(value),
  );
}).toList();
