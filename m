Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Feb 2010 18:46:37 +0100 (CET)
Received: from mail-ew0-f212.google.com ([209.85.219.212]:54659 "EHLO
        mail-ew0-f212.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491998Ab0BURqa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Feb 2010 18:46:30 +0100
Received: by ewy4 with SMTP id 4so565366ewy.27
        for <multiple recipients>; Sun, 21 Feb 2010 09:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:reply-to:content-type
         :content-transfer-encoding:message-id;
        bh=HNwnWDKsWc10LSIWnPKgI72RMxfLqyoBZzqW1fOhnv4=;
        b=koruia2K1efuVBJq1cFmAxX1uKZoztMnGkINd/UIthB6WNZrdPoQ9ylFSMrwuTv3ku
         3lkUhUeanMbrT9YH/InBe2TXB+hq0b/e9VI0N3nTG9u1HUehW64BlIkfoWZNw/V47Ndg
         q43khSAHDddNtrnyzZfE2etDeANFHFbwuTWko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc:reply-to
         :content-type:content-transfer-encoding:message-id;
        b=p7G9okdDuG46N9Fuk/4Of+GcflpaDcjGwP/ZymkPn2rgOnAcZJqmcYedwsNpyL1gNQ
         Y+m1j5S16L3uNLC0hTxpaZG9uNidhqeoUc2v7ZuNSb19pJp+YE0v0p6JKzIcfA6TrYyR
         bhEnkAQvbdMe7Zu/LK+GdEPMqBlHYKFl+P0mw=
Received: by 10.213.96.203 with SMTP id i11mr3718654ebn.9.1266774385308;
        Sun, 21 Feb 2010 09:46:25 -0800 (PST)
Received: from lenovo.localnet (153.44.69-86.rev.gaoland.net [86.69.44.153])
        by mx.google.com with ESMTPS id 5sm7103073eyh.16.2010.02.21.09.46.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Feb 2010 09:46:24 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Date:   Sun, 21 Feb 2010 18:46:22 +0100
Subject: [PATCH -queue] loongson2: fix compile error on arch/mips/oprofile/op_model_loongson2.c
MIME-Version: 1.0
X-UID:  170
X-Length: 1432
To:     linux-mips@linux-mips.org
Cc:     wuzhangjin@gmail.com, ralf@linux-mips.org
Reply-To: Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201002211846.22504.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

flags is now an unused variable, causing a build failure due to -Werror
being turned on.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/oprofile/op_model_loongson2.c b/arch/mips/oprofile/op_model_loongson2.c
index 2ffd47a..29e2326 100644
--- a/arch/mips/oprofile/op_model_loongson2.c
+++ b/arch/mips/oprofile/op_model_loongson2.c
@@ -113,7 +113,6 @@ static irqreturn_t loongson2_perfcount_handler(int irq, void *dev_id)
 	uint64_t counter, counter1, counter2;
 	struct pt_regs *regs = get_irq_regs();
 	int enabled;
-	unsigned long flags;
 
 	/*
 	 * LOONGSON2 defines two 32-bit performance counters.
