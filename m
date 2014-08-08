Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Aug 2014 05:16:50 +0200 (CEST)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:54003 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859995AbaHHDQg5VamL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Aug 2014 05:16:36 +0200
Received: by mail-pa0-f49.google.com with SMTP id hz1so6406436pad.8
        for <multiple recipients>; Thu, 07 Aug 2014 20:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gBXXo26BNZErVfDxm/i1684DaHezhp5IITZ0xWQDUzw=;
        b=ona5j+cdj2X2xN9UtVTPUmeCrvcZOLy89E5qj8e9rE0fmU2vjl6Fz9NRqFm4C8A7BW
         2wmKqcF6h0g0s+q3ki52IGniBqapNtDh7JqLf2aRqJM7g70llACB5bXS+6rjy6f0Rr0V
         iyFBeZDVazAA2eMK2vVg4uiq+YzYn+BYXL+MTNonRtJrEibJW2z28Ps0kqB/MQ2FwqQ3
         buk7kFWaC1/XSiHojKaA+0UqqsFrW4e1xiJhslH7GiGaDkFlqUpwm/Oot/ilY4hsGfeu
         TfL5g6tgjfdEir3a3/BGTJH6Ir1fw+PDlX23KXRyg+eOzuAPuWfRlZX0t12iERdV79GL
         BVyA==
X-Received: by 10.70.131.129 with SMTP id om1mr54714pdb.149.1407467789987;
        Thu, 07 Aug 2014 20:16:29 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id j1sm2005181pdh.31.2014.08.07.20.16.26
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 07 Aug 2014 20:16:29 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 2/2] MIPS: Loongson: Fix COP2 usage for preemptible kernel
Date:   Fri,  8 Aug 2014 11:16:08 +0800
Message-Id: <1407467768-24097-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1407467768-24097-1-git-send-email-chenhc@lemote.com>
References: <1407467768-24097-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41903
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

In preemptible kernel, only TIF_USEDFPU flag is reliable to distinguish
whether _init_fpu()/_restore_fp() is needed. Because the value of the
CP0_Status.CU1 isn't changed during preemption.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/loongson/loongson-3/cop2-ex.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/loongson/loongson-3/cop2-ex.c b/arch/mips/loongson/loongson-3/cop2-ex.c
index 9182e8d..c1e9503 100644
--- a/arch/mips/loongson/loongson-3/cop2-ex.c
+++ b/arch/mips/loongson/loongson-3/cop2-ex.c
@@ -22,13 +22,13 @@
 static int loongson_cu2_call(struct notifier_block *nfb, unsigned long action,
 	void *data)
 {
-	int fpu_enabled;
+	int fpu_owned;
 	int fr = !test_thread_flag(TIF_32BIT_FPREGS);
 
 	switch (action) {
 	case CU2_EXCEPTION:
 		preempt_disable();
-		fpu_enabled = read_c0_status() & ST0_CU1;
+		fpu_owned = __is_fpu_owner();
 		if (!fr)
 			set_c0_status(ST0_CU1 | ST0_CU2);
 		else
@@ -39,8 +39,8 @@ static int loongson_cu2_call(struct notifier_block *nfb, unsigned long action,
 			KSTK_STATUS(current) |= ST0_FR;
 		else
 			KSTK_STATUS(current) &= ~ST0_FR;
-		/* If FPU is enabled, we needn't init or restore fp */
-		if(!fpu_enabled) {
+		/* If FPU is owned, we needn't init or restore fp */
+		if(!fpu_owned) {
 			set_thread_flag(TIF_USEDFPU);
 			if (!used_math()) {
 				_init_fpu();
-- 
1.7.7.3
