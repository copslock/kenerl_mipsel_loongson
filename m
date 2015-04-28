Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 06:48:44 +0200 (CEST)
Received: from mailout4.w1.samsung.com ([210.118.77.14]:9859 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011861AbbD1ErWuhgn9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2015 06:47:22 +0200
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NNI008B62MUPV60@mailout4.w1.samsung.com>; Tue,
 28 Apr 2015 05:47:18 +0100 (BST)
X-AuditID: cbfec7f4-f79c56d0000012ee-b5-553f10d9ce2b
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm1.samsung.com (EUCPMTA) with SMTP id 8C.FD.04846.9D01F355; Tue,
 28 Apr 2015 05:47:21 +0100 (BST)
Received: from localhost.localdomain ([10.252.80.64])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0NNI00A672LDPN10@eusync1.samsung.com>; Tue,
 28 Apr 2015 05:47:18 +0100 (BST)
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
Subject: [PATCH v2 7/8] clk: ls1x: Fix duplicate const for parent names
Date:   Tue, 28 Apr 2015 13:46:22 +0900
Message-id: <1430196383-9190-8-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1430196383-9190-1-git-send-email-k.kozlowski@samsung.com>
References: <1430196383-9190-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsVy+t/xy7o3BexDDU62s1o8OdTLbHH9y3NW
        i3OvHrFY/H/0mtVi0v0JLBbfHi5ktHj9wtCi//FrZotNj6+xWnzsucdqcXnXHDaLCVMnsVt8
        evCf2WLG+X1MFp1fZrFZPJ1wkc1i0tqpjBY356dZXNqjYnH4DdCCH2e6WSxeHWxjsfi5ax6L
        xapdfxgdJDwu9/UyeeycdZfdY9OqTjaPO9f2sHkcXbmWyWPzknqP3uZ3bB59W1Yxemy/No/Z
        4/MmOY+Nc0MDuKO4bFJSczLLUov07RK4Ml60OBd0c1Rs7O1mbGB8ytbFyMkhIWAiceP+fHYI
        W0ziwr31QHEuDiGBpYwSXx/vYAFJCAn8Z5R4Nd0cxGYTMJbYvHwJWJGIQA+bxNan95hBEswC
        VRLz3u5g7WLk4BAWcJf49LUExGQRUJVo7qsCqeAVcJNoeLIQaq+cxMljk1lBbE6g6v7mPrBO
        IaCazq78CYy8CxgZVjGKppYmFxQnpeca6hUn5haX5qXrJefnbmKExMqXHYyLj1kdYhTgYFTi
        4c1gtg8VYk0sK67MPcQowcGsJMJb/McuVIg3JbGyKrUoP76oNCe1+BCjNAeLkjjv3F3vQ4QE
        0hNLUrNTUwtSi2CyTBycUg2MfEt3rHg2aT/na6ZTlouK70Qed4mqrov4MUvixV/Ha8Wn2ivb
        JM+ydTvKxG39dWXRq6TkeYmicVLLZpu7plgFaZ9JNGIqWLXZ56Tfv7+RJ/Pd2V5uinCd6VLX
        MGWm+ZtDm1ad2ZPj+9FuyaG/6zlu/fd9ndLq8n97tWTWZAOnJqYZKlOXPrz6WImlOCPRUIu5
        qDgRAK70Ly6RAgAA
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47110
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

Replace duplicated const keyword with proper array of const pointers to
const strings.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/clk-ls1x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-ls1x.c b/drivers/clk/clk-ls1x.c
index ca80103ac188..d4c61985f448 100644
--- a/drivers/clk/clk-ls1x.c
+++ b/drivers/clk/clk-ls1x.c
@@ -80,9 +80,9 @@ static struct clk *__init clk_register_pll(struct device *dev,
 	return clk;
 }
 
-static const char const *cpu_parents[] = { "cpu_clk_div", "osc_33m_clk", };
-static const char const *ahb_parents[] = { "ahb_clk_div", "osc_33m_clk", };
-static const char const *dc_parents[] = { "dc_clk_div", "osc_33m_clk", };
+static const char * const cpu_parents[] = { "cpu_clk_div", "osc_33m_clk", };
+static const char * const ahb_parents[] = { "ahb_clk_div", "osc_33m_clk", };
+static const char * const dc_parents[] = { "dc_clk_div", "osc_33m_clk", };
 
 void __init ls1x_clk_init(void)
 {
-- 
1.9.1
