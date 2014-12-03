Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Dec 2014 20:12:36 +0100 (CET)
Received: from mail-ie0-f179.google.com ([209.85.223.179]:54250 "EHLO
        mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008036AbaLCTMeozDEW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Dec 2014 20:12:34 +0100
Received: by mail-ie0-f179.google.com with SMTP id rp18so14440495iec.10
        for <multiple recipients>; Wed, 03 Dec 2014 11:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Jf3NfulJJbEQbm43C5pQAlR4L3PKnJxBpifE1Vb6Rus=;
        b=CyN03icV3Yu03W4Sn+bxR1JspX06BM3ON8Bx1H+FgcC6br03sN0DnKT9iW2tuMqmbU
         xGFj3ZaHvRPTQtg0MuqLwvJZNf3UjZpmkkl0kcwe4KHSY4U2+q9+qF8wRjz3E1zsJwxB
         mYJ0yx4WPvmBbLpWstSXC+9BNZn63lUAie3W5wklkhcslwXF55hCOIm1YSmN1tPpRI09
         mVIu/n6O/ibNiH7qy+/qL3nTgKSz7iaKDohucf9+Q7hBtgPuNEK4d5KMZ38niJdgPVxc
         npneQFWmqDEGS5Hmq2ZG0KJCUEOd4r+nsUVqYnnZo3J2DNYzzD0opuHshNR1sOwqGpbn
         EtSg==
X-Received: by 10.107.165.75 with SMTP id o72mr5877278ioe.33.1417633948789;
        Wed, 03 Dec 2014 11:12:28 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id ga11sm8687379igd.4.2014.12.03.11.12.27
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 03 Dec 2014 11:12:28 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id sB3JCQoe024054;
        Wed, 3 Dec 2014 11:12:26 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id sB3JCP0m024053;
        Wed, 3 Dec 2014 11:12:25 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Add FPU emulator counter for emulated delay slots.
Date:   Wed,  3 Dec 2014 11:12:23 -0800
Message-Id: <1417633943-24020-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44559
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

Delay slot emulation in the FPU emulator is the only kernel user of an
executable stack, it is also very slow.  Add a counter so we can see
how many of these emulations are done.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/fpu_emulator.h | 1 +
 arch/mips/math-emu/dsemul.c          | 2 +-
 arch/mips/math-emu/me-debugfs.c      | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/fpu_emulator.h b/arch/mips/include/asm/fpu_emulator.h
index 3ee3477..6370c82 100644
--- a/arch/mips/include/asm/fpu_emulator.h
+++ b/arch/mips/include/asm/fpu_emulator.h
@@ -44,6 +44,7 @@ struct mips_fpu_emulator_stats {
 	unsigned long ieee754_overflow;
 	unsigned long ieee754_zerodiv;
 	unsigned long ieee754_invalidop;
+	unsigned long ds_emul;
 };
 
 DECLARE_PER_CPU(struct mips_fpu_emulator_stats, fpuemustats);
diff --git a/arch/mips/math-emu/dsemul.c b/arch/mips/math-emu/dsemul.c
index 4f514f3..58f5818 100644
--- a/arch/mips/math-emu/dsemul.c
+++ b/arch/mips/math-emu/dsemul.c
@@ -158,6 +158,6 @@ int do_dsemulret(struct pt_regs *xcp)
 
 	/* Set EPC to return to post-branch instruction */
 	xcp->cp0_epc = epc;
-
+	MIPS_FPU_EMU_INC_STATS(ds_emul);
 	return 1;
 }
diff --git a/arch/mips/math-emu/me-debugfs.c b/arch/mips/math-emu/me-debugfs.c
index becdd63..f308e0f 100644
--- a/arch/mips/math-emu/me-debugfs.c
+++ b/arch/mips/math-emu/me-debugfs.c
@@ -61,6 +61,7 @@ do {									\
 	FPU_STAT_CREATE(ieee754_overflow);
 	FPU_STAT_CREATE(ieee754_zerodiv);
 	FPU_STAT_CREATE(ieee754_invalidop);
+	FPU_STAT_CREATE(ds_emul);
 
 	return 0;
 }
-- 
1.7.11.7
