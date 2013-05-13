Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 May 2013 22:57:00 +0200 (CEST)
Received: from mail-ie0-f176.google.com ([209.85.223.176]:33772 "EHLO
        mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827465Ab3EMU453p80Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 May 2013 22:56:57 +0200
Received: by mail-ie0-f176.google.com with SMTP id at1so13343911iec.35
        for <multiple recipients>; Mon, 13 May 2013 13:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=xvO8iR9QxOGvrRpwyrGMDcTMGxNMQcayvebHsv+cUp4=;
        b=06hnbst+8G5QxggBPA2vY/VJ0/UvKMl/plf4X1/2tRVlOwMv42jd748vFpooN6hpVb
         A6kYsUaNtivZYQyNAfN+pqCGi/fAPfA+Tobgz6d2qHfByolZ1T1UqvkfgX7n4tNQLdX5
         CgVf9nNpCEywzP+zZVKe+vZpD2svgtcCvZJy1CIgQ/3PRGh6Zn4z5QuiXRZR7nsnpByF
         cs08Evo3t/nRbMGQUWoL9GnobLgB0xhJ5NLlJ+uFda6JR/bnpY/nowtPOoc+WrUxNWJs
         AnHcU4/uSdq6vKBWFOEmfDpT0rcLYpVIiv/lvARjsGcJtf25dkgRk4/oC6CpCuOxs4vS
         Ze2Q==
X-Received: by 10.42.161.4 with SMTP id r4mr15218216icx.8.1368478610853;
        Mon, 13 May 2013 13:56:50 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id pi4sm9447954igb.6.2013.05.13.13.56.49
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 13:56:50 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r4DKulPM014766;
        Mon, 13 May 2013 13:56:47 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r4DKukRw014765;
        Mon, 13 May 2013 13:56:46 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 1/2] Revert "MIPS: microMIPS: Support dynamic ASID sizing."
Date:   Mon, 13 May 2013 13:56:43 -0700
Message-Id: <1368478604-14732-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36396
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

This reverts commit f6b06d9361a008afb93b97fb3683a6e92d69d0f4.

The next revert depends on this one, so this has to go too.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/mm/tlbex.c | 34 ++--------------------------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 4d46d37..2ad41e9 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -309,32 +309,13 @@ static int check_for_high_segbits __cpuinitdata;
 static void __cpuinit insn_fixup(unsigned int **start, unsigned int **stop,
 					unsigned int i_const)
 {
-	unsigned int **p;
+	unsigned int **p, *ip;
 
 	for (p = start; p < stop; p++) {
-#ifndef CONFIG_CPU_MICROMIPS
-		unsigned int *ip;
-
 		ip = *p;
 		*ip = (*ip & 0xffff0000) | i_const;
-#else
-		unsigned short *ip;
-
-		ip = ((unsigned short *)((unsigned int)*p - 1));
-		if ((*ip & 0xf000) == 0x4000) {
-			*ip &= 0xfff1;
-			*ip |= (i_const << 1);
-		} else if ((*ip & 0xf000) == 0x6000) {
-			*ip &= 0xfff1;
-			*ip |= ((i_const >> 2) << 1);
-		} else {
-			ip++;
-			*ip = i_const;
-		}
-#endif
-		local_flush_icache_range((unsigned long)ip,
-					 (unsigned long)ip + sizeof(*ip));
 	}
+	local_flush_icache_range((unsigned long)*p, (unsigned long)((*p) + 1));
 }
 
 #define asid_insn_fixup(section, const)					\
@@ -354,14 +335,6 @@ static void __cpuinit setup_asid(unsigned int inc, unsigned int mask,
 	extern asmlinkage void handle_ri_rdhwr_vivt(void);
 	unsigned long *vivt_exc;
 
-#ifdef CONFIG_CPU_MICROMIPS
-	/*
-	 * Worst case optimised microMIPS addiu instructions support
-	 * only a 3-bit immediate value.
-	 */
-	if(inc > 7)
-		panic("Invalid ASID increment value!");
-#endif
 	asid_insn_fixup(__asid_inc, inc);
 	asid_insn_fixup(__asid_mask, mask);
 	asid_insn_fixup(__asid_version_mask, version_mask);
@@ -369,9 +342,6 @@ static void __cpuinit setup_asid(unsigned int inc, unsigned int mask,
 
 	/* Patch up the 'handle_ri_rdhwr_vivt' handler. */
 	vivt_exc = (unsigned long *) &handle_ri_rdhwr_vivt;
-#ifdef CONFIG_CPU_MICROMIPS
-	vivt_exc = (unsigned long *)((unsigned long) vivt_exc - 1);
-#endif
 	vivt_exc++;
 	*vivt_exc = (*vivt_exc & ~mask) | mask;
 
-- 
1.7.11.7
