Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2009 12:17:19 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:39842 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492257AbZLALRQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Dec 2009 12:17:16 +0100
Received: by pzk35 with SMTP id 35so3583862pzk.22
        for <multiple recipients>; Tue, 01 Dec 2009 03:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=LkCofArmK7dwd2HGTz6gKeJsoTtytXbkQU90l2kII6M=;
        b=Gij/nukzgsAKQUjiM4QOBtxb2Hc4yEFP1+D2YNqPsooLuM6s8gYfKimfS+KnMv63E6
         ORKQ3LKXKb+kDHYfi+x6y7ti8nIBj3uBJdVBIEKtnzuUPXohtwc6+0P+oavl/5yP68wU
         DrlMBIc+xGMT3v/d85HR8XCWgVPVAt1iSPjiU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=BSugQVKB9AKQwUj31oeO2yqeKXAYjQ+zFpq3rbVGnQir8S95E22ni+ROas36xTWA/G
         dHhZnAF1PFgWfLzk2XUnMn9YbfluyqV1dN0/vgJU1gqnzk4UxYBumPQe+FNUktVUw92h
         TVSTnciKRx7XUDtwvGQCOBXSv4C3+T1tBn/IM=
Received: by 10.114.188.17 with SMTP id l17mr10606869waf.135.1259666229368;
        Tue, 01 Dec 2009 03:17:09 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm4561pzk.3.2009.12.01.03.17.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 03:17:08 -0800 (PST)
Subject: Re: [PATCH v6 0/8] Loongson: YeeLoong: add platform specific
 drivers
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
        linux-mips@linux-mips.org, zhangfx@lemote.com
In-Reply-To: <cover.1259660040.git.wuzhangjin@gmail.com>
References: <cover.1259660040.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Tue, 01 Dec 2009 19:16:46 +0800
Message-ID: <1259666206.7093.4.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Sorry, I have sent this stuff 8 times, forgive me ;(

On Tue, 2009-12-01 at 19:06 +0800, Wu Zhangin wrote:
> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> This patchset adds platform specific drivers for YeeLoong netbook. including
> the backlight, battery, hwmon, video output, suspend and hotkey(input) drivers.
> These drivers provide standard interfaces to the user-space applications to
> manage the relative devices:
> 	
>  	 Modules			Tools
> 
> 	- backlight
> 	  /sys/class/backlight/		kpowersave, gnome-power-manager
> 	- battery
> 	  /proc/apm			kpowersave, gnome-power-manager
> 	- hwmon
> 	  /sys/class/hwmon/		lm-sensors, sensors-applet...
> 	- video output
> 	  /sys/class/video_output	?
> 	- suspend
> 	  /sys/power/state		kpowersave, gnome-power-manager
> 	- hotkey
> 	  /sys/class/input/		gnome-settings-daemon ?
> 
> To utilize the above interfaces, you are recommended to install the latest hal,
> dbus.
> 
> This v6 revision incorporates with the feedbacks from Ralf, Pavel Machek,
> Rafael J. Wysocki and Dmitry Torokhov.
> 
> Changes from the old v5 revision:
> 
> 	- Cleanup the "select" and "depend" of the options
> 	  Replace some "select"s by "depend"s to avoid potential compiling
> 	  errors.
> 
> 	- Cleanup the hotkey(input) driver
> 	  Merge several functions, Cleanup the comments, Use Switch...Case
> 	  instead of the array.
> 
> 	- Fixup of the video output driver  
> 	  Seems the video output subsystem doesn't handle the input value, we
> 	  handle it outselves via !!od->request_state.
> 
> 	- Append the yl_ prefix to the file names
> 	  yl_ prefix is needed to distinguish it with the next patchset for
> 	  lynloong pc platform drivers.
> 
> All changes have been tested again.
> 
> Best Regards,
>      Wu Zhangjin
> 
> Wu Zhangjin (8):
>   Loongson: Lemote-2F: add platform specific submenu
>   Loongson: YeeLoong: add platform specific option
>   Loongson: YeeLoong: add backlight driver
>   Loongson: YeeLoong: add battery driver
>   Loongson: YeeLoong: add hwmon driver
>   Loongson: YeeLoong: add video output driver
>   Loongson: YeeLoong: add suspend driver
>   Loongson: YeeLoong: add hotkey driver
> 
>  arch/mips/kernel/setup.c                           |    1 +
>  arch/mips/loongson/Kconfig                         |   21 +
>  arch/mips/loongson/lemote-2f/Makefile              |    7 +-
>  arch/mips/loongson/lemote-2f/ec_kb3310b.c          |  130 ------
>  arch/mips/loongson/lemote-2f/ec_kb3310b.h          |  188 --------
>  arch/mips/loongson/lemote-2f/pm.c                  |    4 +-
>  arch/mips/loongson/lemote-2f/reset.c               |    2 +-
>  .../loongson/lemote-2f/yeeloong_laptop/Kconfig     |   65 +++
>  .../loongson/lemote-2f/yeeloong_laptop/Makefile    |   10 +
>  .../lemote-2f/yeeloong_laptop/ec_kb3310b.c         |  126 ++++++
>  .../lemote-2f/yeeloong_laptop/ec_kb3310b.h         |  193 +++++++++
>  .../lemote-2f/yeeloong_laptop/yl_backlight.c       |   93 ++++
>  .../lemote-2f/yeeloong_laptop/yl_battery.c         |  127 ++++++
>  .../loongson/lemote-2f/yeeloong_laptop/yl_hotkey.c |  452 ++++++++++++++++++++
>  .../loongson/lemote-2f/yeeloong_laptop/yl_hwmon.c  |  239 +++++++++++
>  .../lemote-2f/yeeloong_laptop/yl_suspend.c         |  135 ++++++
>  .../loongson/lemote-2f/yeeloong_laptop/yl_vo.c     |  164 +++++++
>  17 files changed, 1635 insertions(+), 322 deletions(-)
>  delete mode 100644 arch/mips/loongson/lemote-2f/ec_kb3310b.c
>  delete mode 100644 arch/mips/loongson/lemote-2f/ec_kb3310b.h
>  create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
>  create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
>  create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.c
>  create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.h
>  create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_backlight.c
>  create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_battery.c
>  create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_hotkey.c
>  create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_hwmon.c
>  create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_suspend.c
>  create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_vo.c
> 
