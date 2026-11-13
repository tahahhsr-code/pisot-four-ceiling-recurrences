# Release audit: PASS

Audit date: 2026-11-13 (Asia/Tehran). This report records source and attribution checks, not a priority certificate or journal acceptance.

## Integrity and statement fidelity

The recovered Mission 2 ZIP passed CRC checking. All 12 hashes in its manifest matched, and all 12 archived files matched the surviving working files byte for byte. Its two Lean files, configuration, dependency manifest, verification scripts, proof and logs remain unchanged under `verified/`. Internal reports and the duplicate README were excluded from the public package. The dependency manifest's nine revisions matched the available checkouts. Lean is pinned to 4.19.0; Mathlib to c44e0c8ee63ca166450922a373c7409c5d26b00b.

The native `ceilingSeq` definition uses rational division, ordinary ceiling, and integer values. The four abbreviations have exactly the pairs (7,9), (8,10), (6,7), (7,8). Each final theorem quantifies over all natural n with n>=4. The last two proofs contain explicit n=4 branches before invoking the one-step shifts. Thus the statements are neither finite-only nor candidate-only, and value subtraction is not truncated natural subtraction.

The preserved log records `lake clean` and `lake build` exits 0. The audit log records all four exact `#check` statements, all 24 theorem axiom reports and exit 0. The existing Python audit was rerun successfully in Mission 3; the accepted axiom set is only propext, Classical.choice and Quot.sound. No source change or mismatch justified another Lean build. Mission 3 relies on the actual Mission 2 build, not a newly claimed build or external certification. The public `SHA256SUMS` records file identities.

## Prior-proof classification

| Result | Documented earlier proof status |
|---|---|
| A048585 / L(6,7) | Public complete mathematical outline in TrureTuring issue 21793; native-sequence Lean theorem in the pinned module and merged PR 27351. The PR reports scoped compilation and accepted axioms. Its build was not rerun here. |
| A048589 / L(7,9) | Mathematical consequence of that earlier L(6,7) result by one-index shifting. PR 27351 and issue 27316 explicitly treat it as the same underlying result. No separate prior theorem declaration for this identifier was established in this review. |
| A048591 / L(8,10) | No prior all-index ceiling-equivalence/recurrence proof identified in the inspected sources. Existing generators and finite-check records do not settle this. Historical priority remains unresolved. |
| A048588 / L(7,8) | Same limitation as A048591. An existing LODA program already states a third-order candidate plus 4, so the candidate representation itself is not claimed as new. |

The release must not advertise four newly solved conjectures or a worldwide first formalization. It may accurately advertise a verified shared implementation for four native ceiling sequences. Public repository proofs and reported compiled formalizations are distinguished from journal publication: no journal-published proof of these exact results was established by this bounded review.

## Sources inspected and search limits

1. [TrureTuring issue 21793](https://github.com/the-omega-institute/trureturing/issues/21793), its body and both returned comments: mathematical outline, finite experiment reference, and subsequent settlement report. The outline explicitly was not initially Lean-verified. Credit belongs to the project contributors; its records disclose Claude Code/Codex work.
2. [PR 27351](https://github.com/the-omega-institute/trureturing/pull/27351), merged 2026-11-06 at 17:58:38 UTC, merge commit `0563c97372a1647f4dad08e507165ce0f032ce14`; [issue 27316](https://github.com/the-omega-institute/trureturing/issues/27316). The PR reports successful scoped checks, not a build independently reproduced in this audit. Unfinished project-specific registration described there is not confused with a missing mathematical theorem.
3. [Pinned native proof module](https://github.com/the-omega-institute/trureturing/blob/67e0167006da3fc4a2d9e10b5a3489775e208777/D5/S1/Recurrence/WilsonPisotL67Recurrence.lean): full file inspected, including the original ceiling definition and final all-index theorem. [License at the same commit](https://github.com/the-omega-institute/trureturing/blob/67e0167006da3fc4a2d9e10b5a3489775e208777/LICENSE): Apache-2.0.
4. [Earlier finite-experiment README](https://github.com/the-omega-institute/trureturing-experiments/blob/7b4764ce90dd69b85f4bf05b9166572d34898d2a/docs/reports/pisot-l67-rec/README.md): explicitly finite checks, not an infinite proof. Its program was not rerun here.
5. [OEIS A048591](https://oeis.org/A048591): retrieved indexed entry; direct live retrieval returned 403. [Pinned OEIS A048588 record](https://github.com/oeis/oeisdata/blob/72c53dd50967ac7166f7d31bf79be95174ec5bc6/seq/A048/A048588.seq): original definition and Wilson attribution checked after live retrieval returned 403. These snapshots are not evidence of current unsolvedness.
6. GitHub searches for each of A048591 and A048588, globally and within TrureTuring's indexed default branch. The latter returned no matches. Global results were followed to the complete relevant files, not accepted from snippets alone:
   - [Sequencelib A048591](https://github.com/provables/sequencelib/blob/dfb06c18bba196b5aa5bcb3725fe9d201fb9a61a/Sequencelib/Synthetic/A048/A048591.lean) and [A048588](https://github.com/provables/sequencelib/blob/dfb06c18bba196b5aa5bcb3725fe9d201fb9a61a/Sequencelib/Synthetic/A048/A048588.lean): synthetic definitions with maxIndex=100 metadata; no all-index target theorem in these files. Their derivation infrastructure was not audited, so no broader negative claim is made. Headers identify CC BY-SA 4.0/GPL-3.0 source provenance; none was copied.
   - [LODA A048588](https://github.com/loda-lang/loda-programs/blob/f1b383b2344ab03ae8f79f41289360a6bd4394bd/oeis/048/A048588.asm) and [A048591](https://github.com/loda-lang/loda-programs/blob/f1b383b2344ab03ae8f79f41289360a6bd4394bd/oeis/048/A048591.asm): candidate-generating code, no all-index ceiling-identification argument in the inspected files.
   - [jOEIS A048591](https://github.com/archmageirvine/joeis/blob/17d03f97bf78ff208819e281e6c95767c8ca3099/src/irvine/oeis/a048/A048591.java) and [A048588](https://github.com/archmageirvine/joeis/blob/17d03f97bf78ff208819e281e6c95767c8ca3099/src/irvine/oeis/a048/A048588.java): constructor wrappers for PisotLSequence, no target proof in these files.
7. Two web search engines queried exact identifiers with “proof recurrence”/“proof”, plus “Pisot” “8,10” proof. Results included old OEIS snapshots, finite sequence matching and irrelevant identifier collisions. No additional exact proof was located. This does not exhaust books, unindexed work, other branches or the world's literature.

## Release authorization and provenance

Taha Kabiri approved a separate public repository named pisot-four-ceiling-recurrences, version v0.1.0, under Apache-2.0, with the stated prior-work attribution and ChatGPT/Codex disclosure. No historical-priority claim is made. The source ZIP and Mission 2 evidence were checked again before publication. Internal proposal metadata and process reports were omitted from the public tree. Both Lean modules, the pinned configuration, proof document, scripts and build/audit logs remain byte-identical to the verified candidate. No new Lean build was required. The public SHA256SUMS covers the resulting files.

The official Apache-2.0 license text is included. Dependencies are not bundled and retain their licenses. No third-party proof source was copied. ChatGPT/Codex's proof implementation, checking and drafting contributions are disclosed in README and NOTICE; no sole human authorship or independent human review is asserted.
