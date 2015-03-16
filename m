Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Mar 2015 19:19:42 +0100 (CET)
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:38128 "EHLO
        ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013946AbbCPSTClScEj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Mar 2015 19:19:02 +0100
Received: from localhost (localhost [127.0.0.1])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id D890A46090A
        for <linux-mips@linux-mips.org>; Mon, 16 Mar 2015 18:18:57 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
        by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ozbkrDRfXwRI; Mon, 16 Mar 2015 18:18:55 +0000 (GMT)
Received: from pm-laptop.codethink.co.uk (pm-laptop.dyn.ducie.codethink.co.uk [10.24.1.94])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id 57FED460635;
        Mon, 16 Mar 2015 18:18:52 +0000 (GMT)
Received: from pm by pm-laptop.codethink.co.uk with local (Exim 4.84)
        (envelope-from <paul.martin@codethink.co.uk>)
        id 1YXZbI-0003Tp-5q; Mon, 16 Mar 2015 18:18:52 +0000
From:   Paul Martin <paul.martin@codethink.co.uk>
To:     linux-mips@linux-mips.org
Cc:     Paul Martin <paul.martin@codethink.co.uk>
Subject: [PATCH 1/7] MIPS: OCTEON: Ensure CPUs come up little endian
Date:   Mon, 16 Mar 2015 18:18:37 +0000
Message-Id: <1426529923-13340-2-git-send-email-paul.martin@codethink.co.uk>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1426529923-13340-1-git-send-email-paul.martin@codethink.co.uk>
References: <1426529923-13340-1-git-send-email-paul.martin@codethink.co.uk>
Return-Path: <paul.martin@codethink.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46407
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

Even though the bootloader may have switched the main CPU core to
LE mode the other CPU cores may start with endianness dictated by
how their pins are strapped on the board.

Signed-off-by: Paul Martin <paul.martin@codethink.co.uk>
---
 .../asm/mach-cavium-octeon/kernel-entry-init.h     | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
index cf92fe7..7178243 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
@@ -26,6 +26,74 @@
 	# a3 = address of boot descriptor block
 	.set push
 	.set arch=octeon
+#ifdef CONFIG_HOTPLUG_CPU
+	b	7f
+	nop
+
+FEXPORT(octeon_hotplug_entry)
+	move	a0, zero
+	move	a1, zero
+	move	a2, zero
+	move	a3, zero
+7:
+#endif /* CONFIG_HOTPLUG_CPU */
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+	.set push
+	.set noreorder
+	/* Hotplugged CPUs enter in Big-Endian mode, switch here to LE */
+	dmfc0   v0, CP0_CVMCTL_REG
+	nop
+	ori     v0, v0, 2
+	nop
+	dmtc0   v0, CP0_CVMCTL_REG	/* little-endian */
+	nop
+	synci	0($0)
+	.set pop
+#endif /* CONFIG_CPU_LITTLE_ENDIAN */
+	mfc0	v0, CP0_STATUS
+	/* Force 64-bit addressing enabled */
+	ori	v0, v0, (ST0_UX | ST0_SX | ST0_KX)
+	mtc0	v0, CP0_STATUS
+
+	# Clear the TLB.
+	mfc0	v0, $16, 1	# Config1
+	dsrl	v0, v0, 25
+	andi	v0, v0, 0x3f
+	mfc0	v1, $16, 3	# Config3
+	bgez	v1, 1f
+	mfc0	v1, $16, 4	# Config4
+	andi	v1, 0x7f
+	dsll	v1, 6
+	or	v0, v0, v1
+1:				# Number of TLBs in v0
+
+	dmtc0	zero, $2, 0	# EntryLo0
+	dmtc0	zero, $3, 0	# EntryLo1
+	dmtc0	zero, $5, 0	# PageMask
+	dla	t0, 0xffffffff90000000
+10:
+	dmtc0	t0, $10, 0	# EntryHi
+	tlbp
+	mfc0	t1, $0, 0	# Index
+	bltz	t1, 1f
+	tlbr
+	dmtc0	zero, $2, 0	# EntryLo0
+	dmtc0	zero, $3, 0	# EntryLo1
+	dmtc0	zero, $5, 0	# PageMask
+	tlbwi			# Make it a 'normal' sized page
+	daddiu	t0, t0, 8192
+	b	10b
+1:
+	mtc0	v0, $0, 0	# Index
+	tlbwi
+	.set	noreorder
+	bne	v0, zero, 10b
+	 addiu	v0, v0, -1
+	.set	reorder
+
+	mtc0	zero, $0, 0	# Index
+	dmtc0	zero, $10, 0	# EntryHi
+
 	# Read the cavium mem control register
 	dmfc0	v0, CP0_CVMMEMCTL_REG
 	# Clear the lower 6 bits, the CVMSEG size
-- 
2.1.4
