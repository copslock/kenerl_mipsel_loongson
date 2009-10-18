Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Oct 2009 16:04:53 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:36011 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492670AbZJROEq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 18 Oct 2009 16:04:46 +0200
Received: by ewy12 with SMTP id 12so3399056ewy.0
        for <multiple recipients>; Sun, 18 Oct 2009 07:04:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:reply-to:content-type
         :content-transfer-encoding:message-id;
        bh=dJsmM3KmfGV2KYw0EhFroLeE6tfi0ybG/wHuAPtRDIk=;
        b=sQjtq+4uaSce7iIay3k24RkAGquUiw3yMyd7ElBnP0bn3rdd5sNAWQYWCPtPovSbbw
         yLLbo2+rc3E1fexeJ5odxviEWqVrJuVIlPYzZoOPelGyiNdbgU+zTzreMefdANbkdYW6
         icvYUVA0pVMJvzzJQDkgQjQXzNxkOr5HjNv+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc:reply-to
         :content-type:content-transfer-encoding:message-id;
        b=BhmgmRO+bjOwzKukfCP/hgTCwuPVqyRlzuyWl3v4+fpH8PSVuQmK0B05m9+kpo8DH5
         NzppfsVBkx42VRzR78cyY7GaBehgNd1i8QN7YCIgNeLH4faeEmgdvBxhh0wsDgF6suWq
         yk++v6HYzsRw8UgcoU5tKpa7vNYmXT3FmM8Tw=
Received: by 10.211.159.13 with SMTP id l13mr4166703ebo.82.1255874678491;
        Sun, 18 Oct 2009 07:04:38 -0700 (PDT)
Received: from lenovo.localnet (147.59.76-86.rev.gaoland.net [86.76.59.147])
        by mx.google.com with ESMTPS id 10sm7003240eyz.11.2009.10.18.07.04.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 18 Oct 2009 07:04:37 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Sun, 18 Oct 2009 16:04:41 +0200
Subject: [PATCH 2/2] alchemy: turn on -Werror for devboards and xss1500
MIME-Version: 1.0
X-UID:	1452
X-Length: 1739
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org,
	Manuel Lauss <manuel.lauss@googlemail.com>
Reply-To: Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200910181604.42580.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24376
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Warnings being suppressed, we can now turn on -Werror
for boards which did not have it already (devboards and
xss1500).

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/alchemy/devboards/Makefile b/arch/mips/alchemy/devboards/Makefile
index cfda972..c74ef80 100644
--- a/arch/mips/alchemy/devboards/Makefile
+++ b/arch/mips/alchemy/devboards/Makefile
@@ -16,3 +16,5 @@ obj-$(CONFIG_MIPS_DB1500)	+= db1x00/
 obj-$(CONFIG_MIPS_DB1550)	+= db1x00/
 obj-$(CONFIG_MIPS_BOSPORUS)	+= db1x00/
 obj-$(CONFIG_MIPS_MIRAGE)	+= db1x00/
+
+EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/alchemy/xxs1500/Makefile b/arch/mips/alchemy/xxs1500/Makefile
index 68671c2..4dc81d7 100644
--- a/arch/mips/alchemy/xxs1500/Makefile
+++ b/arch/mips/alchemy/xxs1500/Makefile
@@ -6,3 +6,5 @@
 #
 
 lib-y := init.o board_setup.o platform.o
+
+EXTRA_CFLAGS += -Werror
