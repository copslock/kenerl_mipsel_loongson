Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2017 15:17:24 +0200 (CEST)
Received: from mail-pg0-x229.google.com ([IPv6:2607:f8b0:400e:c05::229]:36421
        "EHLO mail-pg0-x229.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993419AbdDFNQgA1Rli (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Apr 2017 15:16:36 +0200
Received: by mail-pg0-x229.google.com with SMTP id g2so35552703pge.3
        for <linux-mips@linux-mips.org>; Thu, 06 Apr 2017 06:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oNyvOih6c9AGh/s+I5OZj3Lb0Vucmuh8RcDftbFA2Bo=;
        b=hySPdRWlTIW3uVuJSd//rIplcPUChjNOWvw/K9MbdDdVDvtd1Ujn6jVF5KgDSFY8Ah
         GiVgocdHP+X8M24NUeGuTd30zokv5JNK+82BP7m8HlwczQO1ys+2iycXx1ufSNpHckMR
         g6Hqz3gIVWnz3z/kdOSPj7pl9Z3ARGGeFk0Kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oNyvOih6c9AGh/s+I5OZj3Lb0Vucmuh8RcDftbFA2Bo=;
        b=oXdyHcRg+ZG53WlIAtqasnI8QQ+tg696COX4cxOGyqFUaNwZjtuA1OPqQZ2sjM2AHX
         tqWBdZKPvf/UtLjFZCP3kx8rsAGckkssf1kx7Y1ZqUgCeWqyNZafAgesxFkkQmacMMfo
         wy0VcUDRBfxW3I1PBdmkdEmY9jTG4wkfXwD5L3IIjIKIKJ3FZgXTF2k/TgbPMyas++gR
         N2T0T8c0/+oVkeECZUHuk1de7d7OGEjXkcjzGeGgknjHbzJW6e6u5m+O4+VPzkP0pkMR
         DVB46uLSIhExKLtnFabK+wAWFHOOL6deZ5VCdk9TimDMybWk714I+KFT96jXJG37EnYe
         rYpQ==
X-Gm-Message-State: AFeK/H0IVb3kw3DG2CzMs3YRH2l26/P/MsQnJKTHVp2HFO28RhLTL0MaLxnKfJ1QrPtbdJhF
X-Received: by 10.99.231.17 with SMTP id b17mr35926852pgi.55.1491484590115;
        Thu, 06 Apr 2017 06:16:30 -0700 (PDT)
Received: from localhost.localdomain ([106.51.240.246])
        by smtp.gmail.com with ESMTPSA id y6sm4018940pgc.40.2017.04.06.06.16.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Apr 2017 06:16:29 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org, james.hogan@imgtec.com,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH for-4.9 3/7] MIPS: Only change $28 to thread_info if coming from user mode
Date:   Thu,  6 Apr 2017 18:46:09 +0530
Message-Id: <1491484573-6228-4-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1491484573-6228-1-git-send-email-amit.pundir@linaro.org>
References: <1491484573-6228-1-git-send-email-amit.pundir@linaro.org>
Return-Path: <amit.pundir@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57594
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
