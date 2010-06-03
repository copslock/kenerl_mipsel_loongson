Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jun 2010 12:34:22 +0200 (CEST)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:33440 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491098Ab0FCKeS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Jun 2010 12:34:18 +0200
Received: by vws7 with SMTP id 7so9288568vws.36
        for <multiple recipients>; Thu, 03 Jun 2010 03:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:subject:cc
         :message-id:from:date;
        bh=R/0HBuAnOnK4RLMuB4Nf9q/9Mox+IklyuVS9HVyjwO4=;
        b=HrXKtlVmKPSwIWJSGI/8GkapRVVFhNzzsylzqV9wBfhJ6L9BlSzeogtEei5VsE3duv
         vosj60PWfz59ZWYQ21ErQv5qqdlKMUJuw2FVrJazTGqs3u2kamDwfIeXUNKACGAJ2mR0
         wlMVCaHIryJb3joRtNfcL+CNpjcsJlX96aNXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:subject:cc:message-id:from:date;
        b=jBNYn2ujh2mZswLGmCC3MVvei9SEUD+QM8pPsqYlC0FyN8hJq7chhrVTNOfHBEuugT
         vEAg4FcW9RDptylE+3RKYVevkddpj7+MkqglyFI/WmdPj4sQwCswIEvgn0FsiED09DIF
         IjTuq+ggRoj622fIYCcIvC04mNOQSWBhJJMLM=
Received: by 10.224.121.212 with SMTP id i20mr4359212qar.11.1275561250739;
        Thu, 03 Jun 2010 03:34:10 -0700 (PDT)
Received: from localhost ([207.47.250.203])
        by mx.google.com with ESMTPS id 7sm17603490qwb.14.2010.06.03.03.34.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Jun 2010 03:34:10 -0700 (PDT)
Received: from shane by localhost with local (Exim 4.69)
        (envelope-from <shane@localhost>)
        id 1OK7kU-0008RG-Oj; Thu, 03 Jun 2010 04:34:06 -0600
To:     linux-mips@linux-mips.org
Subject: MIPS -queue: Move PMC-Sierra board Makefile parts to their own Platform file
Cc:     ralf@linux-mips.org
Message-Id: <E1OK7kU-0008RG-Oj@localhost>
From:   Shane McDonald <mcdonald.shane@gmail.com>
Date:   Thu, 03 Jun 2010 04:34:06 -0600
X-archive-position: 27039
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2272

This patch moves the entries for the PMC-Sierra boards from the main
mips Makefile into their own Platform file.

Signed-off-by: Shane McDonald <mcdonald.shane@gmail.com>
---
This patch applies against the linux-queue tree.
It has been compile tested for both the MSP71xx and the yosemite
defconfigs, the yosemite one after disabling the broken Titan GE driver.

 arch/mips/Kbuild.platforms    |    1 +
 arch/mips/Makefile            |   15 ---------------
 arch/mips/pmc-sierra/Platform |   14 ++++++++++++++
 3 files changed, 15 insertions(+), 15 deletions(-)
 create mode 100644 arch/mips/pmc-sierra/Platform

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index 9b6e8d7..c074ee2 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -5,6 +5,7 @@ platforms += ar7
 platforms += cobalt
 platforms += loongson
 platforms += mipssim
+platforms += pmc-sierra
 platforms += sgi-ip27
 platforms += vr41xx
 
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 6997faa..a27c645 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -222,21 +222,6 @@ load-$(CONFIG_MIPS_MALTA)	+= 0xffffffff80100000
 all-$(CONFIG_MIPS_MALTA)	:= $(COMPRESSION_FNAME).bin
 
 #
-# PMC-Sierra MSP SOCs
-#
-core-$(CONFIG_PMC_MSP)		+= arch/mips/pmc-sierra/msp71xx/
-cflags-$(CONFIG_PMC_MSP)	+= -I$(srctree)/arch/mips/include/asm/pmc-sierra/msp71xx \
-					-mno-branch-likely
-load-$(CONFIG_PMC_MSP)		+= 0xffffffff80100000
-
-#
-# PMC-Sierra Yosemite
-#
-core-$(CONFIG_PMC_YOSEMITE)	+= arch/mips/pmc-sierra/yosemite/
-cflags-$(CONFIG_PMC_YOSEMITE)	+= -I$(srctree)/arch/mips/include/asm/mach-yosemite
-load-$(CONFIG_PMC_YOSEMITE)	+= 0xffffffff80100000
-
-#
 # LASAT platforms
 #
 core-$(CONFIG_LASAT)		+= arch/mips/lasat/
diff --git a/arch/mips/pmc-sierra/Platform b/arch/mips/pmc-sierra/Platform
new file mode 100644
index 0000000..f092f25
--- /dev/null
+++ b/arch/mips/pmc-sierra/Platform
@@ -0,0 +1,14 @@
+#
+# PMC-Sierra MSP SOCs
+#
+platform-$(CONFIG_PMC_MSP)	+= pmc-sierra/msp71xx/
+cflags-$(CONFIG_PMC_MSP)	+= -I$(srctree)/arch/mips/include/asm/pmc-sierra/msp71xx \
+					-mno-branch-likely
+load-$(CONFIG_PMC_MSP)		+= 0xffffffff80100000
+
+#
+# PMC-Sierra Yosemite
+#
+platform-$(CONFIG_PMC_YOSEMITE)	+= pmc-sierra/yosemite/
+cflags-$(CONFIG_PMC_YOSEMITE)	+= -I$(srctree)/arch/mips/include/asm/mach-yosemite
+load-$(CONFIG_PMC_YOSEMITE)	+= 0xffffffff80100000
-- 
1.5.6.5
