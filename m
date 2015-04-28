Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 06:48:27 +0200 (CEST)
Received: from mailout2.w1.samsung.com ([210.118.77.12]:13123 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010440AbbD1ErRz9Q3w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2015 06:47:17 +0200
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NNI001BL2MOHK60@mailout2.w1.samsung.com>; Tue,
 28 Apr 2015 05:47:12 +0100 (BST)
X-AuditID: cbfec7f4-f79c56d0000012ee-aa-553f10d239ac
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm1.samsung.com (EUCPMTA) with SMTP id E9.FD.04846.2D01F355; Tue,
 28 Apr 2015 05:47:15 +0100 (BST)
Received: from localhost.localdomain ([10.252.80.64])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0NNI00A672LDPN10@eusync1.samsung.com>; Tue,
 28 Apr 2015 05:47:11 +0100 (BST)
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
Subject: [PATCH v2 6/8] clk: sirf: Constify parent names in clock init data
Date:   Tue, 28 Apr 2015 13:46:21 +0900
Message-id: <1430196383-9190-7-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1430196383-9190-1-git-send-email-k.kozlowski@samsung.com>
References: <1430196383-9190-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42I5/e/4Zd3LAvahBg1NTBZPDvUyW1z/8pzV
        4tyrRywW/x+9ZrWYdH8Ci8W3hwsZLV6/MLTof/ya2WLT42usFh977rFaXN41h81iwtRJ7Baf
        Hvxntphxfh+TReeXWWwWTydcZLOYtHYqo8XN+WkWl/aoWBx+085q8eNMN4vFq4NtLBY/d81j
        sVi16w+jg4TH5b5eJo+ds+6ye2xa1cnmcefaHjaPoyvXMnlsXlLv0dv8js2jb8sqRo/t1+Yx
        e3zeJOexcW5oAHcUl01Kak5mWWqRvl0CV0bboxaWgpW8FRfeHWVsYDzA1cXIySEhYCLRe/QF
        O4QtJnHh3nq2LkYuDiGBpYwSfU93MUM4/xklDn+byQZSxSZgLLF5+RKwKhGBHjaJrU/vMYMk
        mAWqJOa93cEKYgsLeEvM/38ezGYRUJW4uWUvUAMHB6+Am8TFHneIbXISJ49NBivhFHCX6G/u
        YwUpEQIq6ezKn8DIu4CRYRWjaGppckFxUnquoV5xYm5xaV66XnJ+7iZGSMR82cG4+JjVIUYB
        DkYlHt4MZvtQIdbEsuLK3EOMEhzMSiK8xX/sQoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzzt31
        PkRIID2xJDU7NbUgtQgmy8TBKdXA6G4heer/liuSZbOeb5Q79Lems2uDvCB3u9/uued8Jf/O
        aXjt7S/zPXFWqK5TwbEddVVmZuufxj2TcAxe/Syd3/fZ4TVe194tcHpT/vvYrg6uKexORdui
        kqPneNksmWUQODVS6vWO98/ifG+VzLpxVmr7icXeISuFJOK3vtvGor2hSSRP49LEMCWW4oxE
        Qy3mouJEABO9EOCUAgAA
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47109
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
 drivers/clk/sirf/clk-common.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/sirf/clk-common.c b/drivers/clk/sirf/clk-common.c
index 37af51c5f213..e9cf5730effe 100644
--- a/drivers/clk/sirf/clk-common.c
+++ b/drivers/clk/sirf/clk-common.c
@@ -188,7 +188,7 @@ static struct clk_ops std_pll_ops = {
 	.set_rate = pll_clk_set_rate,
 };
 
-static const char *pll_clk_parents[] = {
+static const char * const pll_clk_parents[] = {
 	"osc",
 };
 
@@ -284,7 +284,7 @@ static struct clk_hw usb_pll_clk_hw = {
  * clock domains - cpu, mem, sys/io, dsp, gfx
  */
 
-static const char *dmn_clk_parents[] = {
+static const char * const dmn_clk_parents[] = {
 	"rtc",
 	"osc",
 	"pll1",
@@ -673,7 +673,7 @@ static void std_clk_disable(struct clk_hw *hw)
 	clkc_writel(val, reg);
 }
 
-static const char *std_clk_io_parents[] = {
+static const char * const std_clk_io_parents[] = {
 	"io",
 };
 
@@ -949,7 +949,7 @@ static struct clk_std clk_pulse = {
 	},
 };
 
-static const char *std_clk_dsp_parents[] = {
+static const char * const std_clk_dsp_parents[] = {
 	"dsp",
 };
 
@@ -981,7 +981,7 @@ static struct clk_std clk_mf = {
 	},
 };
 
-static const char *std_clk_sys_parents[] = {
+static const char * const std_clk_sys_parents[] = {
 	"sys",
 };
 
@@ -999,7 +999,7 @@ static struct clk_std clk_security = {
 	},
 };
 
-static const char *std_clk_usb_parents[] = {
+static const char * const std_clk_usb_parents[] = {
 	"usb_pll",
 };
 
-- 
1.9.1
