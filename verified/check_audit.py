"""Check source exclusions and the actual Lean theorem-audit output."""
from pathlib import Path
import re

source = Path('PisotFour.lean').read_text()
audit_source = Path('Audit.lean').read_text()
audit = Path('theorem_audit.log').read_text()
for token in ('sorry', 'admit', 'sorryAx', 'axiom', 'native_decide'):
    assert not re.search(r'\b' + token + r'\b', source), token
assert not re.search(r'\b(sorryAx|Lean\.ofReduceBool|Lean\.trustCompiler)\b', audit)
assert not re.search(r'(^|\n).*\b(error|warning):', audit)
theorems = re.findall(r'^theorem (\w+)', source, flags=re.M)
for name in theorems:
    assert '#print axioms PisotFour.' + name + '\n' in audit_source, name
    assert "'PisotFour." + name + "'" in audit, name
allowed = {'propext', 'Classical.choice', 'Quot.sound'}
for listing in re.findall(r'depends on axioms: \[([^\]]*)\]', audit, flags=re.S):
    found = set(x.strip() for x in listing.split(',') if x.strip())
    assert found <= allowed, found - allowed
for seq in ('A048589','A048591','A048585','A048588'):
    assert 'PisotFour.recurrence_' + seq + ' (n : ℕ) (hn : 4 ≤ n)' in audit, seq
assert 'lake env lean Audit.lean EXIT_CODE=0' in audit
print('PASS: source exclusion scan; all', len(theorems), 'new theorem axiom reports; four exact theorem checks.')
print('Only allowed standard axioms: propext, Classical.choice, Quot.sound.')
