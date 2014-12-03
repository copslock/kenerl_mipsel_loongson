Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Dec 2014 00:44:51 +0100 (CET)
Received: from mail-ig0-f179.google.com ([209.85.213.179]:40228 "EHLO
        mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007982AbaLCXocnXdT3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Dec 2014 00:44:32 +0100
Received: by mail-ig0-f179.google.com with SMTP id r2so13733414igi.0
        for <multiple recipients>; Wed, 03 Dec 2014 15:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ShC3tih2RpPwD5pYfqF2bfA5m5m2NXZHbvtzct7Fp88=;
        b=ZZ3sRKhyVI6MgF53+myKSomxkjbD7s10BmuxLDF2l2mEYurdE0tBq7ugh+S0QL9NX/
         VMdHcsGDLY//g1McIg/mCC2Di7S/Irp/eGlvHdwNOlH+YT7EKQBdQ0z4SLlYLKKJbfMq
         wjC5xgU5vnjRe9fjLQHYYT2GfC5qs4XMPMHO0R8N5XNe1sT0EfY4g2vS61vdcx46KpLG
         yNMCUQA3O6p6OpI8A5iNnWLcrNQtxS6eua93iXkTKZSRTzAl6fNraehYdXI5Ct1SvENV
         e+X8jUxoOTQVdbn88lHoCzmTRM+N9nAiFmp3aPhVwlShrHv1NWBQT0VFhnFU/kGtlq+S
         1BMg==
X-Received: by 10.50.66.144 with SMTP id f16mr59539821igt.3.1417650266941;
        Wed, 03 Dec 2014 15:44:26 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id s10sm14382414igr.2.2014.12.03.15.44.25
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 03 Dec 2014 15:44:26 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id sB3NiPww002853;
        Wed, 3 Dec 2014 15:44:25 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id sB3NiOtA002852;
        Wed, 3 Dec 2014 15:44:24 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Zubair.Kakakhel@imgtec.com, geert+renesas@glider.be,
        peterz@infradead.org, paul.gortmaker@windriver.com,
        macro@linux-mips.org, chenhc@lemote.com, cl@linux.com,
        mingo@kernel.org, richard@nod.at, zajec5@gmail.com,
        james.hogan@imgtec.com, keescook@chromium.org, tj@kernel.org,
        alex@alex-smith.me.uk, pbonzini@redhat.com, blogic@openwrt.org,
        paul.burton@imgtec.com, qais.yousef@imgtec.com,
        linux-kernel@vger.kernel.org, markos.chandras@imgtec.com,
        dengcheng.zhu@imgtec.com, manuel.lauss@gmail.com,
        lars.persson@axis.com, David Daney <david.daney@cavium.com>
Subject: [PATCH 1/3] MIPS: Add FPU emulator counter for non-FPU instructions emulated.
Date:   Wed,  3 Dec 2014 15:44:16 -0800
Message-Id: <1417650258-2811-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1417650258-2811-1-git-send-email-ddaney.cavm@gmail.com>
References: <1417650258-2811-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44562
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

Used in follow-on patch, the counter is called "insn_emul".

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/fpu_emulator.h | 1 +
 arch/mips/math-emu/me-debugfs.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/mips/include/asm/fpu_emulator.h b/arch/mips/include/asm/fpu_emulator.h
index 6370c82..bd5b63f 100644
--- a/arch/mips/include/asm/fpu_emulator.h
+++ b/arch/mips/include/asm/fpu_emulator.h
@@ -45,6 +45,7 @@ struct mips_fpu_emulator_stats {
 	unsigned long ieee754_zerodiv;
 	unsigned long ieee754_invalidop;
 	unsigned long ds_emul;
+	unsigned long insn_emul;
 };
 
 DECLARE_PER_CPU(struct mips_fpu_emulator_stats, fpuemustats);
diff --git a/arch/mips/math-emu/me-debugfs.c b/arch/mips/math-emu/me-debugfs.c
index f308e0f..93fc155 100644
--- a/arch/mips/math-emu/me-debugfs.c
+++ b/arch/mips/math-emu/me-debugfs.c
@@ -62,6 +62,7 @@ do {									\
 	FPU_STAT_CREATE(ieee754_zerodiv);
 	FPU_STAT_CREATE(ieee754_invalidop);
 	FPU_STAT_CREATE(ds_emul);
+	FPU_STAT_CREATE(insn_emul);
 
 	return 0;
 }
-- 
1.7.11.7
