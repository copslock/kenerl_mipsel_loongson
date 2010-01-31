Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Jan 2010 13:26:41 +0100 (CET)
Received: from mail-pz0-f203.google.com ([209.85.222.203]:61177 "EHLO
        mail-pz0-f203.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492272Ab0AaM0h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 31 Jan 2010 13:26:37 +0100
Received: by pzk41 with SMTP id 41so5411856pzk.0
        for <multiple recipients>; Sun, 31 Jan 2010 04:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=uG2qwTWn7jMLpaMm1g6ja3ZFAB/ym9jYtrsk//AdPe0=;
        b=RgC2W8gjmqyPSIklDsyzId6zpT5SRvyARNBiQ8fI05PjMkuH+AaWDyJp3HQqQDAdPB
         +Kg8s9VzpzTbxsuWCURM4F+Duvfny93+CHVRy8qep0TWSXHDVGaPIdAItwLZfbCxVWN6
         n5x9s9vgvxemXAWN30S/pfYHPkzjCXx6iSJZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=j3hFVf0w4ll1LeS2p2KP4A/KRyNWLBr/Vv+Oz3n7NoBxqcKfTNuv70DjCKThUApZwt
         69AFecoW/y1pRxeQvkOIeCMLwETgoLdUc5GCelhp0gqsvvIPAdz8lnTINfRlJv0BIcDW
         3EEpWESXeMF9xCsWjv4idqbN4IQctUIBL4dlg=
Received: by 10.141.131.10 with SMTP id i10mr2273102rvn.87.1264940788966;
        Sun, 31 Jan 2010 04:26:28 -0800 (PST)
Received: from ?192.168.2.212? ([202.201.14.140])
        by mx.google.com with ESMTPS id 20sm838466pzk.13.2010.01.31.04.26.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 Jan 2010 04:26:28 -0800 (PST)
Subject: Re: [PATCH v11 0/9] Loongson: YeeLoong: add platform drivers
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
        linux-mips@linux-mips.org, zhangfx@lemote.com
In-Reply-To: <cover.1264940063.git.wuzhangjin@gmail.com>
References: <cover.1264940063.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Sun, 31 Jan 2010 20:20:23 +0800
Message-ID: <1264940423.21259.2.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.2 
Content-Transfer-Encoding: 7bit
X-archive-position: 25787
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19726

On Sun, 2010-01-31 at 20:15 +0800, Wu Zhangjin wrote:
> From: Wu Zhangjin <wuzhangjin@gmail.com>

(ooh, just re-generate the patchset with "git format-patch" but forgot
to put the comments, here it is!)

This patchset adds several platform specific drivers for the YeeLoong
netbook
made by Lemote.

It is completely based on the v10 revision and with the following
changes:

  O Rebased on the latest linux-queue git tree of Ralf.
  O Split the EC revision related handling out of the "input/hotkey"
driver.
  O Rewrite the AC & Battery driver with the new power_supply interface
as "Pavel Machek" suggested.

All of them have been tested again.

Best Regards,
	Wu Zhangjin

> 
> Wu Zhangjin (9):
>   MIPS: add subdirectory for platform extension drivers
>   Loongson: YeeLoong: add platform driver
>   Loongson: YeeLoong: add backlight driver
>   Loongson: YeeLoong: add hardware monitoring driver
>   Loongson: YeeLoong: add video output driver
>   Loongson: YeeLoong: add suspend support
>   Loongson: YeeLoong: add input/hotkey driver
>   Loongson: YeeLoong: Co-operate with the revisions of EC
>   Loongson: YeeLoong: add power_supply based battery driver
> 
>  arch/mips/include/asm/mach-loongson/ec_kb3310b.h |  188 ++++
>  arch/mips/include/asm/mach-loongson/loongson.h   |    6 +
>  arch/mips/loongson/common/cmdline.c              |    8 +
>  arch/mips/loongson/lemote-2f/Makefile            |    2 +-
>  arch/mips/loongson/lemote-2f/ec_kb3310b.c        |   12 +-
>  arch/mips/loongson/lemote-2f/ec_kb3310b.h        |  188 ----
>  arch/mips/loongson/lemote-2f/platform.c          |   39 +
>  arch/mips/loongson/lemote-2f/pm.c                |    4 +-
>  arch/mips/loongson/lemote-2f/reset.c             |    2 +-
>  drivers/platform/Kconfig                         |    4 +
>  drivers/platform/Makefile                        |    1 +
>  drivers/platform/mips/Kconfig                    |   32 +
>  drivers/platform/mips/Makefile                   |    5 +
>  drivers/platform/mips/yeeloong_laptop.c          | 1192 ++++++++++++++++++++++
>  14 files changed, 1483 insertions(+), 200 deletions(-)
>  create mode 100644 arch/mips/include/asm/mach-loongson/ec_kb3310b.h
>  delete mode 100644 arch/mips/loongson/lemote-2f/ec_kb3310b.h
>  create mode 100644 arch/mips/loongson/lemote-2f/platform.c
>  create mode 100644 drivers/platform/mips/Kconfig
>  create mode 100644 drivers/platform/mips/Makefile
>  create mode 100644 drivers/platform/mips/yeeloong_laptop.c
> 
