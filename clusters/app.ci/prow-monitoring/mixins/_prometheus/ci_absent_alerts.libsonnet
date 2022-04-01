{
  prometheusAlerts+:: {
    groups+: [
      {
        name: 'ci-absent',
        rules: [
          {
            alert: '%sDown' % name,
            expr: |||
              absent(up{job="%s"} == 1)
            ||| % name,
            'for': '5m',
            labels: {
              severity: 'critical',
            },
            annotations: {
              message: 'The service %s has been down for 5 minutes.' % name,
            },
          }
          for name in ['deck', 'deck-internal', 'qe-private-deck', 'hook-apps', 'jenkins-operator', 'kata-jenkins-operator', 'prow-controller-manager', 'sinker', 'tide', "dptp-controller-manager", "crier", "pod-scaler-producer", "pod-scaler-ui"]
        ],
      },
      {
        name: 'ci-absent-ghproxy',
        rules: [
          {
            alert: '%sDown' % name,
            expr: |||
              absent(up{job="%s"} == 1)
            ||| % name,
            'for': '15m',
            labels: {
              severity: 'critical',
            },
            annotations: {
              message: 'The service %s has been down for 15 minutes.' % name,
            },
          }
          for name in ['ghproxy']
        ],
      },
    ],
  },
}
