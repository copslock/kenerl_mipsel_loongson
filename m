Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 06:47:53 +0200 (CEST)
Received: from mailout4.w1.samsung.com ([210.118.77.14]:9830 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011830AbbD1Eq7igpe0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2015 06:46:59 +0200
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NNI008B12MCPV60@mailout4.w1.samsung.com>; Tue,
 28 Apr 2015 05:47:00 +0100 (BST)
X-AuditID: cbfec7f4-f79c56d0000012ee-9a-553f10c62d3a
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm1.samsung.com (EUCPMTA) with SMTP id E7.FD.04846.6C01F355; Tue,
 28 Apr 2015 05:47:02 +0100 (BST)
Received: from localhost.localdomain ([10.252.80.64])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0NNI00A672LDPN10@eusync1.samsung.com>; Tue,
 28 Apr 2015 05:46:59 +0100 (BST)
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
Subject: [PATCH v2 4/8] clk: tegra: Fix duplicate const for parent names
Date:   Tue, 28 Apr 2015 13:46:19 +0900
Message-id: <1430196383-9190-5-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1430196383-9190-1-git-send-email-k.kozlowski@samsung.com>
References: <1430196383-9190-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42I5/e/4Zd1jAvahBsdeGFk8OdTLbHH9y3NW
        i3OvHrFY/H/0mtVi0v0JLBbfHi5ktHj9wtCi//FrZotNj6+xWnzsucdqcXnXHDaLCVMnsVt8
        evCf2WLG+X1MFp1fZrFZPJ1wkc1i0tqpjBY356dZXNqjYnH4TTurxY8z3SwWrw62sVj83DWP
        xWLVrj+MDhIel/t6mTx2zrrL7rFpVSebx51re9g8jq5cy+SxeUm9R2/zOzaPvi2rGD22X5vH
        7PF5k5zHxrmhAdxRXDYpqTmZZalF+nYJXBmN7ZcZC/awVUzc84u1gXEfaxcjJ4eEgInE3IUn
        oGwxiQv31rN1MXJxCAksZZSYOv0+E4Tzn1GiY/UBFpAqNgFjic3Ll4BViQj0sElsfXqPGSTB
        LFAlMe/tDrBRwgIeEu9+7GECsVkEVCXmrT/LBmLzCrhJvJwzhRlinZzEyWOTweo5Bdwl+pv7
        gGwOoG1uEp1d+RMYeRcwMqxiFE0tTS4oTkrPNdQrTswtLs1L10vOz93ECImZLzsYFx+zOsQo
        wMGoxMObwWwfKsSaWFZcmXuIUYKDWUmEt/iPXagQb0piZVVqUX58UWlOavEhRmkOFiVx3rm7
        3ocICaQnlqRmp6YWpBbBZJk4OKUaGFctuL9ud5ZTmeChTcvqlq8NdXsxy2N/zekzJ92fF2yb
        1WnFLKbCVrXs0VvhN8xHZp79rXw6+6/cqnebvliayfp6a6ak7anMsl957ons0wdlrDteVwma
        bssruhtvv/PephWG0pWPV3GuvDqtgHPF7FNbp2nuCI7PfSI1/6aVXOw5P8P1U6Z+sJyvxFKc
        kWioxVxUnAgAQsaQpZUCAAA=
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47107
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

Replace duplicated const keyword for 'emc_parent_clk_names' with proper
array of const pointers to const strings.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/tegra/clk-emc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-emc.c b/drivers/clk/tegra/clk-emc.c
index 8757feda4a11..59697c61f2f1 100644
--- a/drivers/clk/tegra/clk-emc.c
+++ b/drivers/clk/tegra/clk-emc.c
@@ -45,7 +45,7 @@
 #define CLK_SOURCE_EMC_EMC_2X_CLK_SRC(x) (((x) & CLK_SOURCE_EMC_EMC_2X_CLK_SRC_MASK) << \
 					  CLK_SOURCE_EMC_EMC_2X_CLK_SRC_SHIFT)
 
-static const char const *emc_parent_clk_names[] = {
+static const char * const emc_parent_clk_names[] = {
 	"pll_m", "pll_c", "pll_p", "clk_m", "pll_m_ud",
 	"pll_c2", "pll_c3", "pll_c_ud"
 };
-- 
1.9.1
