# DeltIEt — Early Detection of Battery Degradation

**A training-free, chemistry-agnostic algorithm for detecting battery capacity knee-points before they occur.**

[![Open in Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/drive/1JNxs5yTvSZnKqLRyAD0ZzB2XLE0DZEeL?usp=sharing)
&nbsp;
![Patent Pending](https://img.shields.io/badge/Patent-BR%2010%202026%20012158%204-gold)
&nbsp;
![License](https://img.shields.io/badge/License-Evaluation%20%2F%20Academic%20Free-blue)

---

## What is DeltIEt?

DeltIEt (Δ-Information Entropy operator) detects the entropic acceleration of battery capacity returns — the structural change in discharge variability — **before any absolute capacity threshold is breached**.

```
DeltIEt(t) = Zₜ · |Δ²Sₜ|
```

| Symbol | Meaning |
|---|---|
| **Sₜ** | Shannon entropy over a rolling window of capacity returns (w = 15 cycles) |
| **Δ²Sₜ** | Second-order finite difference of Sₜ (entropic acceleration) |
| **Zₜ** | Adaptive z-score computed from the **past h = 40 cycles only** — no future data ever used |

An alarm fires when DeltIEt crosses a rolling p90 threshold computed exclusively from past observations.

> **Zero look-ahead. Zero training. Zero chemistry-specific tuning.**

---

## Validated Results

| Dataset | Chemistry | Cells with confirmed knee | Detected | Median lead time | Lead range |
|---|---|---|---|---|---|
| NASA PCoE (B0005/06/07) | Li-ion 18650 | 3 | **3 / 3** | 116 cycles | — |
| Tongji/KIT Zenodo — Dataset 1 | NCA 18650 | 42 | **42 / 42** | 256 cycles | 87–588 cycles |
| Tongji/KIT Zenodo — Dataset 2 | NCM 18650 | 24 | **24 / 24** | 551 cycles | 130–979 cycles |

**Fixed parameters across every dataset — no retraining, no adjustment between chemistries:**

```python
W      = 15   # rolling window for Shannon entropy
H      = 40   # lookback for adaptive z-score
N_BINS = 5    # histogram bins for entropy calculation
P      = 90   # rolling percentile threshold
```

### Pass / Fail Criteria

> This notebook must reproduce **exactly** the following lead times:
> - NASA B0005: alarm at cycle **8**, threshold at cycle **124** → **116 cycles early**
> - NCA dataset: **42/42** cells detected, median lead **256 cycles**
> - NCM dataset: **24/24** cells detected, median lead **551 cycles**
>
> If these numbers are not reproduced, the method failed. There is no intermediate result.

---

## How to Run

### Option 1 — One-click (Google Colab)

Click the badge at the top or open:

```
https://colab.research.google.com/drive/1JNxs5yTvSZnKqLRyAD0ZzB2XLE0DZEeL?usp=sharing
```

Then: **Runtime → Run All**

The notebook downloads all raw data from public Zenodo URLs and produces the full results in under 20 minutes. A Google account is required to execute cells.

---

### Option 2 — Local / Offline (Corporate Environment)

For environments where Google Colab is blocked by IT policy, the notebook runs entirely on a local machine. No data leaves the corporate network.

**Requirements:** Python 3.9+ and pip.

```bash
# 1. Clone the repository
git clone https://github.com/deltiet-research/deltiet-battery.git
cd deltiet-battery

# 2. Install dependencies (frozen versions)
pip install -r requirements.txt

# 3. Launch the notebook
jupyter notebook deltiet_validation.ipynb
```

Run all cells. The notebook will download the datasets from public Zenodo DOIs automatically.  
If internet access is restricted, the raw `.csv` files can be downloaded manually from [https://doi.org/10.5281/zenodo.6405084](https://doi.org/10.5281/zenodo.6405084) and placed in the `data/` folder.

---

## Repository Structure

```
deltiet-battery/
├── deltiet_validation.ipynb   # Main validation notebook
├── requirements.txt           # Frozen Python dependencies
├── LICENSE                    # Patent pending — see license terms
└── README.md
```

---

## Datasets

All datasets are publicly available. The notebook downloads them automatically.

- **NASA PCoE Battery Dataset**  
  [https://www.nasa.gov/intelligent-systems-division/discovery-and-systems-health/pcoe/pcoe-data-set-repository/](https://www.nasa.gov/intelligent-systems-division/discovery-and-systems-health/pcoe/pcoe-data-set-repository/)

- **Tongji/KIT Battery Aging Dataset (NCA + NCM 18650)**  
  DOI: [10.5281/zenodo.6405084](https://doi.org/10.5281/zenodo.6405084)

---

## License

This repository is released for **academic and evaluation purposes only**.

The DeltIEt algorithm is the subject of **Brazilian Patent Application BR 10 2026 012158 4** (INPI, filed 18 May 2026). PCT international filing window is open until May 2027.

- ✅ Free to use for academic research and independent validation
- ✅ Free to use for internal evaluation by potential licensees
- ❌ Commercial use, integration into products, or sublicensing requires a written agreement

For licensing inquiries: **deltiet.research@gmail.com**

---

## Contact

**Inventor:** Ubirajara dos Santos Vasconcelos  
**Location:** Feira de Santana, Bahia, Brazil  
**Email:** deltiet.research@gmail.com  
**LinkedIn:** [linkedin.com/in/ubirajara-vasconcelos-9b6a0b410](https://www.linkedin.com/in/ubirajara-vasconcelos-9b6a0b410/)

Open to licensing, joint development, or validation on proprietary datasets.

---

*Results obtained exclusively from publicly available datasets using open-source code. All claims subject to independent verification.*
