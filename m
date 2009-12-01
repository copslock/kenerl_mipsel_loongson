Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2009 12:06:36 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:58223 "EHLO
        mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491888AbZLALGc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Dec 2009 12:06:32 +0100
Received: by pwi15 with SMTP id 15so2581540pwi.24
        for <multiple recipients>; Tue, 01 Dec 2009 03:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=j2/FTmBB7SrTcBEHfax6N1ECzjpYf/o1bCyqNDPqYUs=;
        b=U8VY4JHJnl8Oc3WvMDYUG8geteXUB/Y1swm/mgVk7lSlsmEJMX3Jyk4duzzZtEqE/R
         9gEesX2ydPUpkhdzWDfGhV4g1uyZSr4WTXODs9CQQboP58ppN7bdoXsWjOEI1EFPOppF
         9CKBFwODf+8h0TP/F3eUcue1Cq5jcZQTrMAAU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=CcBlpar9KiQgv0LyF+5Ywt10UO86/X9dX+yHkibq3HGDVbQRe8ur7Cuq80Vjb7iUb8
         zkI/+nYBUOUTjDLTBkXXXVgCVwz3uB9UaAsd1EZXVbI0vh+inPtxsR5QlynO7Szlmx1M
         yFj+sCAlxNuG4AQfMTOByluCsJKwx6pI4vt1Y=
Received: by 10.114.214.24 with SMTP id m24mr10632458wag.93.1259665584985;
        Tue, 01 Dec 2009 03:06:24 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm484367pxi.12.2009.12.01.03.06.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 03:06:24 -0800 (PST)
From:   Wu Zhangin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
        linux-mips@linux-mips.org, zhangfx@lemote.com,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v6 0/8] Loongson: YeeLoong: add platform specific drivers
Date:   Tue,  1 Dec 2009 19:06:13 +0800
Message-Id: <cover.1259660040.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patchset adds platform specific drivers for YeeLoong netbook. including
the backlight, battery, hwmon, video output, suspend and hotkey(input) drivers.
These drivers provide standard interfaces to the user-space applications to
manage the relative devices:
	
 	 Modules			Tools

	- backlight
	  /sys/class/backlight/		kpowersave, gnome-power-manager
	- battery
	  /proc/apm			kpowersave, gnome-power-manager
	- hwmon
	  /sys/class/hwmon/		lm-sensors, sensors-applet...
	- video output
	  /sys/class/video_output	?
	- suspend
	  /sys/power/state		kpowersave, gnome-power-manager
	- hotkey
	  /sys/class/input/		gnome-settings-daemon ?

To utilize the above interfaces, you are recommended to install the latest hal,
dbus.

This v6 revision incorporates with the feedbacks from Ralf, Pavel Machek,
Rafael J. Wysocki and Dmitry Torokhov.

Changes from the old v5 revision:

	- Cleanup the "select" and "depend" of the options
	  Replace some "select"s by "depend"s to avoid potential compiling
	  errors.

	- Cleanup the hotkey(input) driver
	  Merge several functions, Cleanup the comments, Use Switch...Case
	  instead of the array.

	- Fixup of the video output driver  
	  Seems the video output subsystem doesn't handle the input value, we
	  handle it outselves via !!od->request_state.

	- Append the yl_ prefix to the file names
	  yl_ prefix is needed to distinguish it with the next patchset for
	  lynloong pc platform drivers.

All changes have been tested again.

Best Regards,
     Wu Zhangjin

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
 .../loongson/lemote-2f/yeeloong_laptop/Kconfig     |   65 +++
 .../loongson/lemote-2f/yeeloong_laptop/Makefile    |   10 +
 .../lemote-2f/yeeloong_laptop/ec_kb3310b.c         |  126 ++++++
 .../lemote-2f/yeeloong_laptop/ec_kb3310b.h         |  193 +++++++++
 .../lemote-2f/yeeloong_laptop/yl_backlight.c       |   93 ++++
 .../lemote-2f/yeeloong_laptop/yl_battery.c         |  127 ++++++
 .../loongson/lemote-2f/yeeloong_laptop/yl_hotkey.c |  452 ++++++++++++++++++++
 .../loongson/lemote-2f/yeeloong_laptop/yl_hwmon.c  |  239 +++++++++++
 .../lemote-2f/yeeloong_laptop/yl_suspend.c         |  135 ++++++
 .../loongson/lemote-2f/yeeloong_laptop/yl_vo.c     |  164 +++++++
 17 files changed, 1635 insertions(+), 322 deletions(-)
 delete mode 100644 arch/mips/loongson/lemote-2f/ec_kb3310b.c
 delete mode 100644 arch/mips/loongson/lemote-2f/ec_kb3310b.h
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.c
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.h
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_backlight.c
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_battery.c
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_hotkey.c
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_hwmon.c
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_suspend.c
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_vo.c
