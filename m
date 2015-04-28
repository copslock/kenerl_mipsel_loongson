Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 06:47:37 +0200 (CEST)
Received: from mailout4.w1.samsung.com ([210.118.77.14]:9830 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011809AbbD1Eq720fmb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2015 06:46:59 +0200
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NNI008AZ2M5PV60@mailout4.w1.samsung.com>; Tue,
 28 Apr 2015 05:46:53 +0100 (BST)
X-AuditID: cbfec7f4-f79c56d0000012ee-93-553f10c0d746
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm1.samsung.com (EUCPMTA) with SMTP id 56.FD.04846.0C01F355; Tue,
 28 Apr 2015 05:46:56 +0100 (BST)
Received: from localhost.localdomain ([10.252.80.64])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0NNI00A672LDPN10@eusync1.samsung.com>; Tue,
 28 Apr 2015 05:46:53 +0100 (BST)
From:   Krzysztof Kozlowski <k.kozlowski@samsung.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Turquette <mturquette@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Kukjin Kim <kgene@kernel.org>, Barry Song <baohua@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v2 3/8] clk: tegra: Fix inconsistent indenting
Date:   Tue, 28 Apr 2015 13:46:18 +0900
Message-id: <1430196383-9190-4-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1430196383-9190-1-git-send-email-k.kozlowski@samsung.com>
References: <1430196383-9190-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42I5/e/4Zd0DAvahBj/WGlg8OdTLbHH9y3NW
        i3OvHrFY/H/0mtVi0v0JLBbfHi5ktHj9wtCi//FrZotNj6+xWnzsucdqcXnXHDaLCVMnsVt8
        evCf2WLG+X1MFp1fZrFZPJ1wkc1i0tqpjBY356dZXNqjYnH4TTurxY8z3SwWrw62sVj83DWP
        xWLVrj+MDhIel/t6mTx2zrrL7rFpVSebx51re9g8jq5cy+SxeUm9R2/zOzaPvi2rGD22X5vH
        7PF5k5zHxrmhAdxRXDYpqTmZZalF+nYJXBmfNlxnLPjAVXFi+VPGBsZmji5GTg4JAROJGa2/
        mSFsMYkL99azdTFycQgJLGWUmNK2hhnC+c8o8f/PJUaQKjYBY4nNy5eAVYkI9LBJbH16D6yd
        WaBKYt7bHawgtrCAncT1RcfBGlgEVCVO394LZvMKuEn8vPQIap2cxMljk8HqOQXcJfqb+4Bs
        DqBtbhKdXfkTGHkXMDKsYhRNLU0uKE5KzzXUK07MLS7NS9dLzs/dxAiJmS87GBcfszrEKMDB
        qMTDm8FsHyrEmlhWXJl7iFGCg1lJhLf4j12oEG9KYmVValF+fFFpTmrxIUZpDhYlcd65u96H
        CAmkJ5akZqemFqQWwWSZODilGhg1Xoe2HLkjVWnxQq7NLshySf/cE8oV1vd+rWPzf7xqweqL
        gtUaFyO9ux5/n735fvCE5HUaTHfY/d4rvV5TclVpodYymU9Vruuf7o9PMGfa78ZSMXFquVVf
        57L/u24G/JO8skLna9niFX/tp258kCLm8SYlOUQqNNy4ekVi+wyOgqWzt0lav5JSYinOSDTU
        Yi4qTgQA9jV495UCAAA=
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: k.kozlowski@samsung.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Fix the indentation - spaces used instead of tabs and actually wrong
number of spaces.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/tegra/clk-emc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/tegra/clk-emc.c b/drivers/clk/tegra/clk-emc.c
index 615da43a508d..8757feda4a11 100644
--- a/drivers/clk/tegra/clk-emc.c
+++ b/drivers/clk/tegra/clk-emc.c
@@ -130,11 +130,11 @@ static long emc_determine_rate(struct clk_hw *hw, unsigned long rate,
 
 	tegra = container_of(hw, struct tegra_clk_emc, hw);
 
-         for (i = 0; i < tegra->num_timings; i++) {
-                if (tegra->timings[i].ram_code != ram_code)
-                        continue;
+	for (i = 0; i < tegra->num_timings; i++) {
+		if (tegra->timings[i].ram_code != ram_code)
+			continue;
 
-                timing = tegra->timings + i;
+		timing = tegra->timings + i;
 
 		if (timing->rate > max_rate) {
 			i = min(i, 1);
@@ -145,11 +145,11 @@ static long emc_determine_rate(struct clk_hw *hw, unsigned long rate,
 			continue;
 
 		if (timing->rate >= rate)
-                        return timing->rate;
-        }
+			return timing->rate;
+	}
 
-        if (timing)
-                return timing->rate;
+	if (timing)
+		return timing->rate;
 
 	return __clk_get_rate(hw->clk);
 }
-- 
1.9.1
