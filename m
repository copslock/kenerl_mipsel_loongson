Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Dec 2014 02:53:10 +0100 (CET)
Received: from mail-ie0-f179.google.com ([209.85.223.179]:48297 "EHLO
        mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009103AbaLTBwvcD0Qe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Dec 2014 02:52:51 +0100
Received: by mail-ie0-f179.google.com with SMTP id rp18so1778306iec.10;
        Fri, 19 Dec 2014 17:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jf3NfulJJbEQbm43C5pQAlR4L3PKnJxBpifE1Vb6Rus=;
        b=ikMffkMQN/LV9xwwunXD43xepBOqBUJotzt4Tz7FaxeMWLrOGF1Rpr+L1C6RKwfHaC
         ioWWkWCTBBNJsyK/d2ReFfPvJWI/NnAseDdSwf2w+rxUTV5AyEhvdD13XbUGwIbdIu8C
         InvlqwaTMsmZtffVN6zchqY4Uug7iyMcj9F/kmEhGNmQ8gGGCmCmvW/f4Fc0KmQhL9U8
         BkP/ZT0g++g7ag0tla8l7IZ68y1dzcrirnKM8k3XLjZf9JSiqHCeAQ4R9XL6ps66THii
         Aw9qB7HNc1067F2nXqC/S21It3gBWVpyTcdlU+2J5htNreFqean630WdtY0Ee/S6yEWq
         6B0g==
X-Received: by 10.50.28.49 with SMTP id y17mr6204587igg.3.1419040365748;
        Fri, 19 Dec 2014 17:52:45 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id n17sm2886120igi.2.2014.12.19.17.52.44
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 19 Dec 2014 17:52:45 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id sBK1qhZL008546;
        Fri, 19 Dec 2014 17:52:43 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id sBK1qhLA008544;
        Fri, 19 Dec 2014 17:52:43 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [RFC PATCH v2 1/5] MIPS: Add FPU emulator counter for emulated delay slots.
Date:   Fri, 19 Dec 2014 17:52:36 -0800
Message-Id: <1419040360-8502-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1419040360-8502-1-git-send-email-ddaney.cavm@gmail.com>
References: <1419040360-8502-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44866
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
