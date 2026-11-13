import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.IntervalCases
import Mathlib.Tactic.Positivity
import Mathlib.Algebra.Order.Floor.Ring
import Mathlib.Data.Rat.Floor

namespace PisotFour

def b : ℕ → ℤ
  | 0 => 4
  | 1 => 6
  | 2 => 9
  | n + 3 => b (n + 2) + b n

theorem b_rec (n : ℕ) : b (n+3) = b (n+2) + b n := rfl

theorem b_pos (n : ℕ) : 0 < b n := by
  induction n using Nat.strong_induction_on with
  | h n ih =>
    rcases n with _ | _ | _ | n
    · norm_num [b]
    · norm_num [b]
    · norm_num [b]
    · rw [b_rec]
      have := ih n (by omega)
      have := ih (n+2) (by omega)
      omega

def q (n : ℕ) : ℤ := 2*b (n+4)-9*b n

theorem q_rec (n : ℕ) : q (n+3) = q (n+2)+q n := by
  unfold q
  have h := b_rec (n+4)
  have h' := b_rec n
  norm_num only [Nat.add_assoc] at h h' ⊢
  rw [h, h']
  ring

theorem growth (n : ℕ) : 9*b n < 2*b (n+4) := by
  have hp : ∀ k, 0 < q k := by
    intro k
    induction k using Nat.strong_induction_on with
    | h k ih =>
      rcases k with _ | _ | _ | k
      · norm_num [q, b]
      · norm_num [q, b]
      · norm_num [q, b]
      · rw [q_rec]
        have := ih k (by omega)
        have := ih (k+2) (by omega)
        omega
  have := hp n
  unfold q at this
  omega

def X (n : ℕ) : ℤ := b (n+3)*b (n+1)-b (n+2)^2
def Y (n : ℕ) : ℤ := b (n+3)*b n-b (n+1)*b (n+2)
def Z (n : ℕ) : ℤ := b (n+2)*b n-b (n+1)^2

theorem transition (n : ℕ) :
    X (n+1) = -Y n ∧ Y (n+1) = X n-Z n ∧ Z (n+1) = X n := by
  dsimp [X,Y,Z]
  norm_num only [Nat.add_assoc]
  rw [b_rec (n+1), b_rec n]
  constructor
  · ring
  constructor <;> ring

theorem four_step (n : ℕ) :
    X (n+4)=X n-Y n-Z n ∧
    Y (n+4)=2*X n+Y n-Z n ∧
    Z (n+4)=X n+Y n := by
  have h0 := transition n
  have h1 := transition (n+1)
  have h2 := transition (n+2)
  have h3 := transition (n+3)
  norm_num only [Nat.add_assoc] at *
  rcases h0 with ⟨h0x,h0y,h0z⟩
  rcases h1 with ⟨h1x,h1y,h1z⟩
  rcases h2 with ⟨h2x,h2y,h2z⟩
  rcases h3 with ⟨h3x,h3y,h3z⟩
  constructor
  · linarith
  constructor <;> linarith

def Bounds (k : ℕ) : Prop :=
  -b (k+7) < 2*X (k+10) ∧ 2*X (k+10) < b (k+7) ∧
  -b (k+7) < 2*Y (k+10) ∧ 2*Y (k+10) < b (k+7) ∧
  -b (k+7) < 2*Z (k+10) ∧ 2*Z (k+10) < b (k+7)

theorem bounds (k : ℕ) : Bounds k := by
  induction k using Nat.strong_induction_on with
  | h k ih =>
    rcases k with _ | _ | _ | _ | k
    · norm_num [Bounds, X, Y, Z, b]
    · norm_num [Bounds, X, Y, Z, b]
    · norm_num [Bounds, X, Y, Z, b]
    · norm_num [Bounds, X, Y, Z, b]
    · have hb := ih k (by omega)
      have hg := growth (k+7)
      have hp := b_pos (k+7)
      have hs := four_step (k+10)
      norm_num only [Nat.add_assoc] at hg hs ⊢
      dsimp [Bounds] at hb ⊢
      norm_num only [Nat.add_assoc] at *
      rcases hb with ⟨a1,a2,a3,a4,a5,a6⟩
      rcases hs with ⟨hx,hy,hz⟩
      omega

def u (t : ℤ) (n : ℕ) : ℤ := b n+t

def det (t : ℤ) (n : ℕ) : ℤ :=
  u t (n+2)*u t n-(u t (n+1))^2

theorem second_diff (m : ℕ) :
    b (m+6)+b (m+4)-2*b (m+5)=b m := by
  have h0 := b_rec m
  have h1 := b_rec (m+1)
  have h2 := b_rec (m+2)
  have h3 := b_rec (m+3)
  norm_num only [Nat.add_assoc] at *
  omega

theorem det_shift (t : ℤ) (m : ℕ) :
    det t (m+4) = X (m+3)+t*b m := by
  have h := second_diff m
  dsimp [det,u,X]
  norm_num only [Nat.add_assoc] at *
  linear_combination t * h

theorem ceiling_bounds (t : ℤ) (ht : t=3 ∨ t=4) (n : ℕ) :
    0 ≤ det t n ∧ det t n < u t n := by
  by_cases hn : n < 11
  · interval_cases n <;> rcases ht with rfl | rfl <;>
      norm_num [det,u,b]
  · obtain ⟨k,rfl⟩ : ∃ k, n=k+11 := ⟨n-11, by omega⟩
    have hb := bounds k
    have hg := growth (k+7)
    have hp := b_pos (k+7)
    have hd := det_shift t (k+7)
    norm_num only [Nat.add_assoc] at hd hg
    dsimp [Bounds] at hb
    rcases hb with ⟨h1,h2,_⟩
    dsimp [u]
    rcases ht with rfl | rfl <;> constructor <;> nlinarith

theorem u_pos (t : ℤ) (ht : t=3 ∨ t=4) (n : ℕ) : 0 < u t n := by
  have := b_pos n
  rcases ht with rfl | rfl <;> dsimp [u] <;> omega

theorem ceil_of_bounds (h p q : ℤ) (hq : 0 < q)
    (hl : 0 ≤ h*q-p) (hu : h*q-p < q) :
    ⌈(p:ℚ)/(q:ℚ)⌉ = h := by
  apply Int.ceil_eq_iff.mpr
  have hqr : (0:ℚ) < q := by exact_mod_cast hq
  have hlr : (0:ℚ) ≤ (h:ℚ)*q-p := by exact_mod_cast hl
  have hur : (h:ℚ)*q-p < q := by exact_mod_cast hu
  constructor
  · apply (lt_div_iff₀ hqr).mpr
    nlinarith
  · apply (div_le_iff₀ hqr).mpr
    linarith

theorem u_ceiling (t : ℤ) (ht : t=3 ∨ t=4) (n : ℕ) :
    u t (n+2) = ⌈(u t (n+1):ℚ)^2/(u t n:ℚ)⌉ := by
  have hb := ceiling_bounds t ht n
  have h := ceil_of_bounds (u t (n+2)) ((u t (n+1))^2) (u t n)
    (u_pos t ht n) hb.1 hb.2
  push_cast at h
  exact h.symm

noncomputable def ceilingSeq (a₀ a₁ : ℤ) : ℕ → ℤ
  | 0 => a₀
  | 1 => a₁
  | n+2 => ⌈(ceilingSeq a₀ a₁ (n+1):ℚ)^2/(ceilingSeq a₀ a₁ n:ℚ)⌉

theorem ceilingSeq_rec (a₀ a₁ : ℤ) (n : ℕ) :
    ceilingSeq a₀ a₁ (n+2) =
      ⌈(ceilingSeq a₀ a₁ (n+1):ℚ)^2/(ceilingSeq a₀ a₁ n:ℚ)⌉ := rfl

theorem identify (t : ℤ) (ht : t=3 ∨ t=4) (n : ℕ) :
    ceilingSeq (4+t) (6+t) n = u t n := by
  induction n using Nat.strong_induction_on with
  | h n ih =>
    rcases n with _ | _ | n
    · rfl
    · rfl
    · rw [ceilingSeq_rec, ih (n+1) (by omega), ih n (by omega)]
      exact (u_ceiling t ht n).symm

theorem u_fourth (t : ℤ) (n : ℕ) :
    u t (n+4)=2*u t (n+3)-u t (n+2)+u t (n+1)-u t n := by
  have h0 := b_rec n
  have h1 := b_rec (n+1)
  dsimp [u]
  norm_num only [Nat.add_assoc] at *
  omega

theorem original_fourth (t : ℤ) (ht : t=3 ∨ t=4) (n : ℕ) (hn : 4 ≤ n) :
    ceilingSeq (4+t) (6+t) n =
      2*ceilingSeq (4+t) (6+t) (n-1)-ceilingSeq (4+t) (6+t) (n-2)+
      ceilingSeq (4+t) (6+t) (n-3)-ceilingSeq (4+t) (6+t) (n-4) := by
  simp only [identify t ht]
  obtain ⟨k,rfl⟩ : ∃ k, n=k+4 := ⟨n-4,by omega⟩
  simpa using u_fourth t k

theorem shift_general (a₀ a₁ : ℤ) (n : ℕ) :
    ceilingSeq a₀ a₁ (n+1) =
    ceilingSeq a₁ (⌈(a₁:ℚ)^2/(a₀:ℚ)⌉) n := by
  induction n using Nat.strong_induction_on with
  | h n ih =>
    rcases n with _ | _ | n
    · rfl
    · rfl
    · rw [show n+2+1=(n+1)+2 by omega, ceilingSeq_rec,
        ih (n+1) (by omega), ih n (by omega), ceilingSeq_rec]

noncomputable abbrev A048589 := ceilingSeq 7 9
noncomputable abbrev A048591 := ceilingSeq 8 10
noncomputable abbrev A048585 := ceilingSeq 6 7
noncomputable abbrev A048588 := ceilingSeq 7 8

theorem shift_585 (n : ℕ) : A048585 (n+1)=A048589 n := by
  have h := shift_general 6 7 n
  norm_num at h
  exact h

theorem shift_588 (n : ℕ) : A048588 (n+1)=A048591 n := by
  have h := shift_general 7 8 n
  norm_num at h
  exact h

theorem recurrence_A048589 (n : ℕ) (hn : 4 ≤ n) :
    A048589 n=2*A048589 (n-1)-A048589 (n-2)+A048589 (n-3)-A048589 (n-4) := by
  exact original_fourth 3 (Or.inl rfl) n hn

theorem recurrence_A048591 (n : ℕ) (hn : 4 ≤ n) :
    A048591 n=2*A048591 (n-1)-A048591 (n-2)+A048591 (n-3)-A048591 (n-4) := by
  exact original_fourth 4 (Or.inr rfl) n hn

theorem recurrence_A048585 (n : ℕ) (hn : 4 ≤ n) :
    A048585 n=2*A048585 (n-1)-A048585 (n-2)+A048585 (n-3)-A048585 (n-4) := by
  by_cases he : n=4
  · subst n
    norm_num [A048585, ceilingSeq]
  · obtain ⟨k,rfl⟩ : ∃ k, n=k+5 := ⟨n-5,by omega⟩
    have h := recurrence_A048589 (k+4) (by omega)
    simp only [Nat.add_sub_cancel, Nat.add_sub_cancel_left] at h
    convert h using 1 <;> simp [shift_585, show k+5=(k+4)+1 by omega,
      show k+5-1=(k+3)+1 by omega, show k+5-2=(k+2)+1 by omega,
      show k+5-3=(k+1)+1 by omega, show k+5-4=k+1 by omega]

theorem recurrence_A048588 (n : ℕ) (hn : 4 ≤ n) :
    A048588 n=2*A048588 (n-1)-A048588 (n-2)+A048588 (n-3)-A048588 (n-4) := by
  by_cases he : n=4
  · subst n
    norm_num [A048588, ceilingSeq]
  · obtain ⟨k,rfl⟩ : ∃ k, n=k+5 := ⟨n-5,by omega⟩
    have h := recurrence_A048591 (k+4) (by omega)
    simp only [Nat.add_sub_cancel, Nat.add_sub_cancel_left] at h
    convert h using 1 <;> simp [shift_588, show k+5=(k+4)+1 by omega,
      show k+5-1=(k+3)+1 by omega, show k+5-2=(k+2)+1 by omega,
      show k+5-3=(k+1)+1 by omega, show k+5-4=k+1 by omega]

end PisotFour
