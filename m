Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Jan 2011 00:32:13 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13952 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491833Ab1AUXcJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 22 Jan 2011 00:32:09 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d3a17a70000>; Fri, 21 Jan 2011 15:32:55 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 21 Jan 2011 15:32:06 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 21 Jan 2011 15:32:06 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p0LNW2Pd029172;
        Fri, 21 Jan 2011 15:32:03 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p0LNW2rC029171;
        Fri, 21 Jan 2011 15:32:02 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Chandrakala Chavva <cchavva@caviumnetworks.com>,
        David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH v2 1/3] MIPS: Octeon: Fix interrupt irq settings for performance counters.
Date:   Fri, 21 Jan 2011 15:31:58 -0800
Message-Id: <1295652720-29131-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1295652720-29131-1-git-send-email-ddaney@caviumnetworks.com>
References: <1295652720-29131-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 21 Jan 2011 23:32:06.0640 (UTC) FILETIME=[6A7B0700:01CBB9C3]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29018
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

From: Chandrakala Chavva <cchavva@caviumnetworks.com>

Octeon uses different interrupt irq for timer and performance counters.
Set CvmCtl[IPPCI] to correct irq value very early.

Signed-off-by: Chandrakala Chavva <cchavva@caviumnetworks.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/setup.c                    |    7 -------
 .../asm/mach-cavium-octeon/kernel-entry-init.h     |    5 +++++
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index b0c3686..26e9bb3 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -288,7 +288,6 @@ void octeon_user_io_init(void)
 	union octeon_cvmemctl cvmmemctl;
 	union cvmx_iob_fau_timeout fau_timeout;
 	union cvmx_pow_nw_tim nm_tim;
-	uint64_t cvmctl;
 
 	/* Get the current settings for CP0_CVMMEMCTL_REG */
 	cvmmemctl.u64 = read_c0_cvmmemctl();
@@ -392,12 +391,6 @@ void octeon_user_io_init(void)
 			  CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE,
 			  CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE * 128);
 
-	/* Move the performance counter interrupts to IRQ 6 */
-	cvmctl = read_c0_cvmctl();
-	cvmctl &= ~(7 << 7);
-	cvmctl |= 6 << 7;
-	write_c0_cvmctl(cvmctl);
-
 	/* Set a default for the hardware timeouts */
 	fau_timeout.u64 = 0;
 	fau_timeout.s.tout_val = 0xfff;
diff --git a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
index 0b2b5eb..dedef7d 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
@@ -63,6 +63,11 @@
 	# CN30XX Disable instruction prefetching
 	or  v0, v0, 0x2000
 skip:
+	# First clear off CvmCtl[IPPCI] bit and move the performance
+	# counters interrupt to IRQ 6
+	li	v1, ~(7 << 7)
+	and	v0, v0, v1
+	ori	v0, v0, (6 << 7)
 	# Write the cavium control register
 	dmtc0   v0, CP0_CVMCTL_REG
 	sync
-- 
1.7.2.3
