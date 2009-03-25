Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Mar 2009 16:54:20 +0000 (GMT)
Received: from mail-fx0-f175.google.com ([209.85.220.175]:9453 "EHLO
	mail-fx0-f175.google.com") by ftp.linux-mips.org with ESMTP
	id S28575334AbZCYQtq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Mar 2009 16:49:46 +0000
Received: by mail-fx0-f175.google.com with SMTP id 23so148346fxm.0
        for <linux-mips@linux-mips.org>; Wed, 25 Mar 2009 09:49:46 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=MEGxdaAXtPn5UfCqtH7ucaL9dy917cqENjtnchxelTU=;
        b=Za+ukQWPnA72QmXQfAJr/CfWOpImcCGLp03Ba6lmxO/7nXJx3XBcVri7vr4IcAb0Nj
         UA8aS7tqA8uFFsEnruXNUJval8KsdfcuosXK6R1u9VQXdpaCZcZc5pqZDrl6wD8SdWt9
         CYsaIx7j0701s7YwCiT+orIm+qZsIXGYtaK/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=c4vrFAsukKBrYksBUxamctHnMiFgeJmKltus2OPL0lrwwl8J+ihfLUl3z0wxWnuOR7
         LLKGRiRLJ45cuwd10tSfxR3exOvjYdwpnDAR+V9a5Cqsg6vSUn2nqAkmQKJu+HnwJz2Y
         al+06+/Onjc0wNqM8P2I6yXGu9PE35yFXeSv0=
Received: by 10.103.212.2 with SMTP id o2mr4280602muq.69.1237999777274;
        Wed, 25 Mar 2009 09:49:37 -0700 (PDT)
Received: from localhost.localdomain (p5496CCD7.dip.t-dialin.net [84.150.204.215])
        by mx.google.com with ESMTPS id e10sm14966093muf.41.2009.03.25.09.49.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Mar 2009 09:49:36 -0700 (PDT)
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 5/6] Alchemy: don't unconditionally register all alchemy platform devices
Date:	Wed, 25 Mar 2009 17:49:32 +0100
Message-Id: <1237999773-5174-6-git-send-email-mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.2
In-Reply-To: <1237999773-5174-5-git-send-email-mano@roarinelk.homelinux.net>
References: <1237999773-5174-1-git-send-email-mano@roarinelk.homelinux.net>
 <1237999773-5174-2-git-send-email-mano@roarinelk.homelinux.net>
 <1237999773-5174-3-git-send-email-mano@roarinelk.homelinux.net>
 <1237999773-5174-4-git-send-email-mano@roarinelk.homelinux.net>
 <1237999773-5174-5-git-send-email-mano@roarinelk.homelinux.net>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Not every board may want to register all available alchemy drivers;
besides it makes passing platform_data ugly since the device registration
and its platform data are in separate files.  I don't like that.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/alchemy/common/Makefile    |    2 +-
 arch/mips/alchemy/devboards/Makefile |    2 +-
 arch/mips/alchemy/mtx-1/Makefile     |    2 +-
 arch/mips/alchemy/xxs1500/Makefile   |    1 +
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/alchemy/common/Makefile b/arch/mips/alchemy/common/Makefile
index d50d476..941229f 100644
--- a/arch/mips/alchemy/common/Makefile
+++ b/arch/mips/alchemy/common/Makefile
@@ -6,7 +6,7 @@
 #
 
 obj-y += prom.o irq.o puts.o time.o reset.o \
-	clocks.o platform.o power.o setup.o \
+	clocks.o power.o setup.o \
 	sleeper.o dma.o dbdma.o gpio.o
 
 obj-$(CONFIG_PCI)		+= pci.o
diff --git a/arch/mips/alchemy/devboards/Makefile b/arch/mips/alchemy/devboards/Makefile
index 730f9f2..7b36ba4 100644
--- a/arch/mips/alchemy/devboards/Makefile
+++ b/arch/mips/alchemy/devboards/Makefile
@@ -2,7 +2,7 @@
 # Alchemy Develboards
 #
 
-obj-y += prom.o
+obj-y += prom.o ../common/platform.o
 obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_MIPS_PB1000)	+= pb1000/
 obj-$(CONFIG_MIPS_PB1100)	+= pb1100/
diff --git a/arch/mips/alchemy/mtx-1/Makefile b/arch/mips/alchemy/mtx-1/Makefile
index 7c67b3d..ef98975 100644
--- a/arch/mips/alchemy/mtx-1/Makefile
+++ b/arch/mips/alchemy/mtx-1/Makefile
@@ -7,6 +7,6 @@
 #
 
 lib-y := init.o board_setup.o irqmap.o
-obj-y := platform.o
+obj-y := platform.o ../common/platform.o
 
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/alchemy/xxs1500/Makefile b/arch/mips/alchemy/xxs1500/Makefile
index db3c526..619a76c 100644
--- a/arch/mips/alchemy/xxs1500/Makefile
+++ b/arch/mips/alchemy/xxs1500/Makefile
@@ -6,3 +6,4 @@
 #
 
 lib-y := init.o board_setup.o irqmap.o
+obj-y += ../common/platform.o
-- 
1.6.2
