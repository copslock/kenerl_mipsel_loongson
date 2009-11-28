Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Nov 2009 14:31:54 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:54357 "EHLO
        mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492813AbZK1Nbv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Nov 2009 14:31:51 +0100
Received: by pwi15 with SMTP id 15so1449435pwi.24
        for <multiple recipients>; Sat, 28 Nov 2009 05:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=z6CLvXFzsSkEgY0BrZhLj+q7AG8z2HWH168SAJgqGxc=;
        b=dxqtzDTy16i0OE/sWV2HdG/2+FufICWe860hPRvc9wYjUwq4ip8T3rsQppq0gQDsjr
         AOqUOkvIqvh1j/I4AnuVkS+bq85KYL+MhJaftjpo5FtnUsI9DLgdkmXbfjyyL0/bk0Xl
         4JEaEygPI1bG21tWjQJ7bZhmiq/cLPsB7qcCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=uNWB6anoW00gA/cmZNvpKJne8gKX1Guj1kH0QteRpyDZQKzfzGPpNXMik/oYmuTo/5
         3zWdegyRXk8hl7JPHns9zk6liwSNkmZZdYuOt+WVDFxqaKIDu2cviU1bz2dlfBm3N6no
         /VIluUNI4xEhhoEmaZ7s6EzKUbJ/BtQHZdNYw=
Received: by 10.114.248.7 with SMTP id v7mr3900001wah.92.1259415104838;
        Sat, 28 Nov 2009 05:31:44 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm1948246pzk.14.2009.11.28.05.31.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Nov 2009 05:31:44 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-mips@linux-mips.org, zhangfx@lemote.com, yanh@lemote.com,
        huhb@lemote.com, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v5 0/8] Loongson: YeeLoong: add platform specific drivers
Date:   Sat, 28 Nov 2009 21:31:29 +0800
Message-Id: <cover.1259414649.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25183
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patchset adds platform specific drivers for YeeLoong.

Changes from the v4 revision:
	
	- Split the drivers into its own module
	- Incorporates with the feedback of the Input(hotkey) driver from
	Dmitry Torokhov.
	- Cleanups and fixups

Wu Zhangjin (8):
  Loongson: Lemote-2F: add platform specific submenu
  Loongson: YeeLoong: add platform specific option
  Loongson: YeeLoong: add backlight driver
  Loongson: YeeLoong: add battery driver
  Loongson: YeeLoong: add hwmon driver
  Loongson: YeeLoong: add video output driver
  Loongson: YeeLoong: add suspend driver
  Loongson: YeeLoong: add hotkey driver

 arch/mips/kernel/setup.c                           |    1 +
 arch/mips/loongson/Kconfig                         |   21 +
 arch/mips/loongson/lemote-2f/Makefile              |    7 +-
 arch/mips/loongson/lemote-2f/ec_kb3310b.c          |  130 ------
 arch/mips/loongson/lemote-2f/ec_kb3310b.h          |  188 --------
 arch/mips/loongson/lemote-2f/pm.c                  |    4 +-
 arch/mips/loongson/lemote-2f/reset.c               |    2 +-
 .../loongson/lemote-2f/yeeloong_laptop/Kconfig     |   69 +++
 .../loongson/lemote-2f/yeeloong_laptop/Makefile    |   10 +
 .../loongson/lemote-2f/yeeloong_laptop/backlight.c |   93 ++++
 .../loongson/lemote-2f/yeeloong_laptop/battery.c   |  127 ++++++
 .../lemote-2f/yeeloong_laptop/ec_kb3310b.c         |  126 ++++++
 .../lemote-2f/yeeloong_laptop/ec_kb3310b.h         |  194 ++++++++
 .../loongson/lemote-2f/yeeloong_laptop/hotkey.c    |  468 ++++++++++++++++++++
 .../loongson/lemote-2f/yeeloong_laptop/hwmon.c     |  241 ++++++++++
 .../loongson/lemote-2f/yeeloong_laptop/suspend.c   |  141 ++++++
 .../lemote-2f/yeeloong_laptop/video_output.c       |  164 +++++++
 17 files changed, 1664 insertions(+), 322 deletions(-)
 delete mode 100644 arch/mips/loongson/lemote-2f/ec_kb3310b.c
 delete mode 100644 arch/mips/loongson/lemote-2f/ec_kb3310b.h
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/backlight.c
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/battery.c
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.c
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.h
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/hotkey.c
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/hwmon.c
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/suspend.c
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/video_output.c
