Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Jul 2011 06:01:58 +0200 (CEST)
Received: from mail-pz0-f47.google.com ([209.85.210.47]:49411 "EHLO
        mail-pz0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490976Ab1GXEBy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 Jul 2011 06:01:54 +0200
Received: by pzk36 with SMTP id 36so6101814pzk.34
        for <multiple recipients>; Sat, 23 Jul 2011 21:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=3IGgMguiFwnTr7kzBbDLa0kVxop3W6eaMIUsl4nOTrI=;
        b=FmwJM7kXrdpKyEPlJNwG7ukinQOCH7I+pXq0gT/OYSJqtZgQ/2FJ06ktjerRUeyu+p
         vtja4ePvsuN0ltxoFDdruLqy6eDqSF4q+HPrW1emUnSMGJsUdxStIfMt/a5E79YU51F4
         fqU0KGFLm8WrMCpRuX+hZGY4IUFeRAQZhyVSE=
Received: by 10.143.93.4 with SMTP id v4mr2065110wfl.10.1311480107586;
        Sat, 23 Jul 2011 21:01:47 -0700 (PDT)
Received: from localhost.localdomain ([112.80.236.140])
        by mx.google.com with ESMTPS id e15sm2409389wfd.15.2011.07.23.21.01.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Jul 2011 21:01:46 -0700 (PDT)
From:   Wanlong Gao <wanlong.gao@gmail.com>
To:     ralf@linux-mips.org, blogic@openwrt.org
Cc:     linux-mips@linux-mips.org, wanlong.gao@gmail.com,
        Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: [PATCH] mips:lantiq:remove the dup include file
Date:   Sun, 24 Jul 2011 11:59:40 +0800
Message-Id: <1311479980-6756-1-git-send-email-gaowanlong@cn.fujitsu.com>
X-Mailer: git-send-email 1.7.4.1
X-archive-position: 30698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wanlong.gao@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17020

linux/leds.h
linux/reboot.h
had been included twice in devices.c

Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 arch/mips/lantiq/devices.c      |    2 --
 arch/mips/lantiq/xway/devices.c |    2 --
 2 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/mips/lantiq/devices.c b/arch/mips/lantiq/devices.c
index 7b82c34..44a3677 100644
--- a/arch/mips/lantiq/devices.c
+++ b/arch/mips/lantiq/devices.c
@@ -15,11 +15,9 @@
 #include <linux/platform_device.h>
 #include <linux/leds.h>
 #include <linux/etherdevice.h>
-#include <linux/reboot.h>
 #include <linux/time.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
-#include <linux/leds.h>
 
 #include <asm/bootinfo.h>
 #include <asm/irq.h>
diff --git a/arch/mips/lantiq/xway/devices.c b/arch/mips/lantiq/xway/devices.c
index e09e789..d0e32ab 100644
--- a/arch/mips/lantiq/xway/devices.c
+++ b/arch/mips/lantiq/xway/devices.c
@@ -16,11 +16,9 @@
 #include <linux/platform_device.h>
 #include <linux/leds.h>
 #include <linux/etherdevice.h>
-#include <linux/reboot.h>
 #include <linux/time.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
-#include <linux/leds.h>
 
 #include <asm/bootinfo.h>
 #include <asm/irq.h>
-- 
1.7.4.1
