Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2017 14:50:20 +0200 (CEST)
Received: from mail-pg0-x229.google.com ([IPv6:2607:f8b0:400e:c05::229]:34921
        "EHLO mail-pg0-x229.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993419AbdDFMtYFUFLi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Apr 2017 14:49:24 +0200
Received: by mail-pg0-x229.google.com with SMTP id 81so35569549pgh.2
        for <linux-mips@linux-mips.org>; Thu, 06 Apr 2017 05:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TOxjxf4ip6bCk7os3b/Ok2YkmVYrOcbigSyMEjr1ACw=;
        b=ImLgf/wYDD9ThzTRX2hH9Yht4DfKUBvrOZ1p7bH6LgXp1t4mD54ZmZzQH52tmd5XSs
         2ECaYayZdnUJxDUyN38RANKbd6aUKfyI7ii1DZFyncKzVC2cAAv7geHvpYd+I2DR3lhq
         jWNCd1Q8uK7WCOJ24HDAO9UHzR69qiGmkZ8kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TOxjxf4ip6bCk7os3b/Ok2YkmVYrOcbigSyMEjr1ACw=;
        b=gVoNk7Iz2kFmC3B6SIMU4WSDfWSXAJXa7KyHYXNNKkR5I4s0euIVYFUpXgEO0TvRfo
         S25cqQ8eUTFbinlssR52TNUMxLcm5hTTgF59Qk7+WhyFO++Iz539cs5UDpb32ZQEplgT
         zx0r/wLHvqq7opr+1SUzWzc8sCdotLn5jWmap9CHHz4QZ3GglkAukMkUeAYgsB/j7e/X
         Z23A3amUZjT2c+gAH8vVityG6ouKzAz+fDLzp5rKCNk77uV6hexTm8gV/43W4NNM7wsV
         oSsZHZiL5LeMxGPx4k5fYfejOIGYDnexRZ37c/bpnFVP3/pYliMaTCQmxxKNYBYCu4/s
         dQZA==
X-Gm-Message-State: AFeK/H3X8T7j25BJYYR1v/LWn4QUszCZExIZacSzXzxJAFOnsIb/RZuNGoycM/9Gd513TsWR
X-Received: by 10.99.164.26 with SMTP id c26mr36625230pgf.89.1491482958036;
        Thu, 06 Apr 2017 05:49:18 -0700 (PDT)
Received: from localhost.localdomain ([106.51.240.246])
        by smtp.gmail.com with ESMTPSA id n7sm3892564pfn.0.2017.04.06.05.49.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Apr 2017 05:49:17 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org, james.hogan@imgtec.com,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH for-4.4 3/7] MIPS: Only change $28 to thread_info if coming from user mode
Date:   Thu,  6 Apr 2017 18:18:56 +0530
Message-Id: <1491482940-1163-4-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1491482940-1163-1-git-send-email-amit.pundir@linaro.org>
References: <1491482940-1163-1-git-send-email-amit.pundir@linaro.org>
Return-Path: <amit.pundir@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57587
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
index a71da57..5347f13 100644
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
