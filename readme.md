# 🗳️ Voting Smart Contract

A simple and secure **Voting DApp Smart Contract** written in **Solidity (v0.8.19)**.  
It allows an owner to create a list of candidates, open voting for participants, and end the voting session once complete.

---

## 📜 License

This project is licensed under the **MIT License**.  
See the [SPDX License Identifier](https://spdx.org/licenses/MIT.html) at the top of the contract.

---

## ⚙️ Features

- 👑 **Owner Control:** Only the contract deployer can add candidates and end the voting.
- ✅ **Open/Close Voting:** Voting can only occur while the voting session is open.
- 🧾 **Candidate Management:** The owner can add multiple candidates.
- 🗳️ **Single Vote Per Voter:** Each address can vote only once.
- 📊 **Vote Counting:** Each candidate’s vote count is tracked automatically.

---

## 🧠 Contract Overview

### State Variables

| Variable | Type | Description |
|-----------|------|-------------|
| `owner` | `address` | Address of the contract owner (deployer) |
| `votingOpen` | `bool` | Indicates if voting is open |
| `candidatesCount` | `uint` | Total number of candidates added |

---

### Structs

#### 🧍‍♂️ Candidate
```solidity
struct Candidate {
    uint id;
    string name;
    uint voteCount;
}