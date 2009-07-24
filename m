Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jul 2009 13:19:06 +0200 (CEST)
Received: from mail-ew0-f207.google.com ([209.85.219.207]:41171 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492212AbZGXLSu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Jul 2009 13:18:50 +0200
Received: by ewy3 with SMTP id 3so1144208ewy.0
        for <multiple recipients>; Fri, 24 Jul 2009 04:18:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=BXuuLo5xG6SZf1FdoKS3TY7MhzDT1UnnFNRXarPEGl0=;
        b=xc//dXnvJtNHyQYKnmCj0QGUwWehuWdp2yvNboeSh2putblVGpS7MbGZVb+6Rj36I0
         w7Wc0BidWQQBHBFP0dI79UFwEkzRbuHP4Z4GhDDGcE+KsVt7++deR4RAVYF+pZYToYx3
         NaufJu9SUJ0LjQdNhgN0QiQl92rhiQxjtql4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=QQDNGhYe1pzaTIpWow+AOflbVCK3lKK9xmuLk/OAPDpBAgLNEuIcmCZygU/RqsD0AU
         rh6RA+eNlugXy4a5foossjW5s0+3QGvHsVmUkkKKtd4mMVoXd1L3xPz7Bl52RaJsIoNl
         Kd0R8ctOtYH+yM9LVJgmKgYuKCGhfOwk5irDw=
Received: by 10.211.179.6 with SMTP id g6mr4077968ebp.65.1248434324741;
        Fri, 24 Jul 2009 04:18:44 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 10sm2050564eyd.47.2009.07.24.04.18.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Jul 2009 04:18:44 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Fri, 24 Jul 2009 13:18:42 +0200
Subject: [PATCH 2/3] ar7: remove unused tnetd7200_get_clock function
MIME-Version: 1.0
X-UID:	772
X-Length: 1654
To:	linux-mips@linux-mips.org
Cc:	Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200907241318.42458.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23769
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch removes the unused tnetd7200_get_clock function.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/ar7/clock.c b/arch/mips/ar7/clock.c
index b8c7c84..3a124f1 100644
--- a/arch/mips/ar7/clock.c
+++ b/arch/mips/ar7/clock.c
@@ -264,19 +264,6 @@ static void __init tnetd7300_init_clocks(void)
 	iounmap(bootcr);
 }
 
-static int tnetd7200_get_clock(int base, struct tnetd7200_clock *clock,
-	u32 *bootcr, u32 bus_clock)
-{
-	int divisor = ((readl(&clock->prediv) & 0x1f) + 1) *
-		((readl(&clock->postdiv) & 0x1f) + 1);
-
-	if (*bootcr & BOOT_PLL_BYPASS)
-		return base / divisor;
-
-	return base * ((readl(&clock->mul) & 0xf) + 1) / divisor;
-}
-
-
 static void tnetd7200_set_clock(int base, struct tnetd7200_clock *clock,
 	int prediv, int postdiv, int postdiv2, int mul, u32 frequency)
 {
