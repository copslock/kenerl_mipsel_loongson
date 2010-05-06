Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 May 2010 19:31:40 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:62885 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492665Ab0EFRaR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 May 2010 19:30:17 +0200
Received: by mail-px0-f177.google.com with SMTP id 1so87780pxi.36
        for <multiple recipients>; Thu, 06 May 2010 10:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=iOziV7NIwmNfj91mLxOeWSxs6T6gvSnHuyo4LNVXzXk=;
        b=dXBqlXuzveplVWlhKba4ouv/UA0j2dqQdNif/UNywjczutJPcXbi5Ba05duQamXtbH
         vLzKeKHpDk6YJjgycGZPDb9U8FbRWMsvAAKqcDBty8jkXw9eiEXxt25iay3bfuicDQOs
         7/eGQgYXyOKLbNIjCvb+ufjnJdDUEDcPomfLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fSlbN2xFAacfPuWQ/FAzpGTqP1jEesyiLwaK28YNI6VykuBXvewvMNd82F5JBIpYPa
         YRmDcv8a6ERg41MS844f7SA6PbHw73nrQ9ITOC+qjP4+Iq471On0cvERlIMZWa/fnuXA
         8cnpdkWXnxqE1JMxh9KOBmzDsUA2ix9KYR7nA=
Received: by 10.115.117.31 with SMTP id u31mr3241425wam.70.1273167016247;
        Thu, 06 May 2010 10:30:16 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id r20sm5257084wam.5.2010.05.06.10.30.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 May 2010 10:30:15 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 3/5] Oprofile: Loongson: Remove unneeded variable from loongson2_cpu_setup()
Date:   Fri,  7 May 2010 01:29:46 +0800
Message-Id: <5ee1e74c10073d930580fe8e21f170a4986175e4.1273166351.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0
In-Reply-To: <cover.1273165681.git.wuzhangjin@gmail.com>
References: <cover.1273165681.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1273166351.git.wuzhangjin@gmail.com>
References: <cover.1273166351.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/oprofile/op_model_loongson2.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/mips/oprofile/op_model_loongson2.c b/arch/mips/oprofile/op_model_loongson2.c
index e2696d9..a03894e 100644
--- a/arch/mips/oprofile/op_model_loongson2.c
+++ b/arch/mips/oprofile/op_model_loongson2.c
@@ -94,10 +94,7 @@ static void loongson2_reg_setup(struct op_counter_config *cfg)
 
 static void loongson2_cpu_setup(void *args)
 {
-	uint64_t perfcount;
-
-	perfcount = (reg.reset_counter2 << 32) | reg.reset_counter1;
-	write_c0_perfcnt(perfcount);
+	write_c0_perfcnt((reg.reset_counter2 << 32) | reg.reset_counter1);
 }
 
 static void loongson2_cpu_start(void *args)
-- 
1.7.0
