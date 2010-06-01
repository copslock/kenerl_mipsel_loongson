Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jun 2010 22:30:58 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:44968 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491103Ab0FAUaz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Jun 2010 22:30:55 +0200
Received: by fxm15 with SMTP id 15so4160968fxm.36
        for <linux-mips@linux-mips.org>; Tue, 01 Jun 2010 13:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=knv9en/oxDlQuFd0kdlqQ/yERBv4s/HNYyuqmMn8O6E=;
        b=OU2QQhC3JCdXrcP51caUMMEgo50IiELTBNYmz0LHA/AGQXwi3MiWMHg11nD+GulzRB
         nxNdJhC4v8yRPvFI9irk2iSQ6YQZP2cAyQIUfVbNzfrFbfHUcyquw56WRHSiNIDg55Ho
         Z/tRWPZoKwhxMYt2tIBoIuoPz9qA/Ttn9C3io=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=oHbzxdyn/u2QbjgfW4Pk9BjLDOuoRFNgmPv037UBIkxGOlDLFD3DIE27J5tpnMIJOh
         cE8z51IdmYOSyqJNUIms2bEuIvUOFzBCiVfjdwBmb5JxjAkuHANGmRxybWijjkeSbSrl
         XTxIFJ4fhMOW8UMQSovjt66U5ft5GNk/tVH2E=
Received: by 10.223.51.152 with SMTP id d24mr7635654fag.36.1275424249610;
        Tue, 01 Jun 2010 13:30:49 -0700 (PDT)
Received: from localhost.localdomain (p5496C36D.dip.t-dialin.net [84.150.195.109])
        by mx.google.com with ESMTPS id 2sm48702233fav.13.2010.06.01.13.30.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 13:30:48 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH -queue 1/2] MIPS: Alchemy: move boards over to obj-y
Date:   Tue,  1 Jun 2010 22:30:36 +0200
Message-Id: <1275424237-8120-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.1
X-archive-position: 26975
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 702

Preparatory step for moving Alchemy over to new  MIPS Platform
build system support.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
The other boards no longer use libs, without any ill effects.
In the past the lib-y code would sometimes not be picked up and
cause link failures, so this also improves build reliability.

 arch/mips/Makefile                 |    4 ++--
 arch/mips/alchemy/mtx-1/Makefile   |    3 +--
 arch/mips/alchemy/xxs1500/Makefile |    2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 14b755d..8282152 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -290,13 +290,13 @@ load-$(CONFIG_MIPS_MIRAGE)	+= 0xffffffff80100000
 #
 # 4G-Systems eval board
 #
-libs-$(CONFIG_MIPS_MTX1)	+= arch/mips/alchemy/mtx-1/
+core-$(CONFIG_MIPS_MTX1)	+= arch/mips/alchemy/mtx-1/
 load-$(CONFIG_MIPS_MTX1)	+= 0xffffffff80100000
 
 #
 # MyCable eval board
 #
-libs-$(CONFIG_MIPS_XXS1500)	+= arch/mips/alchemy/xxs1500/
+core-$(CONFIG_MIPS_XXS1500)	+= arch/mips/alchemy/xxs1500/
 load-$(CONFIG_MIPS_XXS1500)	+= 0xffffffff80100000
 
 # must be last for Alchemy systems for GPIO to work properly
diff --git a/arch/mips/alchemy/mtx-1/Makefile b/arch/mips/alchemy/mtx-1/Makefile
index 4a53815..f912022 100644
--- a/arch/mips/alchemy/mtx-1/Makefile
+++ b/arch/mips/alchemy/mtx-1/Makefile
@@ -6,7 +6,6 @@
 # Makefile for 4G Systems MTX-1 board.
 #
 
-lib-y := init.o board_setup.o
-obj-y := platform.o
+obj-y += init.o board_setup.o platform.o
 
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/alchemy/xxs1500/Makefile b/arch/mips/alchemy/xxs1500/Makefile
index 4dc81d7..81c516e 100644
--- a/arch/mips/alchemy/xxs1500/Makefile
+++ b/arch/mips/alchemy/xxs1500/Makefile
@@ -5,6 +5,6 @@
 # Makefile for MyCable XXS1500 board.
 #
 
-lib-y := init.o board_setup.o platform.o
+obj-y += init.o board_setup.o platform.o
 
 EXTRA_CFLAGS += -Werror
-- 
1.7.1
