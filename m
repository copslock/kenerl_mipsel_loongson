Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 May 2009 19:29:22 +0100 (BST)
Received: from mail-ew0-f219.google.com ([209.85.219.219]:48266 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024262AbZEaS3P (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 31 May 2009 19:29:15 +0100
Received: by ewy19 with SMTP id 19so7633531ewy.0
        for <multiple recipients>; Sun, 31 May 2009 11:29:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=+XOlKViooCPEGHPF7YcCqfC1yg7b8RkfHyj7p7ljN4U=;
        b=lotqFJTreYlYR3pkht6s3aFbDGuKDUm4j6jvvDZvUmJf437Mqd9vhYEG7I6h5GEZhG
         Um/BB1hhVWXEPRvze8ru2u8hn4lf3Y2RN374BYQ5SgLxFWMG40SaeeuA0GFuA8byWmmq
         HsqKaK71trVC4Q0OmwthGw6SRzcIKwXBOEiaY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=m8iiK03Wf46nS7mgIcfaCAw5WziLxViu2DS1NNnyei4mOQfWm7ghU7ff1PLXj5hSNm
         o+oaxvZxtJBxNI5RBeyiQeCE9yT2gZOL2+TRopMBJf9Kw4tWznb8K+duFP8WlPAHUFHb
         vhpGkgkDl9ST1rrfNqn3LFLES4aZzN/1ssm/s=
Received: by 10.210.19.7 with SMTP id 7mr870335ebs.57.1243794550173;
        Sun, 31 May 2009 11:29:10 -0700 (PDT)
Received: from ?192.168.1.20? (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 5sm5473347eyh.20.2009.05.31.11.29.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 May 2009 11:29:09 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Sun, 31 May 2009 20:29:07 +0200
Subject: [PATCH 06/10] bcm63xx: zero initialize mac_addr_used.
MIME-Version: 1.0
X-UID:	138
X-Length: 1431
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Maxime Bizon <mbizon@freebox.fr>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200905312029.07558.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch initializes mac_addr_used to zero, the checks
against it later would not work properly.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index 78a40e7..298804a 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -32,7 +32,7 @@
 #define PFX	"board_bcm963xx: "
 
 static struct bcm963xx_nvram nvram;
-static unsigned int mac_addr_used;
+static unsigned int mac_addr_used = 0;
 static struct board_info board;
 
 /*
