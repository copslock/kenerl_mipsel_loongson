Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 06:48:10 +0200 (CEST)
Received: from mailout4.w1.samsung.com ([210.118.77.14]:9850 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011842AbbD1ErKAaW5N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2015 06:47:10 +0200
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NNI008B32MHPV60@mailout4.w1.samsung.com>; Tue,
 28 Apr 2015 05:47:06 +0100 (BST)
X-AuditID: cbfec7f5-f794b6d000001495-7c-553f10ce31e5
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id E2.96.05269.EC01F355; Tue,
 28 Apr 2015 05:47:10 +0100 (BST)
Received: from localhost.localdomain ([10.252.80.64])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0NNI00A672LDPN10@eusync1.samsung.com>; Tue,
 28 Apr 2015 05:47:05 +0100 (BST)
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
Subject: [PATCH v2 5/8] clk: cdce706: Constify parent names in clock init data
Date:   Tue, 28 Apr 2015 13:46:20 +0900
Message-id: <1430196383-9190-6-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1430196383-9190-1-git-send-email-k.kozlowski@samsung.com>
References: <1430196383-9190-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42I5/e/4Zd1zAvahBmeXyVs8OdTLbHH9y3NW
        i3OvHrFY/H/0mtVi0v0JLBbfHi5ktHj9wtCi//FrZotNj6+xWnzsucdqcXnXHDaLCVMnsVt8
        evCf2WLG+X1MFp1fZrFZPJ1wkc1i0tqpjBY356dZXNqjYnH4TTurxY8z3SwWrw62sVj83DWP
        xWLVrj+MDhIel/t6mTx2zrrL7rFpVSebx51re9g8jq5cy+SxeUm9R2/zOzaPvi2rGD22X5vH
        7PF5k5zHxrmhAdxRXDYpqTmZZalF+nYJXBmT7qxjL1jMXjFxWk0D4w/WLkZODgkBE4mnB/5C
        2WISF+6tZ+ti5OIQEljKKNFw4DZYQkjgP6PE1/92IDabgLHE5uVLwIpEBHrYJLY+vccMkmAW
        qJKY93YHWIOwgJ/EpA9LweIsAqoS6+d/ZwGxeQXcJHZ0/maE2CYncfLYZLB6TgF3if7mPiCb
        A2iZm0RnV/4ERt4FjAyrGEVTS5MLipPSc430ihNzi0vz0vWS83M3MULi5esOxqXHrA4xCnAw
        KvHwFnDZhwqxJpYVV+YeYpTgYFYS4S3+YxcqxJuSWFmVWpQfX1Sak1p8iFGag0VJnHfmrvch
        QgLpiSWp2ampBalFMFkmDk6pBkZdxdlHVBNZFnEKmf9M/VH2an+B3Jsdd99rm9VMWir9/jXn
        y5/X/P5tlbts8fyZ85yV8/q3H3nasrB7Vp4Y69X0IE7Pbv9Yrd0meb80Ts+I4S1QLxfcoGFm
        ut9n/2qliU/k9OX03vJcZTyn+adBZVFInUiLwfeldX7nA8Vfn1z+Z8OGvNlmCRJKLMUZiYZa
        zEXFiQBj/ACvkwIAAA==
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47108
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

The array of parent names can be made as array of const pointers to
const strings.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/clk-cdce706.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-cdce706.c b/drivers/clk/clk-cdce706.c
index b8e4f8a822e9..8a2dfd0012f3 100644
--- a/drivers/clk/clk-cdce706.c
+++ b/drivers/clk/clk-cdce706.c
@@ -94,7 +94,7 @@ static const char * const cdce706_source_name[] = {
 	"clk_in0", "clk_in1",
 };
 
-static const char *cdce706_clkin_name[] = {
+static const char * const cdce706_clkin_name[] = {
 	"clk_in",
 };
 
@@ -102,7 +102,7 @@ static const char * const cdce706_pll_name[] = {
 	"pll1", "pll2", "pll3",
 };
 
-static const char *cdce706_divider_parent_name[] = {
+static const char * const cdce706_divider_parent_name[] = {
 	"clk_in", "pll1", "pll2", "pll2", "pll3",
 };
 
-- 
1.9.1
