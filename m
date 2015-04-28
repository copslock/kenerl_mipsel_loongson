Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 06:49:00 +0200 (CEST)
Received: from mailout3.w1.samsung.com ([210.118.77.13]:64369 "EHLO
        mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008595AbbD1Er2Ijkrs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2015 06:47:28 +0200
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NNI00A8L2N06L60@mailout3.w1.samsung.com>; Tue,
 28 Apr 2015 05:47:24 +0100 (BST)
X-AuditID: cbfec7f5-f794b6d000001495-9c-553f10e06794
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id 78.96.05269.0E01F355; Tue,
 28 Apr 2015 05:47:28 +0100 (BST)
Received: from localhost.localdomain ([10.252.80.64])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0NNI00A672LDPN10@eusync1.samsung.com>; Tue,
 28 Apr 2015 05:47:24 +0100 (BST)
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
Subject: [PATCH v2 8/8] MIPS: Alchemy: Remove unneeded cast removing const
Date:   Tue, 28 Apr 2015 13:46:23 +0900
Message-id: <1430196383-9190-9-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1430196383-9190-1-git-send-email-k.kozlowski@samsung.com>
References: <1430196383-9190-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42I5/e/4Zd0HAvahBhNW6lo8OdTLbHH9y3NW
        i3OvHrFY/H/0mtVi0v0JLBbfHi5ktHj9wtCi//FrZotNj6+xWnzsucdqcXnXHDaLCVMnsVt8
        evCf2WLG+X1MFp1fZrFZPJ1wkc1i0tqpjBY356dZXNqjYnH4TTurxY8z3SwWrw62sVj83DWP
        xWLVrj+MDhIel/t6mTx2zrrL7rFpVSebx51re9g8jq5cy+SxeUm9R2/zOzaPvi2rGD22X5vH
        7PF5k5zHxrmhAdxRXDYpqTmZZalF+nYJXBn7VpxmKbjCVfFo8wrWBsbvHF2MnBwSAiYST9Ys
        YIKwxSQu3FvP1sXIxSEksJRR4sbtJawQzn9GiZNdH9hAqtgEjCU2L18CViUi0MMmsfXpPWaQ
        BLNAlcS8tztYQWxhAS+JK5c/g8VZBFQl1u3uYAexeQXcJH73zmKHWCcncfLYZLB6TgF3if7m
        PiCbA2ibm0RnV/4ERt4FjAyrGEVTS5MLipPSc430ihNzi0vz0vWS83M3MUJi5usOxqXHrA4x
        CnAwKvHwFnDZhwqxJpYVV+YeYpTgYFYS4S3+YxcqxJuSWFmVWpQfX1Sak1p8iFGag0VJnHfm
        rvchQgLpiSWp2ampBalFMFkmDk6pBsYua/OgL9VFX+WjNk/LXr7k33fG+dNfXVfeOVfh2Ptz
        EYe6thXy9p24ZDh7vfSDTCPjs1PkVtes3mE8y9d80Xlu6aDQg016+eIOgYutV+le1tVq7Hh+
        5+2PgNLDmrzfH7AvdvqoqqY7W+OJWc0Kr2QZI4WdlZd5zdJm/n5onviMwz912tY4EQUlluKM
        REMt5qLiRABFaJQmlQIAAA==
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47111
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

Parent names in clock init data is now array of const pointers to const
strings so the cast is not needed.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/mips/alchemy/common/clock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/alchemy/common/clock.c b/arch/mips/alchemy/common/clock.c
index 6a98d2cb402c..6e46abe0dac6 100644
--- a/arch/mips/alchemy/common/clock.c
+++ b/arch/mips/alchemy/common/clock.c
@@ -752,12 +752,12 @@ static int __init alchemy_clk_init_fgens(int ctype)
 	switch (ctype) {
 	case ALCHEMY_CPU_AU1000...ALCHEMY_CPU_AU1200:
 		id.ops = &alchemy_clkops_fgenv1;
-		id.parent_names = (const char **)alchemy_clk_fgv1_parents;
+		id.parent_names = alchemy_clk_fgv1_parents;
 		id.num_parents = 2;
 		break;
 	case ALCHEMY_CPU_AU1300:
 		id.ops = &alchemy_clkops_fgenv2;
-		id.parent_names = (const char **)alchemy_clk_fgv2_parents;
+		id.parent_names = alchemy_clk_fgv2_parents;
 		id.num_parents = 3;
 		break;
 	default:
@@ -961,7 +961,7 @@ static int __init alchemy_clk_setup_imux(int ctype)
 	struct clk *c;
 
 	id.ops = &alchemy_clkops_csrc;
-	id.parent_names = (const char **)alchemy_clk_csrc_parents;
+	id.parent_names = alchemy_clk_csrc_parents;
 	id.num_parents = 7;
 	id.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE;
 
-- 
1.9.1
