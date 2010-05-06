Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 May 2010 19:30:46 +0200 (CEST)
Received: from mail-pz0-f186.google.com ([209.85.222.186]:33357 "EHLO
        mail-pz0-f186.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492643Ab0EFRaL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 May 2010 19:30:11 +0200
Received: by pzk16 with SMTP id 16so91263pzk.22
        for <multiple recipients>; Thu, 06 May 2010 10:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=lOAzQA25IVqUn5fVnz7nhORKt6aOIxn16z0HMKwgla0=;
        b=brxX+Zbqupu4w5DA7O6VP3qn6SvcRI29wEmB+tnPxZ+MmJAP9thUOJlKfFDtv2/G9P
         vxYeQt99O2xrE2U3pI9XABW87+fDU+pkrQ7r/RvYspt9lYzkxhm4bUxfzGrerHt2m5bx
         BlXvqeu92VmLIupcH8UrzrrH00BCtXd/PQ4Bw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=StqNuhwCtlMWzqvN+F/eoHf/fPJZEPaAYzWJjYb6Bx3B5vVnHHCUwGk+gdNR3jmOwS
         ZPWs0I4e8in4T0xGSeyviPOSoIj/w3hw1eifKDNBwrZ1HHWdtRYm5vj4yj8Hm1TrchQ9
         EWE4+w9u++macUbtQBLAnsaQzs5TGZ3LEzVHU=
Received: by 10.115.65.27 with SMTP id s27mr12427302wak.144.1273167003402;
        Thu, 06 May 2010 10:30:03 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id r20sm5257084wam.5.2010.05.06.10.30.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 May 2010 10:30:03 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 1/5] Oprofile: Loongson: add an unified macro for setting events
Date:   Fri,  7 May 2010 01:29:44 +0800
Message-Id: <7e8ede5c83ccf30e08b9fd2966694d3bcaeec776.1273166351.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0
In-Reply-To: <cover.1273165681.git.wuzhangjin@gmail.com>
References: <cover.1273165681.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1273166351.git.wuzhangjin@gmail.com>
References: <cover.1273166351.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch adds an unified macro for counter0 and counter1 to set the
events part in the control register. this macro is needed by Perf, we
prepare it here at first.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/oprofile/op_model_loongson2.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/oprofile/op_model_loongson2.c b/arch/mips/oprofile/op_model_loongson2.c
index 01f91a3..afa0d7c 100644
--- a/arch/mips/oprofile/op_model_loongson2.c
+++ b/arch/mips/oprofile/op_model_loongson2.c
@@ -24,8 +24,8 @@
  */
 #define LOONGSON2_CPU_TYPE	"mips/loongson2"
 
-#define LOONGSON2_COUNTER1_EVENT(event)	((event & 0x0f) << 5)
-#define LOONGSON2_COUNTER2_EVENT(event)	((event & 0x0f) << 9)
+#define LOONGSON2_PERFCTRL_EVENT(idx, event) \
+	(((event) & 0x0f) << ((idx) ? 9 : 5))
 
 #define LOONGSON2_PERFCNT_EXL			(1UL	<<  0)
 #define LOONGSON2_PERFCNT_KERNEL		(1UL    <<  1)
@@ -66,12 +66,12 @@ static void loongson2_reg_setup(struct op_counter_config *cfg)
 	/* Compute the performance counter ctrl word.  */
 	/* For now count kernel and user mode */
 	if (cfg[0].enabled) {
-		ctrl |= LOONGSON2_COUNTER1_EVENT(cfg[0].event);
+		ctrl |= LOONGSON2_PERFCTRL_EVENT(0, cfg[0].event);
 		reg.reset_counter1 = 0x80000000ULL - cfg[0].count;
 	}
 
 	if (cfg[1].enabled) {
-		ctrl |= LOONGSON2_COUNTER2_EVENT(cfg[1].event);
+		ctrl |= LOONGSON2_PERFCTRL_EVENT(1, cfg[1].event);
 		reg.reset_counter2 = (0x80000000ULL - cfg[1].count);
 	}
 
-- 
1.7.0
