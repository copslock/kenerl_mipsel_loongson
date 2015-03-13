Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Mar 2015 18:36:21 +0100 (CET)
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:46529 "EHLO
        ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013706AbbCMRfqVFTTT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Mar 2015 18:35:46 +0100
Received: from localhost (localhost [127.0.0.1])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id B0973460B85
        for <linux-mips@linux-mips.org>; Fri, 13 Mar 2015 17:35:41 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
        by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id N7ReOg3xiFUS; Fri, 13 Mar 2015 17:35:39 +0000 (GMT)
Received: from pm-laptop.codethink.co.uk (pm-laptop.dyn.ducie.codethink.co.uk [10.24.1.94])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id F342B46095A;
        Fri, 13 Mar 2015 17:35:37 +0000 (GMT)
Received: from pm by pm-laptop.codethink.co.uk with local (Exim 4.84)
        (envelope-from <paul.martin@codethink.co.uk>)
        id 1YWTUn-0000Qk-P1; Fri, 13 Mar 2015 17:35:37 +0000
From:   Paul Martin <paul.martin@codethink.co.uk>
To:     linux-mips@linux-mips.org
Cc:     Paul Martin <paul.martin@codethink.co.uk>
Subject: [PATCH 2/6] MIPS: OCTEON: Ensure CPUs come up little endian
Date:   Fri, 13 Mar 2015 17:34:54 +0000
Message-Id: <1426268098-1603-3-git-send-email-paul.martin@codethink.co.uk>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1426268098-1603-1-git-send-email-paul.martin@codethink.co.uk>
References: <1426268098-1603-1-git-send-email-paul.martin@codethink.co.uk>
Return-Path: <paul.martin@codethink.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46369
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
---
 .../asm/mach-cavium-octeon/kernel-entry-init.h     | 137 ++++++++++++++++++++-
 1 file changed, 136 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
index cf92fe7..b377044 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
@@ -3,7 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2005-2008 Cavium Networks, Inc
+ * Copyright (C) 2005-2012 Cavium, Inc
  */
 #ifndef __ASM_MACH_CAVIUM_OCTEON_KERNEL_ENTRY_H
 #define __ASM_MACH_CAVIUM_OCTEON_KERNEL_ENTRY_H
@@ -26,6 +26,141 @@
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
+#endif	/* CONFIG_HOTPLUG_CPU */
+#ifdef	CONFIG_CPU_LITTLE_ENDIAN
+	.set push
+	.set noreorder
+	/* Hotpplugged CPUs enter in Big-Endian mode, switch here to LE */
+	dmfc0   v0, CP0_CVMCTL_REG
+	nop
+	ori     v0, v0, 2
+	nop
+	dmtc0   v0, CP0_CVMCTL_REG	/* little-endian */
+	nop
+	synci	0($0)
+	.set pop
+#endif	/* CONFIG_CPU_LITTLE_ENDIAN */
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
+#ifdef CONFIG_MAPPED_KERNEL
+	# Set up the TLB index 0 for wired access to kernel.
+	# Assume we were loaded with sufficient alignment so that we
+	# can cover the image with two pages.
+	dla	v0, _end
+	dla	s0, _text
+	dsubu	v0, v0, s0	# size of image
+	move	v1, zero
+	li	t1, -1		# shift count.
+1:	dsrl	v0, v0, 1	# mask into v1
+	dsll	v1, v1, 1
+	daddiu	t1, t1, 1
+	ori	v1, v1, 1
+	bne	v0, zero, 1b
+	daddiu	t2, t1, -6
+	mtc0	v1, $5, 0	# PageMask
+	dla	t3, 0xffffffffc0000000 # kernel address
+	dmtc0	t3, $10, 0	# EntryHi
+	.set push
+	.set noreorder
+	.set nomacro
+	bal	1f
+	nop
+1:
+	.set pop
+
+	dsra	v0, ra, 31
+	daddiu	v0, v0, 1	# if it were a ckseg0 address v0 will be zero.
+	beqz	v0, 3f
+	dli	v0, 0x07ffffffffffffff	# Otherwise assume xkphys.
+	b	2f
+3:
+	dli	v0, 0x7fffffff
+
+2:	and	ra, ra, v0	# physical address of pc in ra
+	dla	v0, 1b
+	dsubu	v0, v0, s0	# distance from _text to 1: in v0
+	dsubu	ra, ra, v0	# ra is physical address of _text
+	dsrl	v1, v1, 1
+	nor	v1, v1, zero
+	and	ra, ra, v1	# mask it with the page mask
+	dsubu	v1, t3, ra	# virtual to physical offset into v1
+	dsrlv	v0, ra, t1
+	dsllv	v0, v0, t2
+	ori	v0, v0, 0x1f
+	dmtc0	v0, $2, 0  # EntryLo1
+	dsrlv	v0, ra, t1
+	daddiu	v0, v0, 1
+	dsllv	v0, v0, t2
+	ori	v0, v0, 0x1f
+	dmtc0	v0, $3, 0  # EntryLo2
+	mtc0	$0, $0, 0  # Set index to zero
+	tlbwi
+	li	v0, 1
+	mtc0	v0, $6, 0  # Wired
+	dla	v0, phys_to_kernel_offset
+	sd	v1, 0(v0)
+	dla	v0, kernel_image_end
+	li	v1, 2
+	dsllv	v1, v1, t1
+	daddu	v1, v1, t3
+	sd	v1, 0(v0)
+	dla	v0, continue_in_mapped_space
+	jr	v0
+
+continue_in_mapped_space:
+#endif
 	# Read the cavium mem control register
 	dmfc0	v0, CP0_CVMMEMCTL_REG
 	# Clear the lower 6 bits, the CVMSEG size
-- 
2.1.4
