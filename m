Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 May 2009 19:30:05 +0100 (BST)
Received: from mail-ew0-f219.google.com ([209.85.219.219]:60958 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024262AbZEaS37 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 31 May 2009 19:29:59 +0100
Received: by ewy19 with SMTP id 19so7633818ewy.0
        for <multiple recipients>; Sun, 31 May 2009 11:29:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=JCKQNT/x2FxGjo2porH76N4f6vlIHAMTa5cVv84VaTE=;
        b=vihHYqJ+QZkCm5G5nx/iBI3my9rhA07W2KFkPLfTzOTikGxdSCy32NFt7PX8AxwdTq
         FOWxoAF6zkZjdYvwvlYNZxXKCHPvE1fmShIrZ3+fw4wtiFwnyrgNNcU/Hx8QALYNU3xm
         n5w3IgEhSwmcOBty5KPe0zf3W5gc3oun7+J9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=BVuujkd2Ucj4pq9rBj3179QiF7LuFI8Hjpvz2OrPr7eMepI5EQ8So9kbvMfnqlSFv5
         RrB0Pte0lrjxdg8ZnU3ioclcgT8r6mhDTT8D0z0QooepvixgUWtU0B9/VQ+1OjMSRV/X
         zs77frZPGXGDTCzFylrPSZvAvvcU4C4Dc0EyM=
Received: by 10.210.136.10 with SMTP id j10mr2553929ebd.21.1243794593548;
        Sun, 31 May 2009 11:29:53 -0700 (PDT)
Received: from ?192.168.1.20? (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 28sm6231442eyg.34.2009.05.31.11.29.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 May 2009 11:29:53 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Sun, 31 May 2009 20:29:49 +0200
Subject: [PATCH 07/10] bcm63xx: fix typo when printing CPU frequency
MIME-Version: 1.0
X-UID:	139
X-Length: 1483
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Maxime Bizon <mbizon@freebox.fr>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200905312029.50326.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch corrects the comment about the CPU
frequency which is actually printed in Hz and not MHz.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/bcm63xx/cpu.c b/arch/mips/bcm63xx/cpu.c
index 0a403dd..410c788 100644
--- a/arch/mips/bcm63xx/cpu.c
+++ b/arch/mips/bcm63xx/cpu.c
@@ -238,7 +238,7 @@ void __init bcm63xx_cpu_init(void)
 
 	printk(KERN_INFO "Detected Broadcom 0x%04x CPU revision %02x\n",
 	       bcm63xx_cpu_id, bcm63xx_cpu_rev);
-	printk(KERN_INFO "CPU frequency is %u MHz\n",
+	printk(KERN_INFO "CPU frequency is %u Hz\n",
 	       bcm63xx_cpu_freq);
 	printk(KERN_INFO "%uMB of RAM installed\n",
 	       bcm63xx_memory_size >> 20);
