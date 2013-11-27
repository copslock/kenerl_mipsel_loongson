Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Nov 2013 22:27:43 +0100 (CET)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:39892 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817179Ab3K0V1kayIzT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Nov 2013 22:27:40 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id 1092C56F421;
        Wed, 27 Nov 2013 23:27:37 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id ntVXOGDkNopu; Wed, 27 Nov 2013 23:27:32 +0200 (EET)
Received: from blackmetal.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp6.welho.com (Postfix) with ESMTP id 0DCC35BC007;
        Wed, 27 Nov 2013 23:27:32 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH RESEND] MIPS: cavium-octeon: register octeon-hcd platform device
Date:   Wed, 27 Nov 2013 23:27:16 +0200
Message-Id: <1385587636-4465-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 1.8.4.3
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

The forthcoming octeon-hcd USB driver (currently in staging) needs to be
converted into a proper platform device. Before we can do that we need
to register the device in OCTEON platform setup, so that e.g. EdgeRouter
Lite users continue to have a working USB.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/octeon-platform.c | 58 +++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 1830874..6d01582 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -166,6 +166,64 @@ out:
 }
 device_initcall(octeon_ohci_device_init);
 
+static int __init octeon_hcd_device_init(void)
+{
+	struct resource usb_res;
+	struct platform_device *pdev;
+
+	if (!(OCTEON_IS_MODEL(OCTEON_CN56XX) ||
+	      OCTEON_IS_MODEL(OCTEON_CN52XX) ||
+	      OCTEON_IS_MODEL(OCTEON_CN50XX) ||
+	      OCTEON_IS_MODEL(OCTEON_CN31XX) ||
+	      OCTEON_IS_MODEL(OCTEON_CN30XX)))
+		return 0;
+
+	if (octeon_is_simulation() || usb_disabled())
+		return 0;
+
+	/*
+	 * Only CN52XX and CN56XX have DWC_OTG USB hardware and the IOB priority
+	 * registers. Under heavy network load USB hardware can be starved by
+	 * the IOB causing a crash. Give it a priority boost if it has been
+	 * waiting more than 400 cycles to avoid this situation.
+	 *
+	 * Testing indicates that a cnt_val of 8192 is not sufficient, but no
+	 * failures are seen with 4096. We choose a value of 400 to give a
+	 * safety factor of 10.
+	 */
+	if (OCTEON_IS_MODEL(OCTEON_CN52XX) || OCTEON_IS_MODEL(OCTEON_CN56XX)) {
+		union cvmx_iob_n2c_l2c_pri_cnt pri_cnt;
+
+		pri_cnt.u64 = 0;
+		pri_cnt.s.cnt_enb = 1;
+		pri_cnt.s.cnt_val = 400;
+		cvmx_write_csr(CVMX_IOB_N2C_L2C_PRI_CNT, pri_cnt.u64);
+	}
+
+	memset(&usb_res, 0, sizeof(usb_res));
+	usb_res.start = OCTEON_IRQ_USB0;
+	usb_res.end   = OCTEON_IRQ_USB0;
+	usb_res.flags = IORESOURCE_IRQ;
+	pdev = platform_device_register_simple("octeon-hcd", 0, &usb_res, 1);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	/* For all chips except CN52XX there is only one port. */
+	if (!OCTEON_IS_MODEL(OCTEON_CN52XX))
+		return 0;
+
+	memset(&usb_res, 0, sizeof(usb_res));
+	usb_res.start = OCTEON_IRQ_USB1;
+	usb_res.end   = OCTEON_IRQ_USB1;
+	usb_res.flags = IORESOURCE_IRQ;
+	pdev = platform_device_register_simple("octeon-hcd", 1, &usb_res, 1);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	return 0;
+}
+device_initcall(octeon_hcd_device_init);
+
 #endif /* CONFIG_USB */
 
 static struct of_device_id __initdata octeon_ids[] = {
-- 
1.8.4.3
