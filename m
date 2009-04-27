Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Apr 2009 15:47:40 +0100 (BST)
Received: from mail-ew0-f174.google.com ([209.85.219.174]:49216 "EHLO
	mail-ew0-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023680AbZD0Ore (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 27 Apr 2009 15:47:34 +0100
Received: by ewy22 with SMTP id 22so2202803ewy.0
        for <multiple recipients>; Mon, 27 Apr 2009 07:47:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=QcVgxmyiYYY5puOVFgS21hQMRrzlusI6470KCpz+wEI=;
        b=Q6RxwWl0UnAxdBZK5Bk5g+IoCJiWFVfZAfLOgn0EV3IUMaaHhvzg6GRuNCqpQUDXpm
         g6PXqliIT0DopPda5M2vCPF8Sf7c6+98phz9SID2RaL9fJd8Um+YKVvyZv3gsI2P5qYp
         1CyrLrtafN4NcjzfGRVpGyDFf3lbSjCYxNGoE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=MJG9tUO6Drl6Oz6sxe0fHvKMd+k2rg4VSs9KtcQilnHL8R2FuAeAlYvTwoxQvLqnNf
         CIxK1AElMK45QVEEGCSSL+pKzvb7X5bC3mENuGoBoMAvsl+mvJqp8PnycIsvXH5F4vkZ
         h0nRvu+QqGMc7jejPpU4Fk0f4pfOEDrnfxHo4=
Received: by 10.211.180.15 with SMTP id h15mr1605593ebp.90.1240843648208;
        Mon, 27 Apr 2009 07:47:28 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 5sm2067994eyf.14.2009.04.27.07.47.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Apr 2009 07:47:27 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Mon, 27 Apr 2009 16:47:23 +0200
Subject: [PATCH] define MIPS34K_MISSED_ITLB_WAR for other PMC-Sierra SoC
MIME-Version: 1.0
X-UID:	60
X-Length: 1672
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200904271647.24450.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22492
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Trying to build a PMC-Sierra MSP4200 VoIP gateway defconfig
will not work since MIPS34K_MISSED_ITLB_WAR is not defined
for all boards supported within pmc-serria/msp71xx. This
patch defines MIPS34K_MISSED_ITLB_WAR to prevent such build
failures:

  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  SYMLINK include/asm -> include/asm-mips
  CC      arch/mips/kernel/asm-offsets.s
In file included fromlinux-msp71xx/linux-2.6.29/arch/mips/include/asm/bitops.h:24,
                 from include/linux/bitops.h:17,
                 from include/linux/kernel.h:15,
                 from include/linux/sched.h:52,
                 from arch/mips/kernel/asm-offsets.c:13:
linux-msp71xx/linux-2.6.29/arch/mips/include/asm/war.h:241:2: error: #error Check setting of MIPS34K_MISSED_ITLB_WAR for your 
platform

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/include/asm/pmc-sierra/msp71xx/war.h b/arch/mips/include/asm/pmc-sierra/msp71xx/war.h
index 0bf48fc..9e2ee42 100644
--- a/arch/mips/include/asm/pmc-sierra/msp71xx/war.h
+++ b/arch/mips/include/asm/pmc-sierra/msp71xx/war.h
@@ -23,6 +23,8 @@
 #if defined(CONFIG_PMC_MSP7120_EVAL) || defined(CONFIG_PMC_MSP7120_GW) || \
 	defined(CONFIG_PMC_MSP7120_FPGA)
 #define MIPS34K_MISSED_ITLB_WAR         1
+#else
+#define MIPS34K_MISSED_ITLB_WAR         0
 #endif
 
 #endif /* __ASM_MIPS_PMC_SIERRA_WAR_H */
