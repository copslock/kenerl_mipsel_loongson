Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 06:47:01 +0200 (CEST)
Received: from mailout3.w1.samsung.com ([210.118.77.13]:64353 "EHLO
        mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011701AbbD1EqlqV708 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2015 06:46:41 +0200
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NNI009A22LTN860@mailout3.w1.samsung.com>; Tue,
 28 Apr 2015 05:46:41 +0100 (BST)
X-AuditID: cbfec7f4-f79c56d0000012ee-7f-553f10b48d32
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm1.samsung.com (EUCPMTA) with SMTP id 32.FD.04846.4B01F355; Tue,
 28 Apr 2015 05:46:44 +0100 (BST)
Received: from localhost.localdomain ([10.252.80.64])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0NNI00A672LDPN10@eusync1.samsung.com>; Tue,
 28 Apr 2015 05:46:41 +0100 (BST)
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
Subject: [PATCH v2 1/8] clk: rockchip: Staticize file-scope declarations
Date:   Tue, 28 Apr 2015 13:46:16 +0900
Message-id: <1430196383-9190-2-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1430196383-9190-1-git-send-email-k.kozlowski@samsung.com>
References: <1430196383-9190-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42I5/e/4Zd0tAvahBv8nSVg8OdTLbHH9y3NW
        i3OvHrFY/H/0mtVi0v0JLBbfHi5ktHj9wtCi//FrZotNj6+xWnzsucdqcXnXHDaLCVMnsVt8
        evCf2WLG+X1MFp1fZrFZPJ1wkc1i0tqpjBY356dZXNqjYnH4TTurxY8z3SwWrw62sVj83DWP
        xWLVrj+MDhIel/t6mTx2zrrL7rFpVSebx51re9g8jq5cy+SxeUm9R2/zOzaPvi2rGD22X5vH
        7PF5k5zHxrmhAdxRXDYpqTmZZalF+nYJXBkHe3ezFmzjquh/u4KpgfEnRxcjJ4eEgInE0/UP
        GCFsMYkL99azdTFycQgJLGWUmNTwlAXC+c8oMfHTUSaQKjYBY4nNy5eAVYkI9LBJbH16jxkk
        wSxQJTHv7Q5WEFtYwENi7p0tLCA2i4CqxIsFM9lBbF4BN4n+r10sEOvkJE4emwxWzyngLtHf
        3AdkcwBtc5Po7MqfwMi7gJFhFaNoamlyQXFSeq6hXnFibnFpXrpecn7uJkZIzHzZwbj4mNUh
        RgEORiUe3gxm+1Ah1sSy4srcQ4wSHMxKIrzFf+xChXhTEiurUovy44tKc1KLDzFKc7AoifPO
        3fU+REggPbEkNTs1tSC1CCbLxMEp1cCo+W+N3W7vpWGd0prxjTVLrlYvrXtuOVWt5KXOowyV
        P2nPbUM5PuzhvM9+eefMIOX+V98uafo3RHtucw3hiJi/qcr4xlp2g/0nm7/rhrhWP/FsSO/1
        L5R4zLdd+oeIldK6Y5kTpFPLAhxyGxpeNKxXSPqVxHrx6sm25sUnvL43a5vcVymfyaXEUpyR
        aKjFXFScCABHqM0clQIAAA==
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47104
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

Add missing static to local (file-scope only) symbols.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/rockchip/clk-rk3188.c | 2 +-
 drivers/clk/rockchip/clk-rk3288.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index 556ce041d371..e4f9d472f1ff 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -26,7 +26,7 @@ enum rk3188_plls {
 	apll, cpll, dpll, gpll,
 };
 
-struct rockchip_pll_rate_table rk3188_pll_rates[] = {
+static struct rockchip_pll_rate_table rk3188_pll_rates[] = {
 	RK3066_PLL_RATE(2208000000, 1, 92, 1),
 	RK3066_PLL_RATE(2184000000, 1, 91, 1),
 	RK3066_PLL_RATE(2160000000, 1, 90, 1),
diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index d17eb4528a28..4f817ed9e6ee 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -27,7 +27,7 @@ enum rk3288_plls {
 	apll, dpll, cpll, gpll, npll,
 };
 
-struct rockchip_pll_rate_table rk3288_pll_rates[] = {
+static struct rockchip_pll_rate_table rk3288_pll_rates[] = {
 	RK3066_PLL_RATE(2208000000, 1, 92, 1),
 	RK3066_PLL_RATE(2184000000, 1, 91, 1),
 	RK3066_PLL_RATE(2160000000, 1, 90, 1),
-- 
1.9.1
