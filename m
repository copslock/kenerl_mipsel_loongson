Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 May 2013 23:46:59 +0200 (CEST)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:57251 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6820514Ab3EVVqzl6cpn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 May 2013 23:46:55 +0200
Received: by mail-pa0-f49.google.com with SMTP id bi5so2222023pad.8
        for <multiple recipients>; Wed, 22 May 2013 14:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=3d8qx+/42suGw1m9ACSHbaEReoHoP5U3gQaAmtb+j/4=;
        b=F+N3hZE/GpISzphjBPnAqCAW5J6s6MOX8rBx+vqf5OqBVF/2xjfkNJ7s2UIpTYrH/K
         fh5F8ePSk77vlbcROLQUkuv4qJcM4+tob5ccEYwY4tRikq73bYboUiiSioBb2oddeZev
         tHHX7Thrqn2qpC6z5cwZimkP6nMwIj01A7f1KqZUp4uHWvlrZlF8ksGa4Lh+mfFpI1tD
         lUah0ntxviqEPuuDrp+yZTWgQuJePXY0HKYFpj28mBsFlTob1Ti+nuZRutQaRERaGLjm
         SZrAAwDfLQ+SPcNYLBvD8vbwXsxR99Ft4MbY/BcDFQUEYKpRKqjIJQEaNtig5gT/9Rc0
         70kQ==
X-Received: by 10.66.220.197 with SMTP id py5mr10315060pac.86.1369259209174;
        Wed, 22 May 2013 14:46:49 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id ya4sm8712794pbb.24.2013.05.22.14.46.47
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 22 May 2013 14:46:48 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r4MLkkFb029198;
        Wed, 22 May 2013 14:46:46 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r4MLkkgb029197;
        Wed, 22 May 2013 14:46:46 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 2/2] MIPS: OCTEON: Get rid of CONFIG_CAVIUM_OCTEON_HW_FIX_UNALIGNED
Date:   Wed, 22 May 2013 14:46:44 -0700
Message-Id: <1369259204-29164-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36540
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

When you turn it off, the kernel is unusable, so get rid of the option
and always allow unaligned access.

The Octeon specific memcpy intentionally does unaligned accesses and it
must not fault.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/Kconfig                              | 11 -----------
 arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h |  7 +------
 2 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
index ecd359d..4c9f517 100644
--- a/arch/mips/cavium-octeon/Kconfig
+++ b/arch/mips/cavium-octeon/Kconfig
@@ -23,17 +23,6 @@ config CAVIUM_OCTEON_2ND_KERNEL
 	  with this option to be run at the same time as one built without this
 	  option.
 
-config CAVIUM_OCTEON_HW_FIX_UNALIGNED
-	bool "Enable hardware fixups of unaligned loads and stores"
-	default "y"
-	help
-	  Configure the Octeon hardware to automatically fix unaligned loads
-	  and stores. Normally unaligned accesses are fixed using a kernel
-	  exception handler. This option enables the hardware automatic fixups,
-	  which requires only an extra 3 cycles. Disable this option if you
-	  are running code that relies on address exceptions on unaligned
-	  accesses.
-
 config CAVIUM_OCTEON_CVMSEG_SIZE
 	int "Number of L1 cache lines reserved for CVMSEG memory"
 	range 0 54
diff --git a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
index 1e7dbb1..1668ee5 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
@@ -34,15 +34,10 @@
 	ori	v0, CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE
 	dmtc0	v0, CP0_CVMMEMCTL_REG	# Write the cavium mem control register
 	dmfc0	v0, CP0_CVMCTL_REG	# Read the cavium control register
-#ifdef CONFIG_CAVIUM_OCTEON_HW_FIX_UNALIGNED
 	# Disable unaligned load/store support but leave HW fixup enabled
+	# Needed for octeon specific memcpy
 	or  v0, v0, 0x5001
 	xor v0, v0, 0x1001
-#else
-	# Disable unaligned load/store and HW fixup support
-	or  v0, v0, 0x5001
-	xor v0, v0, 0x5001
-#endif
 	# Read the processor ID register
 	mfc0 v1, CP0_PRID_REG
 	# Disable instruction prefetching (Octeon Pass1 errata)
-- 
1.7.11.7
