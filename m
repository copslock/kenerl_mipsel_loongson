Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 19:17:20 +0100 (WEST)
Received: from mail-ew0-f219.google.com ([209.85.219.219]:54294 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024926AbZFASRO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 1 Jun 2009 19:17:14 +0100
Received: by ewy19 with SMTP id 19so8328102ewy.0
        for <multiple recipients>; Mon, 01 Jun 2009 11:17:08 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ID63Bxg0Yk7e/DX285HpTAImN6lYsUpQP4kfALEv6Fo=;
        b=R9fDWKIW18dBZ+Tr6OSWfBb4fymF/JEYShXqRBBaLGEWD13ERFec5rAhWeVBY5fcst
         HLOE8y+q+SgSUpMSqFJ5VE5mGZTHghcMar4mNn6Yq5FKbPpnewLtJ61u311CTn3K78a0
         e1Am9zyMOsVO3KGthYISynRO+aQoAHMLhqK0I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=VArJ6dkEOYRMWKCU817kS0RmkI4uaOdzQkZGCM+1Ng6Br0Y5WuLmsaKf5cD1gcPD0F
         3OPkp4B3SwfR728SWDlUYPLtSZqWb3WFpJQ9VTMidqmPb0AYWAKK6lYNboA5ol/25Wld
         Z2szZ2VQa3EgwMPNqi6Czfr+7Bfm+2ly7YZMg=
Received: by 10.210.81.10 with SMTP id e10mr4400190ebb.39.1243880228580;
        Mon, 01 Jun 2009 11:17:08 -0700 (PDT)
Received: from florian (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 23sm384728eya.29.2009.06.01.11.17.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Jun 2009 11:17:07 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Mon, 1 Jun 2009 20:17:04 +0200
Subject: [PATCH 1/3] bcm63xx: fix printed CPU frequency
MIME-Version: 1.0
X-UID:	193
X-Length: 1411
To:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Maxime Bizon <mbizon@freebox.fr>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200906012017.05008.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23152
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch fixes the CPU frequency printing which is
printed in Hz and not MHz.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/bcm63xx/cpu.c b/arch/mips/bcm63xx/cpu.c
index 0a403dd..9d6cfce 100644
--- a/arch/mips/bcm63xx/cpu.c
+++ b/arch/mips/bcm63xx/cpu.c
@@ -239,7 +239,7 @@ void __init bcm63xx_cpu_init(void)
 	printk(KERN_INFO "Detected Broadcom 0x%04x CPU revision %02x\n",
 	       bcm63xx_cpu_id, bcm63xx_cpu_rev);
 	printk(KERN_INFO "CPU frequency is %u MHz\n",
-	       bcm63xx_cpu_freq);
+	       bcm63xx_cpu_freq / 1000000);
 	printk(KERN_INFO "%uMB of RAM installed\n",
 	       bcm63xx_memory_size >> 20);
 }
