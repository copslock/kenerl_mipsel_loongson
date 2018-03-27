Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2018 18:40:20 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:34052 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994737AbeC0QkDVUF-e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Mar 2018 18:40:03 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D00B510C8;
        Tue, 27 Mar 2018 16:39:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mathias Kresin <dev@kresin.me>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.15 004/105] MIPS: lantiq: Enable AHB Bus for USB
Date:   Tue, 27 Mar 2018 18:26:44 +0200
Message-Id: <20180327162758.010063910@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63262
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Kresin <dev@kresin.me>

commit 3223a5a7d3a606dcb7d9190a788b9544a45441ee upstream.

On Danube and AR9 the USB core is connected though a AHB bus to the main
system cross bar, hence we need to enable the gating clock of the AHB
Bus as well to make the USB controller work.

Fixes: dea54fbad332 ("phy: Add an USB PHY driver for the Lantiq SoCs using the RCU module")
Signed-off-by: Mathias Kresin <dev@kresin.me>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: John Crispin <john@phrozen.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.14+
Patchwork: https://patchwork.linux-mips.org/patch/18814/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/lantiq/xway/sysctrl.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -549,9 +549,9 @@ void __init ltq_soc_init(void)
 		clkdev_add_static(ltq_ar9_cpu_hz(), ltq_ar9_fpi_hz(),
 				ltq_ar9_fpi_hz(), CLOCK_250M);
 		clkdev_add_pmu("1f203018.usb2-phy", "phy", 1, 0, PMU_USB0_P);
-		clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0);
+		clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0 | PMU_AHBM);
 		clkdev_add_pmu("1f203034.usb2-phy", "phy", 1, 0, PMU_USB1_P);
-		clkdev_add_pmu("1e106000.usb", "otg", 1, 0, PMU_USB1);
+		clkdev_add_pmu("1e106000.usb", "otg", 1, 0, PMU_USB1 | PMU_AHBM);
 		clkdev_add_pmu("1e180000.etop", "switch", 1, 0, PMU_SWITCH);
 		clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
 		clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
@@ -560,7 +560,7 @@ void __init ltq_soc_init(void)
 	} else {
 		clkdev_add_static(ltq_danube_cpu_hz(), ltq_danube_fpi_hz(),
 				ltq_danube_fpi_hz(), ltq_danube_pp32_hz());
-		clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0);
+		clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0 | PMU_AHBM);
 		clkdev_add_pmu("1f203018.usb2-phy", "phy", 1, 0, PMU_USB0_P);
 		clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
 		clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
