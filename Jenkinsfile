pipeline {
  agent any

  environment {
    // Slack webhook credential is injected into this variable
    DECREEBOT_WEBHOOK_URL = credentials('decreta_webhook')
  }

  stages {
    stage('Checkout Code') {
      steps {
        checkout scm
      }
    }

    stage('Send Decree') {
      steps {
        withCredentials([string(credentialsId: 'decreta_webhook', variable: 'DECREEBOT_WEBHOOK_URL')]) {
          sh '''
            chmod +x ./scripts/post_latest_decree.sh
            ./scripts/post_latest_decree.sh
          '''
        }
      }
    }
  }
}
