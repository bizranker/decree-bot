pipeline {
    agent {
        label 'master'
    }

    stages {
        stage('Send Decree') {
            steps {
                withCredentials([string(credentialsId: 'decreta_webhook', variable: 'DECREEBOT_WEBHOOK_URL')]) {
                    sh '''
                        if [ -f .env ]; then
                            set -a
                            . .env
                            set +a
                        fi

                        chmod +x ./scripts/post_decree.sh
                        bash ./scripts/post_decree.sh
                    '''
                }
            }
        }
    }
}
