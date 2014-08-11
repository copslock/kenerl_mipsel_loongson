Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Aug 2014 11:11:12 +0200 (CEST)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:50754 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821394AbaHKJLHB-G0h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Aug 2014 11:11:07 +0200
Received: by mail-pa0-f50.google.com with SMTP id et14so10800808pad.9
        for <multiple recipients>; Mon, 11 Aug 2014 02:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=H7k71LaxgSakn9nU6i3DpZ5DQygx4sFZzRIWJNOzgho=;
        b=MryqcOF6yw7kqSrJ9Hg+20fIatFAQi2qKG+IHcTwrsM9KP5aK683iSUns8sJn6IsAK
         ePHGe6LLED9WP2nxo1zkVh4cck75lV6ShkvGNhaF0iwrmvCqC9qcgPdNgcBWguYzF+hM
         Qj5A8K/dDot/Rj7Opl29tiIN23mgvWG5K1HylEMgDPng1a0jXzA09bpE4rAROSEbSvj1
         wJlUiXIy81E8ko9I8ZxOsQxu2LuyqMaBcTNXc3COXJFAuSFPZEGpqrDvGAM0N7+W9Dyh
         JmQ0A8FL4DoM5KVVFOpfaX0Db+mcSSs4/6QfTjPOyhSrbVtHIrGwVjtoewgXVwz8mSfV
         H3tg==
X-Received: by 10.66.142.166 with SMTP id rx6mr2046848pab.128.1407748260527;
        Mon, 11 Aug 2014 02:11:00 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id fx13sm16530781pdb.64.2014.08.11.02.10.54
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 11 Aug 2014 02:10:59 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2] MIPS: Loongson: Fix COP2 usage for preemptible kernel
Date:   Mon, 11 Aug 2014 17:10:38 +0800
Message-Id: <1407748238-15694-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41947
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

V2: Fix coding style.

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
+		if (!fpu_owned) {
 			set_thread_flag(TIF_USEDFPU);
 			if (!used_math()) {
 				_init_fpu();
-- 
1.7.7.3
