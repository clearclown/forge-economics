# 18. 二次市場とトークン化 — 守らないものを明言する

> Tirami は OSS であり、MIT ライセンスで公開されている。開発者は
> TRM を販売しない、投機しない、宣伝しない。しかし**第三者**が
> OSS を利用して二次市場を立ち上げることを**技術的に防ぐ手段は
> ない**。この章は、その立場を経済学的に整理する。

§15-17 で「計算通貨としての TRM」を技術・経済・暗号の 3 側面から
補強した。最後に残る問いは「だから TRM は値上がりするのか?」
「取引所に上場するのか?」「投資対象なのか?」。

Tirami の公式な立場は **「考えていない、関与しない、責任を負わない」**。
本章ではこの立場を、既存の OSS 経済学・金融規制・言語哲学の
枠組みで整理する。

---

## 18.1 TRM = 計算の会計単位

まず定義から。§1 で述べたように:

```
1 TRM = 10⁹ FLOP の検証済み推論演算
```

これは**物理的な量の定義**であって、価格の定義ではない。
キログラムがプラチナ円柱 (旧 IPK) で定義されるように、TRM は
FLOP 数で定義される。

この定義に含まれないもの:
- TRM の USD レート
- TRM と他暗号通貨との交換比率
- TRM の期待将来価値
- TRM のボラティリティ

これらは全て**市場現象**であって、プロトコル定義ではない。
プロトコルは `1 TRM = 10⁹ FLOP` しか主張しない。

---

## 18.2 開発者が守らないと明言するもの

Phase 19 で Tirami の `SECURITY.md` に以下のセクションが追加された:

> TRM is **compute accounting**, not a financial product. The
> protocol maintainers do not sell, promote, or speculate on TRM.

日本語化して分解:

1. **販売しない** (do not sell)
   - ICO、pre-sale、airdrop、private round を行わない。
   - 新規発行 TRM は PoUW (推論提供) でのみ分配される。
   - 開発者も普通のプロバイダとして働かなければ TRM を持てない。

2. **宣伝しない** (do not promote)
   - 「TRM に投資しよう」というマーケティングをしない。
   - 価格予想、ROI、ホワイトペーパーの financial projection を出さない。
   - 「この技術が計算の未来を変える」は technical claim で OK、
     「TRM は X 倍になる」は NG。

3. **投機しない** (do not speculate)
   - 開発者個人が TRM を他暗号通貨と交換する選好を持たない。
   - チーム treasury は持たない (そもそも pre-allocation していない)。
   - 二次市場に listing される revenue share を受けない。

4. **関与できない** (cannot control)
   - MIT ライセンスなので、第三者が Tirami のコードをフォークして
     独自のトークンエコノミーを作ることは**許可されている**。
   - 第三者が TRM ERC-20 を他の DEX に listing することも
     **技術的に防げない**。
   - secondary market で売買されることを**監視する仕組みを持たない**。

---

## 18.3 OSS と通貨の組み合わせの特殊性

ここで問いが生まれる:「OSS は自由に配れるが、通貨は配ると
金融規制がかかるのでは?」。これは**通貨と通貨プリミティブの
混同**である。

- **通貨の発行** は規制対象 (金融機関の登録、KYC、ALM 等が必要)。
- **通貨プリミティブの配布** (e.g. Bitcoin のソースコード) は
  OSS として一般に合法。
- Bitcoin / Ethereum / Tirami 等のネットワーク上で発行される
  暗号資産は、**ネットワークユーザーが自発的に運用**したものであり、
  コード配布者 (Satoshi, V. Buterin, Tirami 開発者) は「通貨を
  発行した」ことには通常ならない。

各国の規制当局もこの区別を概ね採用している (日本の暗号資産交換
業者の登録は、ネットワーク通貨を「売買する業者」が対象で、OSS
開発者は通常対象外)。

ただし、開発者が:
- ICO / airdrop で明示的に新規トークンを配る
- 取引所に listing を働きかける
- 自己の利益のために価格を操作する

と、規制対象 (有価証券の無登録売買等) に該当する可能性が上がる。
Tirami はこれらを**全て行わない**ことで、単なる「OSS の
配布者」の立場を維持する。

---

## 18.4 それでも第三者が市場を作ったら?

Tirami が公開された瞬間、誰でも以下を始められる:

1. **TRM ERC-20 を DEX に listing** — Uniswap、PancakeSwap 等に
   ペア (TRM/USDC、TRM/ETH) を作成。
2. **ブリッジ実装** — Base L2 の TRM を別チェーン (Ethereum mainnet,
   Arbitrum, Solana) に送る bridge contract を書く。
3. **デリバティブ** — TRM の futures / options / 永久 swap を
   提供する DeFi プロトコルを作る。
4. **CEX listing** — Binance / Coinbase / OKX 等の CEX が TRM を
   上場する (これは CEX 側の意思決定で、Tirami 開発者は関与しない)。

これらは**全て発生しうる**し、Tirami 開発者が止める手段はない。
そして、発生した時点で**二次市場価格**が存在し始める。

この立場から、Tirami 開発者が明示的に放棄することは:

| 放棄するもの | 意味 |
|---|---|
| 価格維持義務 | 「TRM が 1 USD を下回らないよう介入する」とは言わない |
| 流動性提供義務 | LP として liquidity pair に資金を入れない |
| 上場拒否権 | 特定の DEX / CEX に「listing するな」と命じる権限を持たない |
| 利益受領権 | secondary market の手数料・spread から revenue を受けない |

代わりに開発者が保持する権利:

| 保持するもの | 意味 |
|---|---|
| プロトコル改良権 | コードを修正して新バージョンを release する |
| フォーク権 | 自分自身のネットワークをフォークして再出発する (憲法違反時の最終手段) |
| 発言権 | 特定の secondary market 実装が危険だと**意見を述べる**権利 |

---

## 18.5 関連する経済学の枠組み

この立場は現代 OSS 経済学と以下のように対応する:

**1. Linux カーネルのモデル**
- Linus Torvalds は Linux の「公式マネタイゼーション」を
  行わない。
- Red Hat / Oracle / IBM 等の企業が Linux を使って商業活動を
  するのは自由。
- Linus は「個人ユーザーが Linux を何に使うか」にコントロールを
  持たない。

これと同じ構造を TRM に当てはめる。開発者は OSS を公開し、
第三者がそれでどんな市場を作ろうと、**プロトコル自体**の挙動は
変わらない。

**2. Bitcoin の Satoshi モデル**
- Satoshi は最初の Bitcoin を mining して所有していたが、使わず
  消えた (2011 年以降アクティブでない)。
- 後から生まれた市場 (Mt.Gox、現在の Coinbase 等) は Satoshi と
  無関係。
- 「BTC の価値」は市場が決め、Satoshi は関与しない。

Tirami の違いは「pre-mine が 0 である」こと。Satoshi は早期
mining で大量の BTC を持つが、Tirami の開発者は「ネットワーク
参加者として普通に TRM を稼ぐ」以外の方法で TRM を持てない。

**3. RMT (Real Money Trading) の議論**
- オンラインゲームの通貨 (MMORPG の gold 等) が現実通貨で
  取引される現象。
- ゲーム運営者は「ゲーム内通貨と現実通貨の交換を公式には認めない」
  立場を取ることが多い。
- それでも RMT 市場は自然発生する。

Tirami の立場はこの「公式には認めない、技術的に止められない」
モデルと構造的に同型。ただしゲーム運営が「禁止」するのに対し、
Tirami は「認めも禁じもしない」中立を取る (OSS ライセンス上、
禁止する権限がそもそもない)。

---

## 18.6 ユーザーへの含意

この立場を受け入れた上で、TRM を「持つ」ユーザーは何を
理解すべきか:

1. **TRM の価値は計算の需要で決まる**
   - 推論を求める人がいれば TRM は使われる。
   - 需要が消えれば TRM の市場価値は 0 に近づきうる。

2. **secondary market は volatile**
   - 開発者が介入しないので、価格は市場の気まぐれで上下する。
   - 2022 年の crypto crash と同規模のドローダウンは**十分ありうる**。

3. **保有は自己責任**
   - 盗難・損失・取引所破綻 — すべて保有者のリスク。
   - 開発者は補償しない。

4. **「使う」ためなら安全**
   - 推論の consumer として TRM を使う分には、物理的な compute
     と紐付いているので価値が突然 0 にはならない。
   - 投資対象として持つと上記リスクが乗る。

開発者の推奨は明示的に「必要な分だけ使い、余分は stake して yield
を取るか、compute に還元する」。「HODL で X 倍」を目指すのは
プロトコルの意図する使い方ではない。

---

## 18.7 監査と透明性

この立場を「空念仏」で終わらせないための透明性措置:

1. **全開発者のウォレットアドレス公開 (将来)**
   - 開発者が自分の TRM balance を隠して secondary market で
     売却することを防ぐ。
   - まだ implement されていないが、Phase 20 で検討。

2. **Constitutional パラメータの検査可能性**
   - §15 で議論した 18 の不変パラメータは、governance で変更
     できない。価格維持のための「供給上限を上げる」等の裏技も
     不可能。

3. **Mainnet deploy ゲート**
   - `repos/tirami-contracts/Makefile` で明示: 監査完了 +
     multi-sig + "i-accept-responsibility" の 3 連鎖がないと
     deploy されない。
   - 一度 deploy された ERC-20 コントラクトは透明 (Etherscan で
     全 mint / transfer を確認可能)。

---

## 18.8 哲学的補足 — 「価値」と「価格」の分離

最後に哲学的な整理を。TRM について、以下 2 つを切り離す:

- **内在価値 (intrinsic value)**: `1 TRM = 10⁹ FLOP` という物理的
  事実。市場価格がどうであれ、この等価は成立する。ネットワーク
  上で 1 TRM を提示すれば、10⁹ FLOP 相当の compute が得られる。

- **市場価格 (market price)**: secondary market で TRM に付く
  USD / BTC / ETH 等の価格。これは需給で変動し、ゼロにもなりうる。

ビットコインと違う点: ビットコインは「10⁹ FLOP 消費した hash の
証拠」を持つが、その hash は**再使用できない** (計算が
meaningless)。TRM は「10⁹ FLOP の useful inference の証拠」で、
その inference は**再使用できる** (結果を受け取ったユーザーが
消費する)。

だから TRM の内在価値は「使える compute」で、市場価格が 0 でも
内在価値は 10⁹ FLOP のまま。

この哲学を受け入れれば、「secondary market の投機」は TRM の
本義から外れた余興であると理解できる。余興が盛り上がるのは
止められないが、本義を見失ってはいけない。

---

## 次章へ

本章で Phase 19 時点の経済論シリーズは締める。§19 以降は将来の
予定:

- §19 候補: Auditor's Role — 外部セキュリティ監査の経済学的意味
- §20 候補: Governance Amendment Log — 実際に可決された提案の記録

参照:
- 実装: `tirami/SECURITY.md § Secondary markets`, `tirami/README.md`
- Makefile: `repos/tirami-contracts/Makefile` (mainnet gate)
- 設計: `tirami/docs/release-readiness.md` (tier C/D)
- パラメータ: `spec/parameters.md § 25`
