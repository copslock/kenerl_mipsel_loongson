Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Jan 2010 13:22:15 +0100 (CET)
Received: from mail-pz0-f203.google.com ([209.85.222.203]:40072 "EHLO
        mail-pz0-f203.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491062Ab0AaMWM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 31 Jan 2010 13:22:12 +0100
Received: by pzk41 with SMTP id 41so5404351pzk.0
        for <multiple recipients>; Sun, 31 Jan 2010 04:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=rlFE9ZkjWfMowIo0J3O8yuramctF7lXhiiLon/rKanY=;
        b=PQ/5s2YgoJTXaOVUe+k6IhDDILyaOVQ+AsqlUCTQwR9/Nnvu6va0jdjPYo2U8EyOwx
         lHeCm58QjanR3ljbb0afWpgSfrsX1X/Efgfg/hipM3b+yllXNxXai3cnFIOjGbbx1JGx
         UBMRRTZtnL4I2EWQSkcfEZCdpITWpVesB34Hw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=pB5WBbY2T6+u3uxnwe5Zg5wNdzkhmwoZS7i5dmFHC1eFakiXgStUUZc0ACjNDbmsl1
         2C3upCLbT20bhdx3SY6qfgn0g+ecvrXYBdD6QCmAWBy56Y5jtMYdfQDgWdxT5xUYKkTG
         OsPGu8sLAjz1o1vAB0EXdRlmHDA3BTIkX3iZM=
Received: by 10.141.90.1 with SMTP id s1mr2258433rvl.42.1264940524205;
        Sun, 31 Jan 2010 04:22:04 -0800 (PST)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 21sm3552209pzk.3.2010.01.31.04.21.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 Jan 2010 04:22:01 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
        linux-mips@linux-mips.org, zhangfx@lemote.com
Subject: [PATCH v11 0/9] *** SUBJECT HERE ***
Date:   Sun, 31 Jan 2010 20:15:46 +0800
Message-Id: <cover.1264940063.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.6
X-archive-position: 25777
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19716

From: Wu Zhangjin <wuzhangjin@gmail.com>

*** BLURB HERE ***

Wu Zhangjin (9):
  MIPS: add subdirectory for platform extension drivers
  Loongson: YeeLoong: add platform driver
  Loongson: YeeLoong: add backlight driver
  Loongson: YeeLoong: add hardware monitoring driver
  Loongson: YeeLoong: add video output driver
  Loongson: YeeLoong: add suspend support
  Loongson: YeeLoong: add input/hotkey driver
  Loongson: YeeLoong: Co-operate with the revisions of EC
  Loongson: YeeLoong: add power_supply based battery driver

 arch/mips/include/asm/mach-loongson/ec_kb3310b.h |  188 ++++
 arch/mips/include/asm/mach-loongson/loongson.h   |    6 +
 arch/mips/loongson/common/cmdline.c              |    8 +
 arch/mips/loongson/lemote-2f/Makefile            |    2 +-
 arch/mips/loongson/lemote-2f/ec_kb3310b.c        |   12 +-
 arch/mips/loongson/lemote-2f/ec_kb3310b.h        |  188 ----
 arch/mips/loongson/lemote-2f/platform.c          |   39 +
 arch/mips/loongson/lemote-2f/pm.c                |    4 +-
 arch/mips/loongson/lemote-2f/reset.c             |    2 +-
 drivers/platform/Kconfig                         |    4 +
 drivers/platform/Makefile                        |    1 +
 drivers/platform/mips/Kconfig                    |   32 +
 drivers/platform/mips/Makefile                   |    5 +
 drivers/platform/mips/yeeloong_laptop.c          | 1192 ++++++++++++++++++++++
 14 files changed, 1483 insertions(+), 200 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson/ec_kb3310b.h
 delete mode 100644 arch/mips/loongson/lemote-2f/ec_kb3310b.h
 create mode 100644 arch/mips/loongson/lemote-2f/platform.c
 create mode 100644 drivers/platform/mips/Kconfig
 create mode 100644 drivers/platform/mips/Makefile
 create mode 100644 drivers/platform/mips/yeeloong_laptop.c
