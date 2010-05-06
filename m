Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 May 2010 19:04:16 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:54131 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492665Ab0EFREM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 May 2010 19:04:12 +0200
Received: by pxi1 with SMTP id 1so76962pxi.36
        for <multiple recipients>; Thu, 06 May 2010 10:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=bHWEmL7XMcsOjhE/zP9BgQO3dz7aw8aLo2F/tbs5D70=;
        b=DV4nilDX8CK2+QNvPGc52uhijaK5141bB8cA+1nC48s4dGEic0fyunUHkYBAg27U3j
         gHdo/lN/Sy9OImW6J7LxkUVfHmMUYxFj/x1//yZzzimNSJSxcrXVM4YayJvRGZxxaKgC
         q0HeHGqdkeXPo8t7WeEO8EhuqcNbRw8XSfrKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=pBSC/jYHwmIjnm43UaFvCSnpnjouo/5EuqFQ6yPENM8IctlNYTjj9i/hvzpMQH6jVB
         nIaAh2iEyhUdzhF1twNSZazN7lkSOFxJ6h/J/JkU3yFq9TA6XuMIwa3cs+33QoPkJUKI
         HhhQKvjVVCuA/+bCzbxHSMA0oB+1SWZ1nOBi8=
Received: by 10.114.248.22 with SMTP id v22mr12000622wah.8.1273165445912;
        Thu, 06 May 2010 10:04:05 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id r20sm5152948wam.17.2010.05.06.10.04.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 May 2010 10:04:05 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] Oprofile: Loongson: Fixup of loongson2_exit()
Date:   Fri,  7 May 2010 01:03:49 +0800
Message-Id: <1273165429-29766-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26630
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

When exiting from loongson2_exit(), we need to reset the counter
register too, this patch adds a function reset_counters() to do it, by
the way, this function will be shared by Perf.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/oprofile/op_model_loongson2.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/mips/oprofile/op_model_loongson2.c b/arch/mips/oprofile/op_model_loongson2.c
index fa3bf66..01f91a3 100644
--- a/arch/mips/oprofile/op_model_loongson2.c
+++ b/arch/mips/oprofile/op_model_loongson2.c
@@ -51,6 +51,12 @@ static char *oprofid = "LoongsonPerf";
 static irqreturn_t loongson2_perfcount_handler(int irq, void *dev_id);
 /* Compute all of the registers in preparation for enabling profiling.  */
 
+static void reset_counters(void *arg)
+{
+	write_c0_perfctrl(0);
+	write_c0_perfcnt(0);
+}
+
 static void loongson2_reg_setup(struct op_counter_config *cfg)
 {
 	unsigned int ctrl = 0;
@@ -157,7 +163,7 @@ static int __init loongson2_init(void)
 
 static void loongson2_exit(void)
 {
-	write_c0_perfctrl(0);
+	reset_counters(NULL);
 	free_irq(LOONGSON2_PERFCNT_IRQ, oprofid);
 }
 
-- 
1.7.0
