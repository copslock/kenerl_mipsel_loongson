Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Mar 2010 23:37:56 +0100 (CET)
Received: from mail-bw0-f226.google.com ([209.85.218.226]:39727 "EHLO
        mail-bw0-f226.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492362Ab0CAWge (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Mar 2010 23:36:34 +0100
Received: by mail-bw0-f226.google.com with SMTP id 26so2428417bwz.27
        for <multiple recipients>; Mon, 01 Mar 2010 14:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:reply-to:content-type
         :content-transfer-encoding:message-id;
        bh=yFpFrflWQiWE+hFwO8KN6XfCxd8+qeREgASUxSqoJsE=;
        b=RXm/d9LAFbsAQG+ngS9MIx22gV9bsbpTV+TRfFFJWHU8TKaZ7K5EaGmMveXfY1I5R9
         HruDOWmnyQLnCk8MjePLAh8u/FeaZlmaSB/pHpiStS6bQyPm8OFIxND7AM0/HEHS0s0+
         /MIJd2t8iIci/GoDfWg7S+urkUE32B/rQueVA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:reply-to
         :content-type:content-transfer-encoding:message-id;
        b=cAvmu3Knz4tQIUvnKKD7CXtRr/unPK/Amzllk2S0TtREUb3lmJImVgTeFA+I9WdMFg
         iseTiT57BM9cOlNLWyx8kGeQpg+FpfHAJHJYrSRm5ptbsmt32d9QeLJuWoqdWRU7wxjq
         eOgCAUZ4EuI02ffhvlcALj7RT0Pe6GCi1KMW4=
Received: by 10.204.138.81 with SMTP id z17mr3508964bkt.49.1267482994577;
        Mon, 01 Mar 2010 14:36:34 -0800 (PST)
Received: from lenovo.localnet (153.44.69-86.rev.gaoland.net [86.69.44.153])
        by mx.google.com with ESMTPS id e18sm1095439bkd.2.2010.03.01.14.36.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Mar 2010 14:36:34 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Date:   Mon, 1 Mar 2010 23:36:32 +0100
Subject: [PATCH 4/4] bcm63xx: fix BCM6338 and BCM6345 gpio count
MIME-Version: 1.0
X-UID:  180
X-Length: 1415
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Reply-To: Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201003012336.32430.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

The number of GPIOs on BCM6338 is 8, while BCM6345 has only 16 GPIOs
available.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
index 76a0b72..43d4da0 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
@@ -10,6 +10,10 @@ static inline unsigned long bcm63xx_gpio_count(void)
 	switch (bcm63xx_get_cpu_id()) {
 	case BCM6358_CPU_ID:
 		return 40;
+	case BCM6338_CPU_ID:
+		return 8;
+	case BCM6345_CPU_ID:
+		return 16;
 	case BCM6348_CPU_ID:
 	default:
 		return 37;
