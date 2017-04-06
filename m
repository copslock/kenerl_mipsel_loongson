Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2017 15:53:28 +0200 (CEST)
Received: from mail-pg0-x233.google.com ([IPv6:2607:f8b0:400e:c05::233]:36168
        "EHLO mail-pg0-x233.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993886AbdDFNwiPfTGx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Apr 2017 15:52:38 +0200
Received: by mail-pg0-x233.google.com with SMTP id g2so36428374pge.3
        for <linux-mips@linux-mips.org>; Thu, 06 Apr 2017 06:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oNyvOih6c9AGh/s+I5OZj3Lb0Vucmuh8RcDftbFA2Bo=;
        b=I1PsNpMLvC1fTWKWh2fZ5ubqm7T9uuWyEmW1U5WgG/K9lMgYI4LBHhW3aC3QxOoX/X
         +rvXntutTXi5e/pgQpYB/1MV/uHrykNnaSKp2QH6gl0udZHct+NaWx8W7hgywk6ugwKl
         kfdUTy6sWCOr3NHC0+QtGDFBbn9HpZ3EXxX+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oNyvOih6c9AGh/s+I5OZj3Lb0Vucmuh8RcDftbFA2Bo=;
        b=e63v3DmXrQMuQRcLtImlBPMlcp9k1rHJ6vYNoL2dvQBGbX6Hj4SF2+ul7+FfoJOCdA
         R+fkJyyReE2zMxAv5OAOFFDv55p55wT2ZiwbXPBXgu26WEoYEvMEFnZdEyHtb2N2+V0E
         MhpBbG7llwxikys1/bmK4WbayMIy6PJw7dT+qAsO/1iAI4+sAajFRM2UFyxg8310GaP9
         bOrefpfKD0G3kTZ7fzB24MQBmRdBej2qw5CAEwV03GBxj4q0z0TfTC/RiNwPyEuz/pNa
         YMcqEKl5hXGrPJpZ2B0ztAuTA76kJ4ERT4LYEkRuysv2PXQnk3e4ap+GXatwrdQWByU8
         b7oQ==
X-Gm-Message-State: AFeK/H1FqzvrgmAfE+3dlUpMJ+CwtaCYzjtMUvKK/TRfVzuZnPaIxrKjES3BMKv8yfpR9cOL
X-Received: by 10.84.232.79 with SMTP id f15mr43295574pln.90.1491486752243;
        Thu, 06 Apr 2017 06:52:32 -0700 (PDT)
Received: from localhost.localdomain ([106.51.240.246])
        by smtp.gmail.com with ESMTPSA id v11sm4187210pfi.50.2017.04.06.06.52.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Apr 2017 06:52:31 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org, james.hogan@imgtec.com,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH for-4.10 3/6] MIPS: Only change $28 to thread_info if coming from user mode
Date:   Thu,  6 Apr 2017 19:22:11 +0530
Message-Id: <1491486734-15668-4-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1491486734-15668-1-git-send-email-amit.pundir@linaro.org>
References: <1491486734-15668-1-git-send-email-amit.pundir@linaro.org>
Return-Path: <amit.pundir@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57603
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: amit.pundir@linaro.org
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

From: Matt Redfearn <matt.redfearn@imgtec.com>

The SAVE_SOME macro is used to save the execution context on all
exceptions.
If an exception occurs while executing user code, the stack is switched
to the kernel's stack for the current task, and register $28 is switched
to point to the current_thread_info, which is at the bottom of the stack
region.
If the exception occurs while executing kernel code, the stack is left,
and this change ensures that register $28 is not updated. This is the
correct behaviour when the kernel can be executing on the separate irq
stack, because the thread_info will not be at the base of it.

With this change, register $28 is only switched to it's kernel
conventional usage of the currrent thread info pointer at the point at
which execution enters kernel space. Doing it on every exception was
redundant, but OK without an IRQ stack, but will be erroneous once that
is introduced.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Acked-by: Jason A. Donenfeld <jason@zx2c4.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/14742/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
(cherry picked from commit 510d86362a27577f5ee23f46cfb354ad49731e61)
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 arch/mips/include/asm/stackframe.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index eebf395..2f182bd 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -216,12 +216,19 @@
 		LONG_S	$25, PT_R25(sp)
 		LONG_S	$28, PT_R28(sp)
 		LONG_S	$31, PT_R31(sp)
+
+		/* Set thread_info if we're coming from user mode */
+		mfc0	k0, CP0_STATUS
+		sll	k0, 3		/* extract cu0 bit */
+		bltz	k0, 9f
+
 		ori	$28, sp, _THREAD_MASK
 		xori	$28, _THREAD_MASK
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
 		.set    mips64
 		pref    0, 0($28)       /* Prefetch the current pointer */
 #endif
+9:
 		.set	pop
 		.endm
 
-- 
2.7.4
