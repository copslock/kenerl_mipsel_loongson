Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Sep 2009 21:04:56 +0200 (CEST)
Received: from mail-bw0-f208.google.com ([209.85.218.208]:57925 "EHLO
	mail-bw0-f208.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493126AbZICTEu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 3 Sep 2009 21:04:50 +0200
Received: by bwz4 with SMTP id 4so185267bwz.0
        for <multiple recipients>; Thu, 03 Sep 2009 12:04:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ouPSqi+5PIrY53pETgu0BzDvs+nVf+xfdVnxyNesVeM=;
        b=PfQz3cnNQhrgSjI4MJITOJRti4BPlvG9XpY1OznbF5w/V4OlA2cchsYzx1DAuRY+18
         PZwvYl1QGRrrQnajjiWCg/+xZwc9Bdny6ki31XseYo4MSxDTXAxX+3thXOZ/56jD9evW
         RrF5dL+3USkh5KXpYNFKEJ7QPkfQMtnYNJZgY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=nI/Xk4vsvC79a2kVYcn1Rp2XLrfruCvsytEiuQNwK4v1dlSdFsmeSl8NqHZ6JLNLZe
         zAFOQaAVl4Bo7utjV9unoOgL853IFMUQxGlB4XtlDvgWWDCwprmIUDPtiuCbjq3SWAdZ
         zol3R4vupAL/GQI5pGt1kFWwbnfarCsGFZSo4=
Received: by 10.103.76.37 with SMTP id d37mr4405030mul.99.1252004684436;
        Thu, 03 Sep 2009 12:04:44 -0700 (PDT)
Received: from lenovo.localnet (39.87.196-77.rev.gaoland.net [77.196.87.39])
        by mx.google.com with ESMTPS id u26sm159704mug.53.2009.09.03.12.04.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Sep 2009 12:04:43 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Thu, 3 Sep 2009 21:04:32 +0200
Subject: [PATCH] bcm63xx: set the correct BCM3302 CPU name when built for BCM47xx or BCM63xx
MIME-Version: 1.0
X-UID:	1374
X-Length: 1694
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200909032104.34135.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

The Broadcom BCM3302 core is present in both the BCM47xx and
the BCM6338 SoC. If people want to report a kernel oops it
might be convenient to know about the real system they are
running Linux on at first glance.
Set the CPU name to be 3302 on BCM47xx and 6338 on BCM63xx.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 251a268..405e9d4 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -862,7 +862,11 @@ static inline void cpu_probe_broadcom(struct cpuinfo_mips *c, unsigned int cpu)
 	case PRID_IMP_BCM3302:
 	 /* same as PRID_IMP_BCM6338 */
 		c->cputype = CPU_BCM3302;
+#ifdef CONFIG_BCM47XX
 		__cpu_name[cpu] = "Broadcom BCM3302";
+#else 
+		__cpu_name[cpu] = "Broadcom BCM6338";
+#endif
 		break;
 	case PRID_IMP_BCM4710:
 		c->cputype = CPU_BCM4710;
