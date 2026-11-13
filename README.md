# Four ceiling Pisot recurrences in Lean 4

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.24207512.svg)](https://doi.org/10.5281/zenodo.24207512)

Maintainer: **Taha Kabiri**

This project gives a shared Lean proof of the fourth-order recurrence

$$
a_n=2a_{n-1}-a_{n-2}+a_{n-3}-a_{n-4}\qquad(n\ge4)
$$

for the original ceiling sequences defined by
$a_{n+2}=\lceil a_{n+1}^2/a_n\rceil$:

| OEIS | Initial pair | Lean theorem in namespace `PisotFour` |
|---|---|---|
| [A048585](https://oeis.org/A048585) | (6,7) | `recurrence_A048585` |
| [A048588](https://oeis.org/A048588) | (7,8) | `recurrence_A048588` |
| [A048589](https://oeis.org/A048589) | (7,9) | `recurrence_A048589` |
| [A048591](https://oeis.org/A048591) | (8,10) | `recurrence_A048591` |

Values lie in the integers; division inside the ceiling is rational. The proof identifies the linear candidates with the nonlinear sequences at every index. Both one-index shift identities and the boundary cases at n=4 are included.

## Proof and verification

The shared auxiliary recurrence is b(0)=4, b(1)=6, b(2)=9 and b(n+3)=b(n+2)+b(n). The candidates are b+3 and b+4. A four-step determinant induction establishes the ceiling inequalities. See [the conventional proof](verified/proof.md) and [the Lean source](verified/PisotFour.lean).

The recorded clean build and theorem audit passed in Lean 4.19.0, with Mathlib pinned to `c44e0c8ee63ca166450922a373c7409c5d26b00b`. All 24 theorem axiom reports use only `propext`, `Classical.choice`, and `Quot.sound`, where needed. There are no admitted proofs, custom axioms, or uses of `native_decide`. See [build log](verified/verification.log) and [theorem statements and axiom audit](verified/theorem_audit.log).

To reproduce, install the specified Lean toolchain and run:

```sh
cd verified
lake exe cache get Mathlib.Tactic.NormNum Mathlib.Tactic.Linarith Mathlib.Tactic.Ring Mathlib.Tactic.LinearCombination Mathlib.Tactic.IntervalCases Mathlib.Tactic.Positivity Mathlib.Algebra.Order.Floor.Ring Mathlib.Data.Rat.Floor
bash verify.sh
```

Python 3 is used only to inspect source and audit output. Lake retrieves the pinned dependencies; they are not bundled. `SHA256SUMS` covers the public package.

## Prior work and contribution

David W. Wilson is credited for the OEIS sequence entries and recurrence statements. The Omega Institute's TrureTuring project already supplied a public mathematical proof outline for A048585 in [issue 21793](https://github.com/the-omega-institute/trureturing/issues/21793), followed by the formalization in [merged PR 27351](https://github.com/the-omega-institute/trureturing/pull/27351). Its records report successful compilation; this project did not rerun that build. A048589 follows from A048585 by shifting, so neither result is presented as a new discovery. This is public repository proof work, not an assertion of journal publication or independent human peer review.

For A048588/A048591, the bounded review found existing sequence-generating programs, including a third-order candidate for A048588, but no earlier all-index ceiling-identification proof in the inspected sources. Historical priority remains unresolved. This release contributes the supplied shared certificate's checked implementation for all four sequences, without claiming the first proof or first formalization worldwide. See [release audit](RELEASE_AUDIT.md) for precise sources and limits.

## Citation

Taha Kabiri. *Four Ceiling Pisot Recurrences — Lean 4 Verification*. Version v0.1.0. Zenodo. DOI: [10.5281/zenodo.24207512](https://doi.org/10.5281/zenodo.24207512).

Please cite this archived version using the DOI above. Machine-readable citation metadata is provided in `CITATION.cff`.

## Attribution and license

Taha Kabiri directed this project and supplied the mathematical certificate in the task specification; the certificate's ultimate authorship is not independently established by that fact. OpenAI ChatGPT/Codex implemented and debugged the Lean proofs, executed the checks, and drafted the proof explanation, documentation, and release audit. These contributions extend beyond formatting or coding assistance. No independent human verification is claimed.

The implementation was prepared after exposure to the prior work, so it is not described as a blind independent rediscovery. No third-party proof source was copied into this package. The earlier [Kabiri project](https://github.com/tahahhsr-code/pisot-ceiling-recurrences) supplied the toolchain/dependency configuration, not proof modules.

License: **Apache-2.0**, as provided in `LICENSE`. Dependencies retain their own licenses. See `NOTICE` for provenance and the scope of the license.
