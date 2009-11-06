Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Nov 2009 11:46:42 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:40411 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492510AbZKFKpx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Nov 2009 11:45:53 +0100
Received: by pwi15 with SMTP id 15so592518pwi.24
        for <multiple recipients>; Fri, 06 Nov 2009 02:45:46 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=IEwX585/EAHLeOBM95S9WJE3D3EYWQG5SFOm5HDumj8=;
        b=wT5uxuTX3kfjdxYFiJg4o1r9Gv7DxYVpk4SIupgNDdpJY5X+uv9Y2URtZpPJoHL0iq
         7N36mMU5mWYkSMig2UPQ91MWkvKvGTW5bKo6FzIB5fD97BwTc+cwVQdfYIf+im+V95vx
         4OHVSs+i/0RednGxaDN2ti3eNckKjWHXpBbFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HwHfRR6K9OhSZ3YPlRv2cqgDv8xVtYXdVV0ltBGrPVXGeteALVhJitri3Y2zdL+sJc
         OzpEXVYTcG2NKS/RwP4sCuvOdRybBcMmy77c+2Ni7aE0wLBtGOlN3AXDyo1JGaYfwsU5
         2QcDnMckaAyauUKDdps9Cpo5flZcJZmTCzQCk=
Received: by 10.115.81.24 with SMTP id i24mr1567117wal.194.1257504345768;
        Fri, 06 Nov 2009 02:45:45 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm763633pxi.6.2009.11.06.02.45.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Nov 2009 02:45:45 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue 2/2] [loongson] oprofile: avoid do_IRQ for perfcounter when the interrupt is from bonito
Date:	Fri,  6 Nov 2009 18:45:06 +0800
Message-Id: <578fdf2cd4a665bb8b56635e2ba7384ec9059ff8.1257504242.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <e1f93f565f4cdf3385f890f1b3a633aca03c2194.1257504242.git.wuzhangjin@gmail.com>
References: <cover.1257504140.git.wuzhangjin@gmail.com>
 <e1f93f565f4cdf3385f890f1b3a633aca03c2194.1257504242.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1257504242.git.wuzhangjin@gmail.com>
References: <cover.1257504242.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24718
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

In loongson2f, the IP6 is shared by bonito and perfcounter, we need to
avoid do_IRQ for perfcounter when the interrupt is from bonito. This
patch does it.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/oprofile/op_model_loongson2.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/mips/oprofile/op_model_loongson2.c b/arch/mips/oprofile/op_model_loongson2.c
index 575cd14..475ff46 100644
--- a/arch/mips/oprofile/op_model_loongson2.c
+++ b/arch/mips/oprofile/op_model_loongson2.c
@@ -1,7 +1,7 @@
 /*
  * Loongson2 performance counter driver for oprofile
  *
- * Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
+ * Copyright (C) 2009 Lemote Inc.
  * Author: Yanhua <yanh@lemote.com>
  * Author: Wu Zhangjin <wuzj@lemote.com>
  *
@@ -125,6 +125,9 @@ static irqreturn_t loongson2_perfcount_handler(int irq, void *dev_id)
 	 */
 
 	/* Check whether the irq belongs to me */
+	enabled = read_c0_perfcnt() & LOONGSON2_PERFCNT_INT_EN;
+	if (!enabled)
+		return IRQ_NONE;
 	enabled = reg.cnt1_enabled | reg.cnt2_enabled;
 	if (!enabled)
 		return IRQ_NONE;
-- 
1.6.2.1
