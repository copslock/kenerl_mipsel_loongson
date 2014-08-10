Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Aug 2014 18:57:53 +0200 (CEST)
Received: from mail-we0-f178.google.com ([74.125.82.178]:46690 "EHLO
        mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859992AbaHJQ5voRN9j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 10 Aug 2014 18:57:51 +0200
Received: by mail-we0-f178.google.com with SMTP id w61so7749037wes.9
        for <multiple recipients>; Sun, 10 Aug 2014 09:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=E9Gvee2ATPk/AsYHxMRe6JeRVrqZs4Z2O9MtfqizU0Y=;
        b=prGdiEy/QMtPdyeZafISjmxmSrJb5NRnef8oPacYqAtFhqiIwHHGFIw48bXlNkg2kj
         8VpMfqFZPK+DRucRqUc03V4dKMDsNuzRMOaA4OOERmHHfZev7U7XLQt6wBwcqM4Zw5SM
         gAMcksw6yhcbagDGuxQcGHH6QNySdrvXxzxaen584XVWWd82hl6ruy3jkfFe3OJa49sO
         ZLZ0qA6eGbSTIjRFE8o9Vw6+WpgLslgcpAw1Dhfq9C7nvNSYstUP0mRFIda3vhEi61Qb
         xf1vKBkHYgDESGencPtWS0eatU+Bz5es6SEHIpj0opL6aRRPaY2JcskiqqaR9DP3tiSp
         GVHA==
X-Received: by 10.180.75.14 with SMTP id y14mr13565529wiv.79.1407689866198;
        Sun, 10 Aug 2014 09:57:46 -0700 (PDT)
Received: from flagship.roarinelk.net (62-47-45-86.adsl.highway.telekom.at. [62.47.45.86])
        by mx.google.com with ESMTPSA id fi1sm33065820wib.5.2014.08.10.09.57.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 10 Aug 2014 09:57:45 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: [RFC RFC PATCH] MIPS: fix build with newest binutils
Date:   Sun, 10 Aug 2014 18:57:41 +0200
Message-Id: <1407689861-188297-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.0.4
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41946
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

With recent binutils devel, I get the following build failure:
{standard input}: Warning: .gnu_attribute 4,3 requires `softfloat'
  LD      arch/mips/alchemy/common/built-in.o
mipsel-softfloat-linux-gnu-ld: Warning: arch/mips/alchemy/common/built-in.o uses -msoft-float (set by arch/mips/alchemy/common/prom.o), arch/mips/alchemy/common/sleeper.o uses -mhard-float

This hackish patch "fixes" it, but I'm not sure if this is actually
a binutils problem.

---
 arch/mips/Makefile            | 2 +-
 arch/mips/kernel/r4k_fpu.S    | 1 +
 arch/mips/kernel/r4k_switch.S | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 9336509..cffbd49 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -88,7 +88,7 @@ all-$(CONFIG_SYS_SUPPORTS_ZBOOT)+= vmlinuz
 # crossformat linking we rely on the elf2ecoff tool for format conversion.
 #
 cflags-y			+= -G 0 -mno-abicalls -fno-pic -pipe
-cflags-y			+= -msoft-float
+cflags-y			+= -msoft-float -Wa,-msoft-float
 LDFLAGS_vmlinux			+= -G 0 -static -n -nostdlib
 KBUILD_AFLAGS_MODULE		+= -mlong-calls
 KBUILD_CFLAGS_MODULE		+= -mlong-calls
diff --git a/arch/mips/kernel/r4k_fpu.S b/arch/mips/kernel/r4k_fpu.S
index 8352523..10dd5d4 100644
--- a/arch/mips/kernel/r4k_fpu.S
+++ b/arch/mips/kernel/r4k_fpu.S
@@ -31,6 +31,7 @@
 
 	.set	noreorder
 	.set	arch=r4000
+	.set	hardfloat
 
 LEAF(_save_fp_context)
 	cfc1	t1, fcr31
diff --git a/arch/mips/kernel/r4k_switch.S b/arch/mips/kernel/r4k_switch.S
index 4c4ec18..a030f74 100644
--- a/arch/mips/kernel/r4k_switch.S
+++ b/arch/mips/kernel/r4k_switch.S
@@ -34,6 +34,8 @@
  *		       struct thread_info *next_ti, s32 fp_save)
  */
 	.align	5
+	.set hardfloat
+
 	LEAF(resume)
 	mfc0	t1, CP0_STATUS
 	LONG_S	t1, THREAD_STATUS(a0)
-- 
2.0.4
