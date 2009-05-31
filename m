Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 May 2009 19:28:47 +0100 (BST)
Received: from ey-out-1920.google.com ([74.125.78.144]:22444 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024228AbZEaS2k (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 31 May 2009 19:28:40 +0100
Received: by ey-out-1920.google.com with SMTP id 4so303188eyg.54
        for <multiple recipients>; Sun, 31 May 2009 11:28:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=p90N67p4YOCdYnQzOV6oB5/Ryg4mhUoMJXAZXKIfv9U=;
        b=mgn07caOXE3j0t25LmXSv8Qyjqcbzd1XiAPawHaumz+yjEUcU6L2oaoWMCvRPowlLp
         L9XDZu40+VPiCZYhn1EOQIokrc21C1iT13YjUvVN8JjLT6YIrBB9DAlINSvjzqQ/oq7X
         IyGHaHtMDehw3NVHz0tbLfE4gV6cdvZMNIsls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=NukLyb4MxrjM762U4jHrz0blPiE4lLtOi0ii5myPY0nrPoBzZaUpO2eohwSM0zOQpA
         IDHOejsyOS+6uVggK3fWN/LnwtAYupPLrNyarjurDRu/xqWomUG+sbe50ng3JDT9WUdk
         Z/zJ9U+Yn3+j+gXxcTh6tG8TILmQYfQCWmOsE=
Received: by 10.210.33.15 with SMTP id g15mr3017913ebg.42.1243794520068;
        Sun, 31 May 2009 11:28:40 -0700 (PDT)
Received: from ?192.168.1.20? (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 28sm6232383eyg.24.2009.05.31.11.28.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 May 2009 11:28:39 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Sun, 31 May 2009 20:28:37 +0200
Subject: [PATCH 05/10] bcm63xx: dev-enet: initialize shared_device_registered to 0
MIME-Version: 1.0
X-UID:	137
X-Length: 1466
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Maxime Bizon <mbizon@freebox.fr>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200905312028.37498.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch initialize the shared_device_registered
variable with 0, actually required for the check
to be working.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/bcm63xx/dev-enet.c b/arch/mips/bcm63xx/dev-enet.c
index 51c2e5a..0298973 100644
--- a/arch/mips/bcm63xx/dev-enet.c
+++ b/arch/mips/bcm63xx/dev-enet.c
@@ -28,7 +28,7 @@ static struct platform_device bcm63xx_enet_shared_device = {
 	.resource	= shared_res,
 };
 
-static int shared_device_registered;
+static int shared_device_registered = 0;
 
 static struct resource enet0_res[] = {
 	{
