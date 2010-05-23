Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 May 2010 15:58:28 +0200 (CEST)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:43723 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491859Ab0EWN6Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 May 2010 15:58:24 +0200
Received: by pzk35 with SMTP id 35so1140918pzk.0
        for <multiple recipients>; Sun, 23 May 2010 06:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=xQ2tYvkLWgBAy/hQ0BaqgGgT6u1sB1mV/WQtfiG2S4A=;
        b=NR71q0es5JB5FekrUeOSow/RBpiUoWu1ef/BApHjjwbOS3R4ADOYVWTe71tmfIkGP5
         sMpWn0n0KGkfeWsXM+wkfdD692e3NwS4AipTBsPP1PO6yYyG9BRgcLa6Jw3cepiiPoqH
         a0noQVQmr1x5AnrrvWFUxiuYHqFyk7vZXHqe8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=neTuTrt99uQAgXS9YDRzKn00mtrI5aegj12Gh2/v0nX8CBkFRUq5AN00w8w1cYKywd
         wZ1IyH8/+SvoSxWrPVwqiFSOFu7cFFTXe2Qt3CKt6ifpo+8aYxysK+z4msZ6OEGumyTt
         3Dt438VDypFyHF+9IwFYKbEP2VrJ1jxo1nJsA=
Received: by 10.114.33.26 with SMTP id g26mr3648602wag.216.1274623096548;
        Sun, 23 May 2010 06:58:16 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id r20sm29067398wam.17.2010.05.23.06.58.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 May 2010 06:58:14 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v12 0/9] Loongson: YeeLoong: add platform specific driver
Date:   Sun, 23 May 2010 21:57:56 +0800
Message-Id: <cover.1274622624.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26797
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This patchset adds the platform specific driver for the YeeLoong netbook made
by Lemote.

Changes from v11:
  o Fixup of the brightness driver (from Zhou Yajin)
    use the right arguments for the backlight_device_register()

Wu Zhangjin (9):
  MIPS: add subdirectory for platform extension drivers
  Loongson: YeeLoong: add platform driver
  Loongson: YeeLoong: add backlight driver
  Loongson: YeeLoong: add hardware monitoring driver
  Loongson: YeeLoong: add video output driver
  Loongson: YeeLoong: add suspend support
  Loongson: YeeLoong: add input/hotkey driver
  Loongson: YeeLoong: add power_supply based battery driver
  Loongson: YeeLoong: Co-operate with the revisions of EC

 arch/mips/include/asm/mach-loongson/ec_kb3310b.h |  190 ++++
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
 drivers/platform/mips/yeeloong_laptop.c          | 1200 ++++++++++++++++++++++
 14 files changed, 1493 insertions(+), 200 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson/ec_kb3310b.h
 delete mode 100644 arch/mips/loongson/lemote-2f/ec_kb3310b.h
 create mode 100644 arch/mips/loongson/lemote-2f/platform.c
 create mode 100644 drivers/platform/mips/Kconfig
 create mode 100644 drivers/platform/mips/Makefile
 create mode 100644 drivers/platform/mips/yeeloong_laptop.c
