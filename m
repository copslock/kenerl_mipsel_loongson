Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Dec 2009 14:30:37 +0100 (CET)
Received: from mail-px0-f176.google.com ([209.85.216.176]:50845 "EHLO
        mail-px0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492914AbZLDNad (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Dec 2009 14:30:33 +0100
Received: by pxi6 with SMTP id 6so504438pxi.0
        for <multiple recipients>; Fri, 04 Dec 2009 05:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=JAznP27pg43oXIr2HmrSJJsApl1++Rh6bbcXndfZ0aQ=;
        b=N0wZ+OACQkYx6NggN/BikBXCoW3z/BWRoW3njMeHfyFH5yrQkIOCh5PE7Heli/Dvqc
         Xy47crSBJoLKfFQR+OwSziZUK57XqovH04xzZFx/WUX2oMuXgisOhUEWrJkGXi7yOm0e
         eTD6V7RugSRnK5KeCZ+Y20X9x8OhFZZhn8cPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=vq424wypQ823yGFrjQhXQximLXGQl3D++Na51VtCZNYmxVG6mVjlEC5aYSpzSQLeBf
         5uU6sQbHVkGRXmmCQgx8qhFzAAuPoSlfx4BqhDZH2NeC0oyiW4/eOocakNDJExClZ+4y
         ihk3D3ngYAjqd3hUN5/4VzJ+mRQLt4jw7TetQ=
Received: by 10.115.66.9 with SMTP id t9mr4134315wak.56.1259933423877;
        Fri, 04 Dec 2009 05:30:23 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm2524514pzk.0.2009.12.04.05.30.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Dec 2009 05:30:23 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>, akpm@linux-foundation.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
        zhangfx@lemote.com, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v7 0/8] Loongson: YeeLoong: add platform specific driver
Date:   Fri,  4 Dec 2009 21:30:09 +0800
Message-Id: <cover.1259932036.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25300
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patchset adds platform specific drivers for YeeLoong netbook. including
the backlight, battery, hwmon, video output, suspend and hotkey(input)
subdrivers. These drivers provide standard interfaces to the user-space
applications to manage the related devices:

	 Subdrivers                     Applicatioins.

        - backlight
          /sys/class/backlight/         kpowersave, gnome-power-manager
        - battery
          /proc/apm                     kpowersave, gnome-power-manager
        - hwmon
          /sys/class/hwmon/             lm-sensors, sensors-applet...
        - video output
          /sys/class/video_output       ?
        - hotkey
          /sys/class/input/             gnome-settings-daemon ?
        - platform(suspend) 
          /sys/power/state              kpowersave, gnome-power-manager

Changes from v6:

	- Move the whole stuff back to drivers/platform/mips/

	  It's very difficult to find a good place to put it in, so, just did
	  what the folks have done under drivers/platform/x86/

	- Rebase the hotkey driver on the sparse keymap library from Dmitry
	Torokhov.

	- Load this module automatically
	  Register a platform device, bind it with this module.

	- Fixup of battery subdriver
	  Ensure apm_get_power_status is NULL when exit.

Wu Zhangjin (8):
  MIPS: add subdirectory for platform extension drivers
  Loongson: YeeLoong: add platform driver
  Loongson: YeeLoong: add backlight driver
  Loongson: YeeLoong: add battery driver
  Loongson: YeeLoong: add hardware monitoring driver
  Loongson: YeeLoong: add video output driver
  Loongson: YeeLoong: add suspend support
  Loongson: YeeLoong: add input/hotkey driver

 arch/mips/include/asm/mach-loongson/ec_kb3310b.h |  191 ++++
 arch/mips/include/asm/mach-loongson/loongson.h   |    6 +
 arch/mips/loongson/common/cmdline.c              |    8 +
 arch/mips/loongson/lemote-2f/Makefile            |    2 +-
 arch/mips/loongson/lemote-2f/ec_kb3310b.c        |   12 +-
 arch/mips/loongson/lemote-2f/ec_kb3310b.h        |  188 ----
 arch/mips/loongson/lemote-2f/platform.c          |   40 +
 arch/mips/loongson/lemote-2f/pm.c                |    4 +-
 arch/mips/loongson/lemote-2f/reset.c             |    2 +-
 drivers/platform/Kconfig                         |    4 +
 drivers/platform/Makefile                        |    1 +
 drivers/platform/mips/Kconfig                    |   33 +
 drivers/platform/mips/Makefile                   |    5 +
 drivers/platform/mips/yeeloong_laptop.c          | 1067 ++++++++++++++++++++++
 14 files changed, 1363 insertions(+), 200 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson/ec_kb3310b.h
 delete mode 100644 arch/mips/loongson/lemote-2f/ec_kb3310b.h
 create mode 100644 arch/mips/loongson/lemote-2f/platform.c
 create mode 100644 drivers/platform/mips/Kconfig
 create mode 100644 drivers/platform/mips/Makefile
 create mode 100644 drivers/platform/mips/yeeloong_laptop.c
