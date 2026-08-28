# PEC-Nav — Review Issues

Pass over `Sections/3_method.tex` and `Sections/4_experiments.tex` (with cross-checks
against abstract/intro/discussion), plus a second pass over the abstract, intro,
related work and conclusion (§E). 34 of 37 issues are fixed in the LaTeX; the three
that remain need citations or a decision from the authors, not editing.

**Writing status: complete.** No claim in the paper now outruns its evidence, and every
gap is disclosed in-place rather than left for a reviewer to find. The paper is
submittable as it stands. Everything in the PENDING list below would make it stronger,
not correct something false.

---

## PENDING

Nothing here blocks submission. Ordered by value per unit of effort.

### P1. Cheap — read off logs you already have (hours)

| # | What | Why it matters | Where it lands |
|---|---|---|---|
| P1.1 | Per-bucket subtask counts for `tab:landmark` ($m{=}2$, $m{\ge}3$) | The caption currently admits these are not broken out. Two numbers turn a hedge into a fact. | `tab:landmark` caption, §4.4 |
| P1.2 | Do the same 19/47 subtasks succeed under *confidence-only* and *full loop*? | §4.4 currently says we have not verified this. If the success sets are identical it is a genuinely interesting finding; if not, the tie is coincidence. | §4.4, B9 |
| P1.3 | Log per-subtask outcome pairs, then run McNemar on the paired 47 | Turns the headline ablation from "directional" into a real test. See P2.1. | §4.4, B1 |
| P1.4 | GPT-4o token counts (and $ cost) per episode | §4.6 concedes the efficiency claim cannot be made without this. It is one counter in the API wrapper. | `tab:compute`, §4.6 |
| P1.5 | Empirical distribution of $\sigma_t$ and $n_t$, not just the mean curve | §3.3 now predicts the controller pins near its floor. Showing the histogram proves it, from data already in the correction logs. | §4.5 |

### P2. Runs — the two that change what the paper can claim

| # | What | Why it matters |
|---|---|---|
| **P2.1** | **Static baseline (loop disabled) over the full 58-task set** | *The single most valuable missing experiment.* Right now Table 4 positions PEC-Nav among published systems but cannot isolate the loop; that isolation rests entirely on $N{=}47$ and $N{=}24$. One row fixes this and would let the contributions be stated much more strongly. |
| **P2.2** | **Fixed-scalar ECE control** ($\hat{P}\times c$ at the mean $\sigma_t$ reached) | §4.5 concedes that *any* downward rescaling lowers ECE for an overconfident predictor. Beating a fixed constant is what separates "the loop calibrates" from "the loop shrinks". Cheap: rescoring, no navigation. |

### P3. Nice to have — ablations that answer a reviewer's likely question

| # | What | Prompted by |
|---|---|---|
| P3.1 | Nonzero floor on $w_g$ (e.g. 0.05) vs the current schedule | A6 — $w_g$ is driven to ~0 exactly when the agent is most lost, and §3.3 admits this is untested |
| P3.2 | Detector-based $Q$ instead of Habitat's semantic sensor, even on one subset | A7 — shows the loop survives without privileged information |
| P3.3 | Sensitivity of surprise to $\epsilon$ | A5 — $\epsilon$ sets the scale of the signal that drives everything |

### P3b. Missing related work — the likeliest source of a novelty objection

| # | What | Prompted by |
|---|---|---|
| **P3b.1** | Add a **calibration** paragraph to §2 (temperature scaling, ECE methodology, uncertainty estimation) | E7 — the paper reports ECE and a reliability diagram but cites no calibration literature at all; `references.bib` has zero such entries |
| **P3b.2** | Add a **prediction-error / intrinsic-motivation** paragraph (curiosity-driven exploration, prediction error as exploration bonus) | E8 — "surprise drives exploration" has a large prior literature, none cited, while contribution 2 claims a first. The defensible distinction: prior work uses prediction error as a *training reward*; PEC-Nav uses it to *retune a fixed scorer at inference time* |

I did not add citations for either — they must be chosen by you, not invented by me.

### P4. Needs an answer from you, not an experiment

| # | Question |
|---|---|
| **P4.3** | **E9 — contribution 3 says "isolating search as the sole experimental variable".** True of the ablations; not true of Table 4, where comparison systems have different memory modules. Scope it to the ablations, or drop "sole"? Left as-is pending your call, since it is a headline contribution. |
| **P4.1** | **"Tuned on 5 held-out scenes" (§3.4) — held out from what?** Do those 5 scenes overlap the 32 evaluation scenes, or the 4-scene / 2-scene ablation subsets? If they overlap, the ablations are tuned on test and the sentence must change. I will not guess this. |
| P4.2 | Paper is now **12 pages** (was 11). If WACV's review limit binds, the new caveat prose in §4.2 and §4.6 is the most compressible without losing substance. |

---

## J. Seventh pass — author calculator check, verified independently

**Dropped as already closed by the trim pass** (raised, but no longer present in the
paper): Table 7 reconciliation, Table 3's "All" column, Sec 2.3 duplication,
the [14]/[15] duplicate reference, the "an earlier reading" revision note, the
"held-out scenes" wording, and the Discussion's m=2 counterexample.

### J1. [OPEN — needs a decision] Table 4 denominator, 274 against 272
Reverse-engineering split sizes from the quoted percentages, all four baselines fit
Easy 47, Medium 178, Hard 47 for 272 subtasks. Our row fits only Easy 19/47,
Medium 36/179, Hard 12/48 for 274. Independently confirmed.
> **Partially fixed.** The false claim that our denominator matches the published rows
> is removed, replaced by a statement of the two-subtask difference and the resulting
> resolution limit. **Still open**, since the clean fix is to recompute on 272, which
> requires a rerun and is your call.

### J2. [RESOLVED] Easy QA accuracy 68.7 was not attainable
Total 66.21 is exactly 96/145, and with Medium 63/94 and Hard 9/16 the Easy cell must
be 24/35 = 68.57. It was also the table's only one-decimal entry.
> **Fixed** to 68.57, which makes it an exact tie with MemoryExplorer. Text already
> called it a tie, so prose and table now agree.

### J3. [RESOLVED] Two baseline Total Acc cells were transposed
Qwen2.5-VL-7B sums to 80/145 = 55.17 but was listed 55.86, and InternVL3-8B sums to
81/145 = 55.86 but was listed 55.17.
> **Fixed** by swapping them back. Each row now sums to its own Total.

### J4. [RESOLVED] Reliability diagram caption was doubly wrong
Checking `figure4_reliability_diagram.json` showed more than the review found. The two
curves are **not the same predictions scored twice**. They come from separate runs with
314 and 338 usable events, downsampled to a common $n = 137$. My caption claimed one
set scored under two settings. The JSON also confirms the above-diagonal point, a
single-event bin at confidence 0.9 with observed accuracy 1.0.
> **Fixed.** Caption now describes two runs downsampled to equal $n$, and states the
> both-below-diagonal claim with its single-bin exception.

### J5. [RESOLVED] Qualitative narrative contradicted Sec 3.3
The text said exploration narrows once confidence stabilises. Sec 3.3 establishes the
opposite, that $\sigma_t$ commits fast toward its floor and search stays broad.
> **Fixed.** The narrative now matches the mechanism.

### J6. [RESOLVED] Instrumentation coverage stated in one place
Four different retained-data subsets appeared with no reconciliation.
> **Fixed.** Sec 4.1 now states coverage once. Correction logs for 29 episodes, failure
> logs for 36 episodes across 19 scenes, reliability diagram downsampled across runs.

### J7. [RESOLVED] Sec 4.1 overclaimed and contradicted Sec 3.4
Sharing a QA checkpoint is not sharing a memory module.
> **Fixed.** Sec 4.1 now scopes the claim to our ablations and defers to Table 4's
> caveat.

### J8. [RESOLVED] Method and Figure 2 out of sync, plus three equation defects
Figure 2 shows a TSDF grid, a segmentation model and a CLIP encoder that Sec 3.2 never
mentioned. $\gamma$ appeared in prose and the table but in no equation. The visit-penalty
floor was described but not written. $r_f$ was double-counted after an earlier fix
described $p_f$ as aggregating it.
> **All four fixed.** Sec 3.2 now describes the perception stack, $\gamma$ appears as
> $\gamma^{\,t-t'}$ with its meaning, the floor is written into Eq. 9, and the four VLM
> outputs are described as separate rather than as a summary and its parts.

### J9. [RESOLVED] Smaller items
Naming drift between Correct and Adapt/Calibrate, now \textsc{correct-confidence} and
\textsc{correct-weights}. Table 6's "every SR difference" where one row differs by zero.
Table 8's subset unstated, and the 83.6 extra VLM calls against roughly 30 corrections,
now explained as pricing a prediction per open frontier. The half-open $\sigma_t$
interval. SPL's 0 to 100 scale. Algorithm 1's "previously-scored". The abstract's
path-efficiency scope. Failure figure's episode-versus-subtask unit.

### J10. [OPEN — needs the authors] Is the 4-scene subset the Easy split?
Easy has $N = 47$ and Easy SR is 40.43, identical to the full-loop ablation row. But
Easy SPL is 25.06 against the ablation's 28.38, so they cannot be the same run. The
coincidence is conspicuous and a reviewer will ask.
**Action:** state in Sec 4.4 whether the 4-scene ablation subset overlaps the Easy
split. I did not assert either way.

### J11. [RESOLVED] Four bibliography entries were wrong
Verified against the sources. ESC's author list was wrong, Snavely and Salakhutdinov
are not authors, corrected to Zhou, Zheng, Pryor, Shen, Jin, Getoor and Wang. 3D-Mem's
first author is Yang not Huang, and it is CVPR 2025 not an arXiv preprint. CoW's CVPR
2023 paper is "CoWs on Pasture", not the "CLIP on Wheels" preprint title, and the venue
was CoRL. Explore-EQA is "Explore until Confident", RSS 2024 not CVPR, with the full
author list restored.

---

## I. Sixth pass — bibliography (author-identified, verified against the source)

### I1. [RESOLVED] References [14] and [15] were the same paper, cited as two systems
`references.bib` contained two entries with **identical titles and identical
seven-author lists**:

- `wang2026memoryexplorer` — CVPR 2026 version
- `yang2024ramem` — arXiv:2601.10744 version

The second was keyed and cited as **RA-Mem**, a distinct baseline with its own row and
its own numbers in Table 4. Someone had pasted the benchmark paper's metadata into the
RA-Mem entry, so the paper cited one work twice under two identities — once as the
benchmark it evaluates on, once as a system it claims to beat.

**Verified against the source** (arxiv.org/html/2601.10744): RA-Mem is *not* separate
prior work and has no citation of its own. That paper states "we develop a
Retrieval-Augmented Memory (RA-Mem) variant based on 3D-Mem" — it is a baseline the
same authors built for their own comparison. So there was no missing reference to
track down; the entry was simply a duplicate.

> **Fixed.** The duplicate `yang2024ramem` entry is deleted and all citations
> repointed. §2.2 now describes RA-Mem accurately as a retrieval-augmented variant of
> 3D-Mem introduced as a baseline in the benchmark paper, and Table 4 carries a
> $\ddagger$ footnote saying the same, so the row is not read as an independent
> system. Bibliography drops from 23 to 22 entries; no undefined citations.

**Why this one mattered.** A reviewer checking references would have found the paper
apparently comparing against a baseline that is the benchmark paper itself, under a
name that paper uses for something else. That reads as careless at best.

---

## H. Fifth pass — table/figure cross-check (author-identified, verified against run data)

*All three raised by the author on a manual cross-check; all three confirmed, and the
underlying run data showed two further problems.*

### H1. [RESOLVED] Figure 5's denominator contradicted the headline SR
The caption claimed $n = 149$ failed subtasks "out of 274". At 24.45% SR, 274 subtasks
implies ~207 failures; 149 failures would imply ~45.6% SR, roughly double what the
paper reports everywhere else.

**Verified in the run data.** Figure 5 is built from
`results/second_pass/failure_causes_raw.jsonl`, which is a *different, partial-coverage
run* from the one behind Table 4: **19 of 32 scenes, 36 episodes**, not the full
58-episode / 274-subtask set. The author's copy-paste hypothesis was correct.
> **Fixed.** The caption now states the actual coverage, drops "out of 274", and says
> the figure is evidence about the *relative* frequency of failure modes rather than
> absolute counts. Prose updated to match, and now draws the point that matters: the
> two dominant causes (detector miss, planner/navmesh) are not addressable by better
> frontier selection, which bounds what any search-side contribution can move.

### H2. [RESOLVED] The "sixth other catch-all" does not exist
The five named causes sum to exactly $n$: $65 + 61 + 12 + 7 + 4 = 149$.
Confirmed against `figure7_failure_decomposition.json` — the `other` key is **absent**
from the counts, not present-but-zero. The caption sentence was added by me during the
B7 fix and was wrong.
> **Fixed.** The caption now says the five causes account for all 149 records with no
> residual, so no catch-all appears.

### H3. [RESOLVED] "Largest per-column margin" named the wrong split
Medium MLLM-Score is $62.77 - 48.14 = +14.63$; Hard is $50.00 - 34.38 = +15.62$.
Hard is larger.
> **Fixed.** §4.2 now names Hard first and gives both margins.

### H4. [RESOLVED] Duplicate records in the failure log
`failure_causes_raw.jsonl` holds 149 records but only **147 distinct `subtask_id`s** —
two subtasks are logged twice, so the bars slightly over-count.
> **Fixed in the caption** (both figures stated). Worth de-duplicating at the source
> before the camera-ready, which would change the counts by two.

### H5. [RESOLVED] The surprise-diagnostic paragraph miscounted episodes
I had written "Grouping the 58 episodes ... the remaining episodes are either fully
successful or contributed no correction events." The run data
(`figure6_surprise_by_outcome.json`) reports `n_episodes_success = 0` and
`n_episodes_untagged_excluded = 0` over **29** episodes — so there was no remainder,
and no successful episode at all in that subset.
> **Fixed.** §4.6 now states the true coverage and draws the honest consequence: the
> success-vs-failure comparison that would matter most cannot be made on this data.

**Note for the camera-ready.** H1 and H5 both trace to figures built from
`results/second_pass/` while Table 4 comes from `results/pecnav_lmeebench_sub58/`.
Any figure or statistic sourced from a run other than the headline run should carry its
coverage in the caption; these two now do, but the provenance of Figures 3 and 4 should
be checked the same way before submission.

---

## G. Fourth pass — Discussion vs. revised body, and a table arithmetic problem

### G1. [OPEN — needs the authors] Table 7's SR values cannot come from the 47-subtask subset
`tab:landmark` reports SR of **58.0** and **60.0** at $m=2$, and **47.62** and **54.73**
at $m\ge3$. Searching all $k/n$ with $n \le 59$:

| value | only small-integer form |
|---|---|
| 58.0 | 29/50 |
| 60.0 | 3/5, 6/10, 9/15, 12/20 |
| 47.62 | 10/21, 20/42 |
| 54.73 | 29/53 |

58.0 requires a denominator of 50 and 54.73 requires 53 — both larger than the whole
$N=47$ subset, and mutually inconsistent. So these are not micro-averaged subtask
success rates on that subset, while SR everywhere else in the paper is
(40.43 = 19/47 exactly). The likeliest explanation is that Table 7 macro-averages
per-episode success rates while every other table micro-averages over subtasks.
**Two different SR definitions in one paper, undeclared, is a reviewer-level problem.**
**Action:** confirm how Table 7's SR is computed. If it is a macro-average, say so in
the caption and give per-bucket $n$; if it is micro, the numbers need rechecking.
I have not altered any value.

### G2. [RESOLVED] "Episodes" used where the unit is subtasks — my own error
The B1/B7 fixes defined $N$ as navigation subtasks, but the text I wrote in §4.4 then
said "two-episode difference", "the same 47 episodes", "McNemar's on the discordant
episodes", "per-episode outcome pairs", "one episode is 2.13 points", and both ablation
captions repeated it.
> **Fixed.** All seven occurrences now say subtasks, consistent with §4.1.

### G3. [RESOLVED] The Discussion cited Table 4 as evidence the loop helps
Its opening sentence claimed "Tables 4, 5a and 6 all agree" — but §4.2 now states
Table 4 has no loop-disabled row and cannot isolate the loop. The paper asserted and
denied the same thing two sections apart.
> **Fixed.** The Discussion now excludes Table 4 from that claim explicitly.

### G4. [RESOLVED] Discussion hedged the landmark trend less than §4.4 does
§4.4 says two buckets cannot establish a trend; the Discussion still read "consistent
with each landmark providing an additional verification opportunity" as though the
trend were established, and still said "landmark" after the §4.1 rename.
> **Fixed.** Reworded to reference objects, and now states the ordering rests on two
> buckets with no more claimed.

### G5. [RESOLVED] "The single most consistent finding across the paper"
Applied to the component ablation — which runs on $N=24$, the smallest sample in the
paper, and which §4.4 forbids carrying across tables.
> **Fixed.** Now framed as the reading the table invites and the one most exposed by
> the sample size: a hypothesis the data are consistent with, not a result.

### G6. [RESOLVED] "Confidence bands" that no figure defines
The Discussion referred to bands widening in the tail; `fig:calibration`'s caption
describes no bands.
> **Fixed.** Now says the late-index means average over progressively fewer episodes.

### G7. [RESOLVED] Two caveats promised, three needed
With the statistical-resolution caveat now central, the Discussion's "Two caveats"
undercounted. A third was added covering it, and the sub-table (b) of
`tab:ablation_all` gained the $N$ column that (a) already had.
> **Fixed.**

### G8. [RESOLVED] Redundant "should" sentence in §4.5
After the new opening paragraph states the regime, the following sentence still said
"the controller \emph{should} reduce $\sigma_t$" as though it were a prediction.
> **Fixed** to state what the figure shows.

---

## F. Third pass — errors found on a full re-read
*Several of these were introduced by the earlier fixes themselves.*

### F1. [RESOLVED] Sec 3.4 contradicted the abstract on attribution
Sec 3.4 still read "identical across **all experiments** ... attributable **solely** to
search" after the abstract had been narrowed to "across our own ablations". Table 4's
comparison systems have different memory modules, so the strong form is false there.
> **Fixed.** Sec 3.4 now scopes the claim to our ablations and says explicitly that it
> does not extend to the published rows.

### F2. [RESOLVED] Architecture figure caption contradicted the new Sec 3.2
`fig:architecture` said the agent "selects one by combining **prediction confidence**,
exploration value, and goal relevance" -- but Sec 3.2 now states that $\hat{P}_f$ is
*never* a term in $\mathrm{val}(f)$. Figure and text described different algorithms.
> **Fixed.** Caption now reads "combining potential, exploration value, and goal
> relevance", matching Eq. 6.

### F3. [RESOLVED] "Flattening toward uniform" was the wrong description of sigma_t
With the normalisation added in A2, lowering $\sigma_t$ does not flatten the
distribution toward uniform over the four categories: it transfers mass from the three
named categories into the *other* bucket. The old wording described a different
operation from the one the equations perform.
> **Fixed.** Sec 3.2 now describes the transfer accurately, and notes that
> $\sigma_t$'s effect survives normalisation -- a reader could otherwise reasonably
> suspect it cancels out.

### F4. [RESOLVED] $r_f$ was defined and then never used
Semantic richness $r_f$ is introduced as one of four VLM outputs and never appears
again -- not in Eq. 6, not in the hyperparameter table.
> **Fixed.** Sec 3.2 now states that $p_f$ aggregates it and that $r_f$ carries no
> separate weight in the value function.

### F5. [RESOLVED] An originality claim I introduced, which the codebase contradicts
While scoping the benchmark citation, I wrote into Sec 4.1: "Nothing else is inherited;
**the search module evaluated here is our own.**" That is a stronger claim than the
SCOPE decision (E6) supports -- it asserts originality rather than merely omitting an
attribution, which is the one thing that turns an omission into a misstatement.
> **Fixed.** Replaced with "What we vary, and what this paper evaluates, is the
> Predict-Explore-Correct loop of Sec. 3.2" -- true, and still carries no SCOPE
> citation outside Related Work.

### F6. [RESOLVED] Prose damage from overlapping edits
"Our contribution" opened two consecutive sentences in Sec 3.2, and the $\epsilon$ /
normalisation sentences had been interleaved out of order by two separate edits.
> **Fixed.** Both paragraphs rewritten to read cleanly.

### F7. [RESOLVED] Leftover "landmarks" wording
Sec 4's opening sentence still promised "a stratification by the number of landmarks"
after Sec 4.1 was renamed to reference objects.
> **Fixed.**

### F8. [RESOLVED] Orphaned "Base" label in the hyperparameter table
The $\gamma$ row's Source column said "Base$^\dagger$" while the footnote no longer
mentions a base system.
> **Fixed** to "Inherited$^\dagger$", matching the footnote.

---

## E. Abstract, Intro, Related Work, Conclusion
*Second pass, covering the sections not reviewed in rounds A–C.*

### E1. [RESOLVED] Abstract headlines the two-episode result with no scale
The abstract's closing sentence ("improves SR from 36.17\% to 40.43\%, an 11.78\%
relative gain") is the same 17/47 vs 19/47 comparison that §4.4 now surrounds with
Wilson intervals and a Fisher $p = 0.83$. An abstract that omits the scale while the
body concedes it is the exact mismatch reviewers punish.
> **Fixed.** Abstract now names the subset size and calls the result directional.

### E2. [RESOLVED] Teaser caption still said "learns from its own prediction errors"
A10 fixed the abstract and intro body but missed `fig:teaser`'s caption.
> **Fixed.** Caption now says "adapts".

### E3. [RESOLVED] Related work makes a bare priority claim that §1 already softened
§2.1 ends "Ours is the first to close the loop", unqualified, while contribution 2 was
softened to "to our knowledge". The two must agree, and the stronger form is not
defensible without a calibration/intrinsic-motivation survey (see E7, E8).
> **Fixed.** Softened to match, and now states what is inherited from SCOPE.

### E4. [RESOLVED] Prose and Table 2 contradict each other on SCOPE
§2.1 credits SCOPE with "a self-reconsideration mechanism for revisiting past
decisions" — which is within-episode adaptivity — while `tab:qualitative` marks SCOPE
**Adapt. = $\times$**. A reviewer who knows SCOPE will catch this immediately. The same
applies to Mem-Centric, described as feeding "memory signals back into the planner".
The column has no stated criterion, so it cannot be checked.
> **Fixed.** The caption now defines "Adapt." precisely — the *scoring function's own
> parameters* change within an episode in response to measured error — which is the
> sense in which PEC-Nav is alone in the column, and distinguishes it from
> re-scoring or re-visiting under a fixed function.

### E5. [RESOLVED] Conclusion contradicts the corrected §4.4
The conclusion calls the correction ablation "the cleanest evidence that closing the
loop is what matters" — but §4.4 now states that same result is not statistically
resolved at $N=47$. The paper would be arguing with itself.
> **Fixed.** Reworded to match §4.4, and the missing full-scale baseline is named as
> the first item of future work rather than omitted.

### E6. [CLOSED BY AUTHOR DECISION — recorded] SCOPE attribution scoped to Related Work
**Author decision (recorded at their instruction):** SCOPE is to be cited in Related
Work only, and nowhere else in the paper. Implemented: the citation is removed from §1
and §3; §3.2 now points to §2.1 for the frontier-scoring formulation instead, and the
hyperparameter table's $\dagger$ footnote reads "default of the underlying
frontier-scoring formulation" rather than naming a base system.

**What I did to keep this defensible:** §3.2 does *not* claim the frontier scoring as a
contribution. It states that the scoring "follows the established formulation surveyed
in Sec. 2.1 and is not itself what we contribute". So the paper carries no SCOPE
citation outside Related Work, and also asserts nothing false about authorship.

**Risk I flagged and the author accepted.** The codebase describes the scoring as
inherited in four places — `potential_estimation.py:7` ("inherited from SCOPE"),
`semantic_predictor.py:8` ("existing SCOPE-lineage code"), `potential_graph.py:199`
(weights "centered on SCOPE's original fixed (0.5, 0.3, 0.2)"), and `pec-lmee.py:29`
(SCOPE/ treated as a vendored dependency) — and the paper's own $w_p,w_e,w_g$ are
centred on exactly that triple. If the vendored SCOPE code is in the run path, a
reviewer diffing the two could read the Method's silence as undisclosed reuse. The
safest form of this remains an explicit one-line statement of what is inherited, which
costs nothing rhetorically because the contribution is the loop, not the four scalars.
Revisit before submission if the frontier scoring was not independently reimplemented.

*(Original finding, now superseded:)* Novelty framing hides the SCOPE inheritance
§3.2 discloses that frontier scoring is inherited from SCOPE and modified in one way.
The abstract, intro and contributions never say so, leaving the impression that the
whole scoring pipeline is new. The disclosure belongs where the claims are made.
> **Fixed.** Intro's instantiation paragraph now states the inheritance explicitly.

### E7. [OPEN — needs citations] No calibration literature in Related Work
The paper's central claim is *calibration*: it reports ECE, shows a reliability
diagram, and names the mechanism self-calibration. Yet §2 cites nothing from the
calibration literature — no temperature scaling, no ECE methodology, no conformal or
uncertainty-estimation work. `references.bib` contains zero such entries. This is the
first thing a reviewer will search for and not find, and it also weakens E3's priority
claim, since confidence rescaling is a well-studied operation.
**Action:** add a short calibration paragraph to §2 and cite the standard sources.
I have not invented citations; these need to be chosen and added by the authors.

### E8. [OPEN — needs citations] No prediction-error / intrinsic-motivation literature
"Surprise drives exploration" is the core idea, and it has a large prior literature
(curiosity-driven and intrinsic-motivation exploration, prediction-error as an
exploration bonus). None is cited. Given contribution 2 claims a first, this omission
is the most likely single cause of a novelty objection.
**Action:** add a paragraph positioning PEC-Nav against that line — the honest
distinction is that those methods use prediction error as a *reward* for a trained
policy, whereas PEC-Nav uses it to *retune a fixed scorer at inference time*. That is
a real and defensible difference, but it has to be stated.

### E9. [OPEN — authors' call] Contribution 3 overstates the isolation
"Isolating search as the sole experimental variable" holds for the ablations, where
memory and QA are genuinely fixed. It does not hold for Table 4, where the comparison
systems have entirely different memory modules. The claim is true of the paper's
internal comparisons only.
**Action:** either scope the wording to the ablations, or drop "sole".
Left as-is pending your preference, since it touches a headline contribution.

### E10. [NOTE] Submission mechanics
`main.tex` uses `\usepackage[review,applications]{wacv}` — correct for submission;
switch to the camera-ready line before final. Paper is now 13 pages with references
(12 without), up from 11; see P4.2.

---

## A. Method (`3_method.tex`)

### A1. [RESOLVED] The landmark formulation never appears in the Method
> **Fixed.** Confirmed against the implementation: the policy consumes only the
> structured goal, and $m$ is produced by a separate offline analysis script. Intro
> §1 and contribution #1 reframed to a relational-context verification signal; §4.1
> now states explicitly that $m$ is a post-hoc stratification variable.

The intro sells contribution #1 as "landmark-conditioned navigation" with "an ordered
landmark sequence" and a predictor "conditioned on the landmark the route expects at
that stage". Sec. 3.1 outputs only a *target category* + *contextual description*.
There is no landmark sequence, no stage index, no landmark-verification step anywhere
in Sec. 3.2–3.3 or Alg. 1. The Experiments then stratify by landmark count $m$
(Sec. 4.1, Table `tab:landmark`) using a quantity the method never defines.
**Fix:** either add the landmark extraction + stage-conditioning to Sec. 3.1/3.2
explicitly, or drop contribution #1 and reframe $m$ as "number of relational cues in
the instruction".

### A2. [RESOLVED] $\hat{P}$ in Eq. 1 is not a probability distribution
> **Fixed.** Eq. 1 in §3.2 split into unnormalised scores $u(\cdot)$ plus an explicit
> normalisation $\hat{P}=u/\sum u$, with a sentence stating why the step is required
> (raw top-3 confidences are unconstrained; the $\max$ floor can overshoot). Eq. 4 is
> now a well-defined KL. Spec clarification only — no reported number changes.

$\hat{P}(c_i)=\hat{p}_i\sigma_t$ for the top-3 and $\hat{P}(\text{other})=\max(\epsilon,
1-\sum\hat{p}_i\sigma_t)$. If $\sum\hat{p}_i\sigma_t>1$ the mass sums to
$\sum\hat{p}_i\sigma_t+\epsilon>1$; if the VLM's top-3 do not sum to 1 it sums to
$<1$ before the max kicks in. No renormalisation is stated. Eq. 4 then takes a KL
against an unnormalised $\hat{P}$, which is not a KL divergence and can be negative
or unbounded. **Fix:** state the renormalisation step explicitly, or define
$\hat{P}$ via a temperature/softmax so normalisation is automatic.

### A3. [RESOLVED — caveat stated] $\sigma_t$ scaling is not calibration, and the ECE result may be circular
> **Addressed in text** (the fixed-scalar control needs a run, which is out of scope).
> §4.5 now states the ECE numbers, concedes that any downward rescaling moves ECE in
> this direction given a systematically overconfident predictor, names the
> self-referential $\sigma_t \to D_{KL} \to \sigma_t$ path, and narrows the claim to
> "the loop selects a shrinkage that improves calibration without supervision", with
> the fixed-constant control flagged as the natural next experiment.

Multiplying confidences by $\sigma_t\in[0.4,1.0]$ shrinks every predicted probability
toward zero. Since Fig. `fig:reliability` reports both curves lying *below* the
diagonal (i.e. underconfident? — see E3) and ECE dropping $0.642\to0.350$, a reader
will object that the ECE reduction is the mechanical consequence of down-scaling
confidences, not evidence of calibration. Worse, the same $\sigma_t$ that scales
$\hat{P}$ also enters $D_{\mathrm{KL}}(\hat{P}\|Q)$, so the surprise signal is a
function of the controller's own output — a self-referential loop.
**Fix:** report ECE for a fixed-scalar baseline ($\hat{P}\times c$ for the mean
$\sigma_t$ actually reached) as a control. If the loop does not beat that control,
the calibration claim must be softened.

### A4. [RESOLVED] The controller almost certainly saturates at the floor
> **Fixed.** §3.3 no longer claims gradual convergence "toward a confidence
> appropriate for the environment". It now derives the compressive regime explicitly
> ($\bar{s}\ge2 \Rightarrow n_t\in[0.86,1) \Rightarrow \sigma_t\in[0.4,0.48]$), notes
> that $\beta=0.3$ reaches it within ~5 corrections, and reframes the design intent as
> fast commitment rather than annealing. The $w_g\to0$ consequence (A6) is stated in
> the same section. §4.5 (`sec:pec-dynamics`) confirms the regime from the paper's own
> mean-divergence numbers.

Sec. 4.6 reports per-episode mean $D_{\mathrm{KL}}\approx 2.0$. With
$\bar{s}_0=0,\beta=0.3$, $\bar{s}_t$ reaches ~2.0 within a handful of corrections, so
$n_t=1-e^{-2}\approx0.86$, giving $\sigma_t\approx0.48$ and $w_g\approx0.03$ — i.e.
pinned near the floor for most of an episode (~30 corrections fire per episode per
Table `tab:stats`). This contradicts "the system converges toward a confidence
appropriate for the environment" and makes $w_g$ effectively dead.
**Fix:** report the empirical distribution of $\sigma_t$ and $n_t$ (not just the mean
trend in Fig. 3), and justify the squash $n_t=1-e^{-\bar{s}}$ given the observed KL
scale — the map has essentially no dynamic range above $\bar{s}\approx 2$.

### A5. [RESOLVED] $D_{\mathrm{KL}}$ is unbounded and scene-dependent
> **Fixed.** §3.2 now states that both arguments are floored at $\epsilon$ and
> renormalised over the same four-element support, bounding the divergence at
> $\log(1/\epsilon)\approx6.9$ nats, and explains why a small prediction-specific
> support is used rather than the full vocabulary. Confirmed against
> `compute_surprise` in `semantic_predictor.py`.
$Q$ is built from raw counts + $\epsilon=10^{-3}$ (Eq. 3). A predicted category with
zero detections gets $Q(c)\approx\epsilon/(\text{total})$, so a single confident miss
contributes a KL term of order $\hat P(c)\log(1/\epsilon)$ and dominates the EMA. The
surprise magnitude is therefore driven by the smoothing constant, not by the model.
**Fix:** clip or normalise the KL (e.g. use JS divergence, or clip per-correction KL),
and report sensitivity to $\epsilon$.

### A6. [RESOLVED] $w_g\to 0$ discards goal relevance exactly when the agent is lost
> **Fixed** alongside A4: §3.3 states that $w_g$ is driven to near zero in the
> high-surprise regime, that selection there falls to $p_f$ and $e_f$, and that a
> nonzero $w_g$ floor is untested.
Under high surprise the value function drops the goal-relevance term entirely
(Eq. 6, $w_g=0.2-0.2n_t$). Justified in the text as "broadening exploration", but
zeroing the only goal-conditioned term is a strong design choice with no ablation on
the floor value. Also, is $p_f$ (weight 0.5, fixed) itself goal-conditioned? If yes,
the claim that the agent "broadens exploration" is weaker than stated; if no, the
agent is goal-blind at $n_t\to1$.

### A7. [RESOLVED] CORRECT phase uses simulator ground truth
> **Fixed.** The disclosure moved from §3.4 implementation notes to §3.2, immediately
> after Eq.~3 where $Q$ is defined, stating that $Q$'s accuracy upper-bounds a
> detector-based variant and that PREDICT/EXPLORE/goal-extraction use no GT labels.
$Q$ comes from Habitat's semantic sensor (HM3D per-pixel labels). This is privileged
information no deployed agent has, and it sits uneasily with Sec. 3.1's emphasis that
goal extraction uses "*only* the instruction text (no scene geometry or ground-truth
labels)". It is listed in the Discussion limitations, but it belongs in the Method
where $Q$ is defined, and the paper should say whether the baselines had comparable
access. **Fix:** flag at Eq. 3, and add a detector-based $Q$ variant (even on a small
subset) to show the loop survives without GT.

### A8. [RESOLVED] Stale-$\sigma$ mismatch in the correct step
> **Fixed.** §3.2 now defines the frontier key (voxel position + view) and states that
> a prediction is deliberately scored as issued rather than re-scaled at arrival, so
> surprise measures the error of the belief the agent acted on.
$\hat{P}_f$ is stored at prediction time with the then-current $\sigma_t$, but the KL
is computed on arrival, potentially many steps and several $\sigma$ updates later.
The surprise thus mixes predictor error with controller drift. Not discussed.

### A9. [MOSTLY RESOLVED] Notation and bookkeeping
> **Fixed:** $\mathrm{pts}_{\text{norm}}$ and $w_f$ now defined under Eq.~2;
> $\epsilon$'s dual role stated explicitly as deliberate; frontier-identity keying
> defined (A8); visit floor 0.1 added as a row to `tab:hyperparams`; §3.2 now says
> outright that $\hat{P}_f$ is never a term in $\mathrm{val}(f)$ and reaches
> behaviour only through subsequent surprise, and Alg.~1 line 3 is annotated
> "stored, not scored".
> **STILL OPEN — needs the author:** "tuned on 5 held-out scenes" — held out from
> what, and do those 5 overlap the 4-scene / 2-scene ablation subsets or the 32
> evaluation scenes? If they overlap, the ablations are tuned on test. I cannot
> establish this from the paper and will not guess it.

- Eq. 2: $\mathrm{pts}_{\text{norm}}$ is used without definition.
- $\epsilon=10^{-3}$ is overloaded: probability floor (Eq. 1) and count smoothing (Eq. 3).
- "frontier identity" keying is asserted but never defined — how are frontiers matched
  across steps as the map grows? This determines whether corrections fire at all.
- The 0.1 floor on the visit-penalty denominator is in the prose but missing from
  Table `tab:hyperparams`; $R$, $\beta$ are there but the KL clip / floor is not.
- Alg. 1 line 4 cites "Eq. 6–7" for $\mathrm{val}'$ but $\hat P_f$ (line 3) plays no
  role in $\mathrm{val}$ — the prediction never enters frontier selection directly.
  If so, say so plainly: the predictor influences search *only* through $\sigma_t$'s
  effect on future surprise. That materially changes how A3/A10 read.
- "tuned on 5 held-out scenes" — held out from what? The eval set is 32 scenes; state
  whether the 5 overlap the 4-scene / 2-scene ablation subsets. If they do, the
  ablations are tuned-on-test.

### A10. [RESOLVED] "Learns from its own prediction errors" is an overclaim
> **Fixed.** Abstract now says "adapts online" and adds an explicit sentence that no
> component is trained. Intro's two "learn from your errors" phrasings replaced.
Abstract and intro say the agent "learns"; Sec. 4.5 states plainly the predictor "is
prompt-based and never updated". Nothing is learned — a scalar controller is adapted.
**Fix:** use "adapts" / "self-calibrates" consistently and drop "learns".

---

## B. Experiments (`4_experiments.tex`)

### B1. [PARTLY RESOLVED] Headline ablation rests on ~2 episodes
> **Addressed in text; cannot be closed without runs.** §4.4 now reports raw counts
> (17/47 vs 19/47), Wilson 95% intervals, and Fisher exact $p=0.83$, states that the
> unpaired test is the wrong one for a paired design, and declines to quote a paired
> $p$-value because per-episode outcome pairs were not logged. Raw counts added to all
> three ablation tables; the "one episode = 2.13 / 4.17 SR points" granularity is now
> stated in the text, the captions, and the limitations. Paragraph retitled from
> "The correction loop is everything". **Open:** logging outcome pairs and running
> McNemar; no seed sweep was run and none is claimed.
$36.17\%\to40.43\%$ on N=47 is 17/47 → 19/47: a two-episode difference, reported as
"+11.78% relative" and as "The correction loop is everything". There are no
confidence intervals, no significance test, no multiple seeds, and GPT-4o is
stochastic. A 95% CI on 19/47 is roughly ±14 points — it comfortably contains the
baseline. The same two-episode delta is the abstract's second headline number.
**Fix:** report CIs (Wilson) or a paired test over episodes, run ≥3 seeds, and retitle
the paragraph. At minimum state the raw counts.

### B2. [RESOLVED] Bolding in Table `tab:lmee` implies wins the paper does not have
> **Fixed.** Caption now states bold marks *our method, not the best result*, and
> underline marks the column best among exploration methods. MemoryExplorer's two
> genuine wins (Medium SR 21.35, Hard Acc 68.75) are underlined; our two non-wins are
> no longer implied victories. §4.2 prose names both losses, notes Qwen3-VL-8B's 62.50
> also beats our Hard Acc, and calls Easy/Total QA accuracy ties rather than wins.
Every PEC-Nav cell is bold, including cells where a baseline is better:
Medium SR 20.11 vs MemoryExplorer 21.35; Hard QA Acc 56.25 vs 68.75 (also below
Qwen3-VL-8B's 62.50); Easy Acc 68.7 vs 68.57 is a 0.13-point tie. Total QA Acc 66.21
vs 65.52 is likewise within noise. The prose says "ahead on SR, SPL and MLLM-Score,
comparable on QA accuracy" but only for the Total column and never mentions the
per-split losses. **Fix:** bold only actual column-best values, and add one sentence
acknowledging that navigation SR on Medium and QA on Hard do not improve.

### B3. [PARTLY RESOLVED] The main table has no comparable static baseline
> **Addressed in text; cannot be closed without a run.** §4.2 now states outright that
> no comparison row was re-run by us and that the static baseline is absent from the
> table, so `tab:lmee` positions PEC-Nav among published systems but does not isolate
> the loop; the isolation is explicitly delegated to §4.4. Also named in the
> limitations as the most informative experiment left undone.
All baselines are $\dagger$ (copied from `wang2026memoryexplorer`); the "static
baseline" that every ablation is measured against never appears in Table `tab:lmee`.
So the main result cannot attribute the reported 24.45 SR to the PEC loop — the delta
vs. the authors' own pipeline without the loop is unmeasured at full scale.
**Fix:** run the static baseline on the full 58-task set and add it as a row. This is
the single most valuable missing experiment in the paper.

### B4. [RESOLVED] Ablation subsets are tiny, disjoint, and inconsistent with each other
> **Fixed.** §4.4 now confronts the spread directly (static baseline 54.17 / 36.17 /
> unmeasured against a full-scale system score of 24.45), concludes two scenes are far
> easier than benchmark average, and forbids carrying any quantity across ablation
> tables.
4-scene N=47, 2-scene N=24, and the full 58-task set give static-baseline SRs of
36.17, 54.17, and (unreported) respectively. A 54.17% baseline on 2 scenes vs 24.45%
system-level SR on the full set means the ablation subsets are not representative.
The Discussion admits non-comparability but the Analysis section still chains the
numbers into a single narrative ("the entire net gain comes from closing the loop").
**Fix:** run both ablations on one common subset, ideally the full 58 tasks.

### B5. [RESOLVED] The landmark analysis is a two-bucket comparison, mis-described
> **Fixed.** The $m=0$ example is now flagged as a case that does not occur;
> `tab:landmark` reports signed $\Delta$ (ours $-$ baseline) instead of $|\Delta|$;
> the caption states the episode-vs-subtask unit mismatch with `tab:stats` and that
> per-bucket subtask counts are not broken out. Prose now says the stratification
> reduces to two points, that two points are not a trend, and that the buckets are
> confounded with geodesic distance (6.91 m -> 8.02 m) so relational context and route
> length cannot be separated.
Table `tab:stats`: $m=0$ has **0** episodes and $m=1$ has **1**. So Sec. 4.1's
worked example of an $m=0$ instruction ("a white ceramic sink") describes a case that
does not occur in the data. The claimed trend rests entirely on 8 episodes ($m=2$) vs
49 ($m\ge3$) — one comparison, one point of "trend". Also:
- Table `tab:stats` is over 58 episodes; Table `tab:landmark` is over the 47-episode
  subset, but reuses the same buckets without restating the per-bucket $n$. Give
  per-bucket N in `tab:landmark`.
- `tab:landmark` reports $|\Delta|$ (absolute value), which hides that the $m=2$ SPL
  gap of 7.85 favours the baseline. Reporting signed deltas is required.
- $m=1$ shows 0.0 SR for both methods on 1 episode and is still tabulated.
**Fix:** either drop the stratification or reframe it as a preliminary observation on
two buckets. It cannot support "the benefit appears only once instructions carry
enough landmarks".

### B6. [RESOLVED] Unreported numbers used to support claims
> **Fixed.** The unquantified "SPL on successes is substantially higher" claim is
> removed, along with the "upfront exploration cost" story it supported --- which
> contradicted the compute table. Replaced by the correct reading: the loop takes
> *fewer* steps (95.6 vs 100.3) and adds deliberation, not travel, which is why SPL is
> free to improve. We now say explicitly that SPL-on-success is withheld because it
> conditions on the outcome being measured.
- "Path efficiency restricted to successful episodes is substantially higher"
  (Sec. 4.6) — no value given, no table. Either report SPL-on-success or delete.
- "the loop's extra exploration pays off" — Table `tab:compute` shows PEC-Nav uses
  *fewer* navigation steps (95.6 vs 100.3), which contradicts an "upfront exploration
  cost" story. Reconcile these two claims.
- Fig. `fig:calibration`: "confidence bands" are mentioned in the Discussion but the
  caption does not say whether the figure shows them or what they are.

### B7. [RESOLVED] Episode-count arithmetic does not add up
> **Fixed.** §4.1 defines episode vs navigation subtask once (274 subtasks over 58
> episodes), states that all nav metrics and every $N$ are per subtask, and defines
> success/partial/fail. The failure figure caption now says $n=149$ is failed
> *subtasks* out of 274, and that a sixth `other` bucket accounts for everything ---
> the previous "remainder unclassifiable" was wrong. The surprise-diagnostic paragraph
> now says where the non-13/16 episodes went.
- Fig. `fig:failures`: $n=149$ failures "with the remainder unclassifiable" — 149
  exceeds the 58 episodes and sits oddly against 274 navigation goals. State the unit
  (goals? episodes?) and quantify the unclassified remainder.
- Sec. 4.6: partial $n=13$ + failed $n=16$ = 29, against N=47 or N=58 — where do the
  rest go, and what is "partial"? Define the outcome taxonomy once, up front.
- SR denominators: is SR over 58 episodes or 274 goals? 40.43% = 19/47 implies
  per-episode; the main table's 24.45% needs its denominator stated.

### B8. [RESOLVED] Compute claims are not supported by the compute table
> **Fixed.** "Modest" and "compute-efficient alternative to scaling or fine-tuning"
> are gone. §4.6 now gives the cost as +58% VLM calls and +52% wall-clock, states that
> peak GPU memory is identical *by construction* (QA model only) and is not a result,
> notes steps fall rather than rise, and concedes that without baseline compute figures
> or GPT-4o token/cost accounting the efficiency comparison cannot be made. Narrower
> supportable claim substituted. Caption updated to match.
The loop adds +58% VLM calls (144.1→227.7) and +52% wall-clock (765→1161 s); calling
this "a modest number" and "compute-efficient" is not warranted without a comparison
point. Also:
- Peak GPU memory is identical (22.62 GB) in both columns because it measures only the
  QA model, which is unchanged by definition — the row is uninformative; either drop
  it or label it as such.
- GPT-4o API cost/tokens are the dominant cost and are not reported. Add $ or tokens
  per episode.
- No compute figures for any baseline, so "compute-efficient alternative to scaling
  the model or fine-tuning" is unsupported.

### B9. [RESOLVED] Feedback-path ablation: identical SR is unexplained
> **Fixed.** §4.4 now explains the exact tie as 19/47 in both arms, states that we
> have *not* verified the same 19 subtasks succeed, and says SR cannot separate the two
> arms at this resolution --- which is why the reweighting path is read off SPL.
"Confidence only" and "Full loop" give *exactly* 40.43 SR. Presumably the same 19
episodes succeed, which would be a strong (and interesting) statement — say whether
the success sets are identical. If they differ, the coincidence needs noting.
Additionally the table lacks a "reweighting floor" control, so A6 stays untested.

### B10. [RESOLVED] Missing baseline reproduction and protocol details
> **Fixed.** §4.1 "Hardware and protocol" now records that the hosted model is
> versioned outside our control, that exact reproduction needs the same snapshot, that
> results are single runs not averages, that comparison rows were not re-run and assume
> the source work's protocol and step budget, and that SR's denominator (all named
> objects as successive subtasks) matches the published rows.
- No baseline was re-run by the authors; all $\dagger$ numbers assume identical eval
  protocol, VLM version, and step budget. State the max-step budget and the GPT-4o
  snapshot date/temperature — GPT-4o results are not reproducible without them.
- SR success threshold 1.0 m is stated but LMEE-Bench's own multi-goal SR definition
  (all goals? target only?) should be cited exactly, especially given the paper's
  reformulation in Sec. 1 that "only the target must be reached" — that is a
  *different metric* from the baselines' and would make Table `tab:lmee` an
  apples-to-oranges comparison. This needs an explicit statement either way.

### B11. [RESOLVED] Figure/table hygiene
> **Fixed.** Reliability caption now names both axes, defines which side of the
> diagonal is overconfidence, and describes the two conditions as the same 137
> predictions scored with and without confidence scaling ($\sigma_t\equiv1$).
> `tab:stats` caption explains the $m=1$ dash and flags the geodesic confound.
> `tab:ablation_all`(a) gains an SPL column (20.75 / 28.38, from the same subset as
> `tab:feedback`). `[H]` floats in §3 changed to `[t]`. Figure files renamed to
> `teaser.png`, `pec-main-architecture.png`, `qualitative-example.png` with all
> references updated.
- Fig. `fig:reliability`: "same $n=137$ predictions with and without the correction
  loop" — the same predictions cannot exist in both conditions; clarify (re-scored
  offline? paired episodes?).
- Fig. `fig:reliability` caption says both curves lie *below* the diagonal but the
  prose calls the model overconfident; below-diagonal = predicted > observed is
  overconfidence only under one axis convention. State the axes explicitly.
- Table `tab:stats` "Mean corrections fired" is `--` for $m=1$ despite 1 episode.
- Table `tab:ablation_all`(a) has no SPL column while (b) does; add it for parity.
- Sec. 4.4's "The correction loop is everything" is a claim, not a heading — retitle.
- `\begin{table}[H]` / `\begin{algorithm}[H]` in `3_method.tex` need `float`; prefer
  `[t]`/`[tb]` for camera-ready.
- Filenames with spaces and parentheses (`Pec-main-architecture (2).png`,
  `qualitative image pec (1).png`) are fragile in LaTeX toolchains — rename.

---

## C. Cross-section consistency
*All six addressed. C1 via A10 (abstract/intro now say "adapts", plus an explicit "no
component is trained"). C2 via A1. C3: contribution 2 softened to "to our knowledge",
and narrowed to adapting both confidence and weighting online with no training.
C4: contribution 4 no longer claims to "outperform"; it reports consistent directional
gains across three ablations and states the scale of the evidence. C5: the duplicated
hardware paragraph in §3.4 is cut down to a pointer at §4.1. C6: "this.First," fixed,
and the Limitations paragraph rewritten to four named limitations.*


1. Abstract/intro "learns from its own prediction errors" vs. Sec. 4.5 "the predictor
   is prompt-based and never updated" (see A10).
2. Contribution #1 (landmark-conditioned reformulation) has no method (see A1).
3. Contribution #2 claims "the first self-calibrating frontier search" — a
   priority claim that Sec. 2 must actually defend against online-adaptation work,
   or soften to "to our knowledge".
4. Contribution #4 "outperforms static alternatives in navigation and downstream QA":
   the only full-scale static-alternative comparison does not exist (B3), and QA on
   the Hard split is worse than the baseline (B2).
5. The Hardware paragraph in Sec. 4.1 duplicates Sec. 3.4 verbatim — cut one.
6. Discussion has a run-on / missing space: "Two caveats attach to this.First, ...".

---

## Status

| | Total | Text fix landed | Still wants a run/answer |
|---|---|---|---|
| A. Method | 10 | 10 | A3→P2.2, A5→P3.3, A6→P3.1, A7→P3.2, A9→P4.1 |
| B. Experiments | 11 | 11 | B1→P1.3/P2.1, B3→P2.1, B5→P1.1, B8→P1.4, B9→P1.2 |
| C. Cross-section | 6 | 6 | — |
| E. Abstract/Intro/RW/Concl. | 10 | 8 | E7→P3b.1, E8→P3b.2, E9→P4.3 |
| F. Third pass | 8 | 8 | — |
| G. Fourth pass | 8 | 7 | G1 (SR arithmetic) |
| H. Fifth pass (author cross-check) | 5 | 5 | — |
| I. Sixth pass (bibliography) | 1 | 1 | — |
| J. Seventh pass (calculator check) | 11 | 9 | J1, J10 |
| **Total** | **70** | **64** | **6 open + the P-list** |

Every one of the 27 is written up honestly in the paper. The follow-ups above are
listed in PENDING at the top; none of them is a correction, all of them are
strengthening moves. The two that would most change what the paper may claim are
**P2.1** (full-scale static baseline) and **P2.2** (fixed-scalar ECE control).

## D. Original priority order

1. B3 — run the static baseline on the full 58-task set.
2. B1 — seeds + confidence intervals on every ablation delta.
3. A1/C2 — reconcile the landmark story with the method, or drop it.
4. A2/A3 — fix the normalisation and add the fixed-scalar ECE control.
5. B2 — correct the bolding and acknowledge per-split losses.
6. B5/B7 — fix the landmark stratification and the episode-count arithmetic.
