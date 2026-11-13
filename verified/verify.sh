#!/usr/bin/env bash
set -u
set -o pipefail
cd "$(dirname "$0")"
: > verification.log
run_logged() {
  printf '\nCOMMAND:' >> verification.log
  printf ' %q' "$@" >> verification.log
  printf '\n' >> verification.log
  "$@" >> verification.log 2>&1
  result=$?
  printf 'EXIT_CODE=%s\n' "$result" >> verification.log
  return "$result"
}
run_logged lean --version || exit $?
run_logged lake clean || exit $?
run_logged lake build || exit $?
lake env lean Audit.lean > theorem_audit.log 2>&1
result=$?
printf '\nlake env lean Audit.lean EXIT_CODE=%s\n' "$result" >> theorem_audit.log
[ "$result" -eq 0 ] || exit "$result"
python3 check_audit.py >> verification.log 2>&1
result=$?
printf 'check_audit.py EXIT_CODE=%s\n' "$result" >> verification.log
exit "$result"
