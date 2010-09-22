Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Sep 2010 08:04:17 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:58204 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490968Ab0IVGEO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Sep 2010 08:04:14 +0200
Received: by pvg12 with SMTP id 12so57161pvg.36
        for <multiple recipients>; Tue, 21 Sep 2010 23:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=cRwt6c7y6APDIaP7pj6J+GmScdBcYfoTipyQQktwMBI=;
        b=XmwHlkqeFUppigM89VyXab2Q9x0lTDQXlX4ulILmizWZZTvTkAYtMqUJvCKfgk/Nfi
         +s2I3UnaJ+3hLcxP4GGgU9XD7QQ6Z/SKxEt4vEyOdYaS7JgUbE1Lo1RYqUNOvjZEAdhv
         yXwdzoAR1/ABYKx9Y/+1uDLa5knMyXlOR10iI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Odf9SB1hJOKSdj2yWJHufvvaeu8YNWZfufqSAjOmpVuzAuUmCWL8k/vSTOxY1xguqI
         iHAF/VUPbpN37fz5NqxPigj3MubByKyta9nVLyYkgujv13WfMhHmFPPxzHuqBEhcpIMQ
         RUQuL5SdOEI2y3YzrizupP8DW4KqT4IKiBHCw=
Received: by 10.142.251.3 with SMTP id y3mr10090375wfh.140.1285135448127;
        Tue, 21 Sep 2010 23:04:08 -0700 (PDT)
Received: from localhost.localdomain ([61.48.59.181])
        by mx.google.com with ESMTPS id y36sm9216160wfd.18.2010.09.21.23.04.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Sep 2010 23:04:06 -0700 (PDT)
From:   wuzhangjin@gmail.com
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] MIPS: Fixes "make clean"
Date:   Wed, 22 Sep 2010 14:03:57 +0800
Message-Id: <1285135437-15783-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.1
X-archive-position: 27786
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16943

From: Wu Zhangjin <wuzhangjin@gmail.com>

When we do "make clean", vmlinuz will not be cleaned, we need to use
vmlinuz* instead of vmlinuz.* to include it.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/boot/compressed/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index ed9bb70..5c1eb68 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -105,4 +105,4 @@ OBJCOPYFLAGS_vmlinuz.srec := $(OBJCOPYFLAGS) -S -O srec
 vmlinuz.srec: vmlinuz
 	$(call cmd,objcopy)
 
-clean-files := $(objtree)/vmlinuz.*
+clean-files := $(objtree)/vmlinuz*
-- 
1.7.1
