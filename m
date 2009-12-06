Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Dec 2009 08:05:10 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:38190 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492205AbZLFHFH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Dec 2009 08:05:07 +0100
Received: by pzk35 with SMTP id 35so3285699pzk.22
        for <multiple recipients>; Sat, 05 Dec 2009 23:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=yq9kr6E3UVH3ILMGv6CSjtPZq7gH80WBhZaqzNDw1ek=;
        b=BE7LgLFidT8ylpA4v+FBT8oikSAPkFrpXFwQ2gJv64hIRIvodT89sMMVbgJ2x0zqMp
         7nwfN2EJprgPtVCOstdra5HSXKJhprXqCvI0CrdhYhyV4kG3GYDxBe7hls2TH3iB6fXV
         tj2IL0B9cpLrJ2Gw3qkpxC+asP19BmnGm+Kxw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ZmAETzC20VVoobcXgsvcLOIIUj73MxqzKsdzQiMt6Ke8YtnZeEwh9AUyryFejqxqxO
         94fUHEaMCpFcQCfSLQOTJZvPMCAoxvmYvZu7SnTIeKjzgSXJO9/18djqipvgd4DIahSB
         0kroY68B31uGK4ylXpSTsI/bL5ziSLFOXkxZo=
Received: by 10.115.66.24 with SMTP id t24mr8156297wak.188.1260083099386;
        Sat, 05 Dec 2009 23:04:59 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm3974972pzk.5.2009.12.05.23.04.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Dec 2009 23:04:58 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>, akpm@linux-foundation.org
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J . Wysocki" <rjw@sisk.pl>, zhangfx@lemote.com,
        linux-laptop@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v8 0/8] Loongson: YeeLoong: add platform drivers 
Date:   Sun,  6 Dec 2009 15:01:40 +0800
Message-Id: <cover.1260082252.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25330
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
applications to manage the related devices.

This v8 revision incorporates with the feedbacks from Pavel Machek, add the
cleanups of the hwmon, video output and input/hotkey drivers.

Hi, Ralf and Andrew Morton

Could you please queue this patchset for 2.6.33? of course, any new feedbacks
are welcome, thanks!

Best Regards,
	Wu Zhangjin

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
 drivers/platform/mips/yeeloong_laptop.c          | 1038 ++++++++++++++++++++++
 14 files changed, 1334 insertions(+), 200 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson/ec_kb3310b.h
 delete mode 100644 arch/mips/loongson/lemote-2f/ec_kb3310b.h
 create mode 100644 arch/mips/loongson/lemote-2f/platform.c
 create mode 100644 drivers/platform/mips/Kconfig
 create mode 100644 drivers/platform/mips/Makefile
 create mode 100644 drivers/platform/mips/yeeloong_laptop.c
