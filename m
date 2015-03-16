Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Mar 2015 19:19:58 +0100 (CET)
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:38136 "EHLO
        ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013947AbbCPSTEGD6U9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Mar 2015 19:19:04 +0100
Received: from localhost (localhost [127.0.0.1])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id 5704C46090E
        for <linux-mips@linux-mips.org>; Mon, 16 Mar 2015 18:18:59 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
        by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xnSXe1S6iM8l; Mon, 16 Mar 2015 18:18:57 +0000 (GMT)
Received: from pm-laptop.codethink.co.uk (pm-laptop.dyn.ducie.codethink.co.uk [10.24.1.94])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id 9E6324608C3;
        Mon, 16 Mar 2015 18:18:52 +0000 (GMT)
Received: from pm by pm-laptop.codethink.co.uk with local (Exim 4.84)
        (envelope-from <paul.martin@codethink.co.uk>)
        id 1YXZbI-0003Tz-EJ; Mon, 16 Mar 2015 18:18:52 +0000
From:   Paul Martin <paul.martin@codethink.co.uk>
To:     linux-mips@linux-mips.org
Cc:     Paul Martin <paul.martin@codethink.co.uk>
Subject: [PATCH 3/7] MIPS: OCTEON: Set appropriate endianness in L2C registers
Date:   Mon, 16 Mar 2015 18:18:39 +0000
Message-Id: <1426529923-13340-4-git-send-email-paul.martin@codethink.co.uk>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1426529923-13340-1-git-send-email-paul.martin@codethink.co.uk>
References: <1426529923-13340-1-git-send-email-paul.martin@codethink.co.uk>
Return-Path: <paul.martin@codethink.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46408
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.martin@codethink.co.uk
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

Signed-off-by: Paul Martin <paul.martin@codethink.co.uk>
---
 arch/mips/cavium-octeon/octeon-platform.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 12410a2..990c4e4 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -325,8 +325,14 @@ static void __init octeon_ehci_hw_start(struct device *dev)
 	/* Use 64-bit addressing. */
 	ehci_ctl.s.ehci_64b_addr_en = 1;
 	ehci_ctl.s.l2c_addr_msb = 0;
+#ifdef __BIG_ENDIAN
 	ehci_ctl.s.l2c_buff_emod = 1; /* Byte swapped. */
 	ehci_ctl.s.l2c_desc_emod = 1; /* Byte swapped. */
+#else
+	ehci_ctl.s.l2c_buff_emod = 0; /* not swapped. */
+	ehci_ctl.s.l2c_desc_emod = 0; /* not swapped. */
+	ehci_ctl.s.inv_reg_a2 = 1;
+#endif
 	cvmx_write_csr(CVMX_UCTLX_EHCI_CTL(0), ehci_ctl.u64);
 
 	octeon2_usb_clocks_stop();
@@ -381,8 +387,14 @@ static void __init octeon_ohci_hw_start(struct device *dev)
 
 	ohci_ctl.u64 = cvmx_read_csr(CVMX_UCTLX_OHCI_CTL(0));
 	ohci_ctl.s.l2c_addr_msb = 0;
+#ifdef __BIG_ENDIAN
 	ohci_ctl.s.l2c_buff_emod = 1; /* Byte swapped. */
 	ohci_ctl.s.l2c_desc_emod = 1; /* Byte swapped. */
+#else
+	ohci_ctl.s.l2c_buff_emod = 0; /* not swapped. */
+	ohci_ctl.s.l2c_desc_emod = 0; /* not swapped. */
+	ohci_ctl.s.inv_reg_a2 = 1;
+#endif
 	cvmx_write_csr(CVMX_UCTLX_OHCI_CTL(0), ohci_ctl.u64);
 
 	octeon2_usb_clocks_stop();
-- 
2.1.4
