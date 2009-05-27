Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 May 2009 13:14:24 +0100 (BST)
Received: from mail-bw0-f177.google.com ([209.85.218.177]:43473 "EHLO
	mail-bw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024070AbZE0MOR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 27 May 2009 13:14:17 +0100
Received: by bwz25 with SMTP id 25so4702532bwz.0
        for <multiple recipients>; Wed, 27 May 2009 05:14:11 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=5C3ncmJgti/o7AdFTrCsrxjtNXt1vy5UIrWzqWMh9yw=;
        b=W6BdzMBsiSdodTBknZ69/apekMUG95eebqNPp01KwOJx9pJqLHyETqCLXG6JrEj95q
         x37VhWu/j3AlWXDeOyj32a+mfq10VEZofmhVz768K1XdCda3mtGJp9f8FznguongD02U
         irvRtvD7ti73qtbQ+o64riHkJzsMk6mhm0hnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=XTPF3YrVuuUTgzRYdwZahyNS4hLcuZcxD41peDAPhP2CvxA2K06C3r0bHddcBQnzYT
         mz95NSBsslay3nSh+ySOhcqVQ1asuWB45Wf+7bbRudIT+cM8yCZQnYKz3RnhpJABeyCz
         Zur8u/at9yplESczk7nTIyOIxsCmByUotkiT0=
Received: by 10.103.169.18 with SMTP id w18mr5036236muo.101.1243426451472;
        Wed, 27 May 2009 05:14:11 -0700 (PDT)
Received: from ?192.168.2.188? (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id s10sm5785449mue.8.2009.05.27.05.14.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 May 2009 05:14:10 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Wed, 27 May 2009 14:14:06 +0200
Subject: [PATCH] rb532: fix irq number check in rb532_set_type
MIME-Version: 1.0
X-UID:	120
X-Length: 1593
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200905271414.07074.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23006
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

We only have 14 GPIO interrupt sources numbered
from 0 to 13. Therefore the check against irq_nr
in rb532_set_type is off-by-one. This fixes a mistake
introduced by commit 1b4f571632ffb0caa4170d886694f2555c0d9a4b.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/rb532/irq.c b/arch/mips/rb532/irq.c
index 8ac4372..f078820 100644
--- a/arch/mips/rb532/irq.c
+++ b/arch/mips/rb532/irq.c
@@ -175,7 +175,7 @@ static int rb532_set_type(unsigned int irq_nr, unsigned type)
 	int gpio = irq_nr - GPIO_MAPPED_IRQ_BASE;
 	int group = irq_to_group(irq_nr);
 
-	if (group != GPIO_MAPPED_IRQ_GROUP || irq_nr >= (GROUP4_IRQ_BASE + 13))
+	if (group != GPIO_MAPPED_IRQ_GROUP || irq_nr > (GROUP4_IRQ_BASE + 13))
 		return (type == IRQ_TYPE_LEVEL_HIGH) ? 0 : -EINVAL;
 
 	switch (type) {
