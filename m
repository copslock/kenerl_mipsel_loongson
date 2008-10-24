Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 18:54:18 +0100 (BST)
Received: from yw-out-1718.google.com ([74.125.46.152]:45428 "EHLO
	yw-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S22309070AbYJXRyN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Oct 2008 18:54:13 +0100
Received: by yw-out-1718.google.com with SMTP id 9so345999ywk.24
        for <linux-mips@linux-mips.org>; Fri, 24 Oct 2008 10:54:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id:sender;
        bh=/TKtnDoZ0exXSMlOU58toncIMgjxNsFcGuEkBb9nnug=;
        b=RR8HjUAIbRjtPDuzZzzdTLcrMSuPlHRKjM4B41ELAYTdo5V+AKe7znJYkNJVqjjE7y
         hpbA9BE8HyWNLVMsG6FsZ2HuwXjbSX3FfXrgFYo1RTUyjYj5RWRwS6e2zE/h4HjvhZcH
         sorplXF0LLfyNVAQS5m9u0GrN396Znwzee4UY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:date:subject:mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id:sender;
        b=RA6yBURS/42xdjg3O1rrOOUWRBU6OOB/CurJPoXORNmP5jgrkyRdj0X6olTesOo3Ur
         abRuKgX2yIq3aM9RMaFHUTjXx3NThH7XWSnfI+tQ14Xgq7VZjdQZe0NKC/ccLJJM4qil
         44cXy9BKquZRcGLs9jSFkvk8vu8sK0JHln3is=
Received: by 10.181.229.7 with SMTP id g7mr1003668bkr.135.1224870848490;
        Fri, 24 Oct 2008 10:54:08 -0700 (PDT)
Received: from florian.headquarters.openpattern.org (headquarters.openpattern.org [82.240.17.188])
        by mx.google.com with ESMTPS id 3sm1004973fge.3.2008.10.24.10.54.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Oct 2008 10:54:07 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Fri, 24 Oct 2008 19:53:55 +0200
Subject: [PATCH] rb532: set gpio interrupt status and level for CompactFlash
MIME-Version: 1.0
X-UID:	6
X-Length: 1412
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Phil Sutter <n0-1@freewrt.org>,
	"linux-mips" <linux-mips@linux-mips.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200810241953.55841.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20949
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch sets the correct interrupt status and level
in order to get the CompactFlash adapter working.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/rb532/gpio.c b/arch/mips/rb532/gpio.c
index 76a7fd9..70c4a67 100644
--- a/arch/mips/rb532/gpio.c
+++ b/arch/mips/rb532/gpio.c
@@ -310,6 +310,10 @@ int __init rb532_gpio_init(void)
 		return -ENXIO;
 	}
 
+	/* Set the interrupt status and level for the CF pin */
+	rb532_gpio_set_int_level(&rb532_gpio_chip->chip, CF_GPIO_NUM, 1);
+	rb532_gpio_set_int_status(&rb532_gpio_chip->chip, CF_GPIO_NUM, 0);
+
 	return 0;
 }
 arch_initcall(rb532_gpio_init);
