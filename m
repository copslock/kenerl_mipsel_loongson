Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 May 2013 22:48:38 +0200 (CEST)
Received: from mail-pa0-f45.google.com ([209.85.220.45]:42141 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827452Ab3EBUsehdY0a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 May 2013 22:48:34 +0200
Received: by mail-pa0-f45.google.com with SMTP id lj1so556884pab.32
        for <multiple recipients>; Thu, 02 May 2013 13:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=5maUXPnDKS1DfnlypYrkitKfZ4D/HNh5ZKLOc1/hOFw=;
        b=Y/4ftL9QwjTj/oBxPkZ5Bn5QrF7RoEDVx2zKza9Gqo3eSb32VdFcmDAYi2bOcN+cr/
         LZX86H3o0Wj+IGWIzr1Efx7fO9PyfBgnSgg46DI+bPOZ8X7UWMcudCNerPi7RvKz4y0X
         elK8TQNqfoUP3v4zy9EKMPy2m0I/lWW09tXg+o6exIc1AYZEMRqVVdWTxL0u0O4HR/9F
         LrXrim4eabSMPEEPVBkLwzLB180Oob7qj7J+oA7ykxz59h264coTae1z+TUKOjM/7tZR
         K10acTKICzUq9F8HkdNfbexBHUwkbzqkwW1MX/epwJ80x4NG8tmsHGMriiCDv1ra3ALq
         ckwQ==
X-Received: by 10.66.88.105 with SMTP id bf9mr11454471pab.175.1367527707231;
        Thu, 02 May 2013 13:48:27 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id aj2sm8636838pbc.1.2013.05.02.13.48.25
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 02 May 2013 13:48:26 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r42KmNDa025844;
        Thu, 2 May 2013 13:48:23 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r42KmLjk025843;
        Thu, 2 May 2013 13:48:21 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonas Gorski <jogo@openwrt.org>
Subject: [PATCH] MIPS: Enable interrupts before WAIT instruction.
Date:   Thu,  2 May 2013 13:48:12 -0700
Message-Id: <1367527692-25809-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <CA+55aFwDGyHOzu=Qh7SJOBK6QvAwAh7pMDL6LfMUE=AW_kapAw@mail.gmail.com>
References: <CA+55aFwDGyHOzu=Qh7SJOBK6QvAwAh7pMDL6LfMUE=AW_kapAw@mail.gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36318
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

As noted by Thomas Gleixner:

   commit cdbedc61c8 (mips: Use generic idle loop) broke MIPS as I did
   not realize that MIPS wants to invoke the wait instructions with
   interrupts enabled.

Instead of enabling interrupts in arch_cpu_idle() as Thomas' initial
patch does, we follow Linus' suggestion of doing it in the assembly
code to prevent the compiler from rearranging things.

Signed-off-by: David Daney <david.daney@cavium.com>
Reported-by: EunBong Song <eunb.song@samsung.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jonas Gorski <jogo@openwrt.org>
---

This is only very lightly tested, we need more testing before
declaring it the definitive fix.

 arch/mips/kernel/genex.S | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index ecb347c..57cda9a 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -132,12 +132,13 @@ LEAF(r4k_wait)
 	.set	noreorder
 	/* start of rollback region */
 	LONG_L	t0, TI_FLAGS($28)
-	nop
 	andi	t0, _TIF_NEED_RESCHED
 	bnez	t0, 1f
 	 nop
-	nop
-	nop
+	/* Enable interrupts so WAIT will complete */
+	mfc0	t0, CP0_STATUS
+	ori	t0, ST0_IE
+	mtc0	t0, CP0_STATUS
 	.set	mips3
 	wait
 	/* end of rollback region (the region size must be power of two) */
-- 
1.7.11.7
