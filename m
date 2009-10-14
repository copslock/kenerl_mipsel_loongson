Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2009 09:56:12 +0200 (CEST)
Received: from fg-out-1718.google.com ([72.14.220.158]:43047 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1491840AbZJNH4F (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Oct 2009 09:56:05 +0200
Received: by fg-out-1718.google.com with SMTP id d23so3199852fga.6
        for <multiple recipients>; Wed, 14 Oct 2009 00:56:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:organization:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        bh=OXC0XzAMJoWalOb3SgOitaYw4K6B06xdUiecJO7Bx8k=;
        b=d9a4t23VKXPzFaJRJ2pCayt0D0G1X8roWcG5tr1YMOYuDmFCt/0OhlRmV2n9NHvp1J
         eOaOTmlvQIChZmVjzWVAr+pBZnkdl3qSaLEUrEmUHYF977un4kkgeRm8O1jKDg2xI1mh
         3pe6GDlwFxOXOPeYgpClKGhnGvMXAXGwTBtFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=LuWk82GmILvUoPNeEj/xJ5CRR7GyTSN9iAiEw9tRB+ITHWsybNVZgZzBZqD3WOixN9
         O0Q0EutZxuaGStAngzB+/qgGvXxAsq984GthrLTxd8qYSPY4oS0ffXZCu1uOwMo8R05a
         ybCbbUturUQ0713Yz2JFUzGiAdsau/XpCieYM=
Received: by 10.86.230.30 with SMTP id c30mr1020815fgh.68.1255506964992;
        Wed, 14 Oct 2009 00:56:04 -0700 (PDT)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id e20sm1200235fga.10.2009.10.14.00.56.02
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 14 Oct 2009 00:56:02 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:	ralf@linux-mips.org
Subject: Re: [PATCH] bcm63xx: set the correct BCM3302 CPU name when built for BCM47xx or BCM63xx
Date:	Wed, 14 Oct 2009 09:56:00 +0200
User-Agent: KMail/1.11.2 (Linux/2.6.28-15-server; KDE/4.2.2; x86_64; ; )
Cc:	linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>
References: <200909032104.34135.florian@openwrt.org>
In-Reply-To: <200909032104.34135.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200910140956.00598.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24293
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Ralf,

Please find below an updated and hopefully cleaner patch. Thanks !
--
From: Florian Fainelli <florian@openwrt.org>
Subject: [PATCH]  bcm63xx: correctly set BCM6338 CPU name

For consistency with other BCM63xx SoC set the CPU name
to "Broadcom BCM6338" when actually running on that system.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/bcm63xx/cpu.c b/arch/mips/bcm63xx/cpu.c
index 6dc43f0..70378bb 100644
--- a/arch/mips/bcm63xx/cpu.c
+++ b/arch/mips/bcm63xx/cpu.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/cpu.h>
+#include <asm/cpu-info.h>
 #include <bcm63xx_cpu.h>
 #include <bcm63xx_regs.h>
 #include <bcm63xx_io.h>
@@ -284,6 +285,7 @@ void __init bcm63xx_cpu_init(void)
 {
 	unsigned int tmp, expected_cpu_id;
 	struct cpuinfo_mips *c = &current_cpu_data;
+	unsigned int cpu = smp_processor_id();
 
 	/* soc registers location depends on cpu type */
 	expected_cpu_id = 0;
@@ -293,6 +295,7 @@ void __init bcm63xx_cpu_init(void)
 	 * BCM6338 as the same PrId as BCM3302 see arch/mips/kernel/cpu-probe.c
 	 */
 	case CPU_BCM3302:
+		__cpu_name[cpu] = "Broadcom BCM6338";
 		expected_cpu_id = BCM6338_CPU_ID;
 		bcm63xx_regs_base = bcm96338_regs_base;
 		bcm63xx_irqs = bcm96338_irqs;
