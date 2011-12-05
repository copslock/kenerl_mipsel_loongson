Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Dec 2011 23:36:32 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:34326 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903629Ab1LEWgW convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 5 Dec 2011 23:36:22 +0100
Received: by bkcje16 with SMTP id je16so5048188bkc.36
        for <multiple recipients>; Mon, 05 Dec 2011 14:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        bh=acEQrSGQLmFvFWOfYABMT/by1y8REsa1/RX14icVQGI=;
        b=U1DB1jzr5uRq2d2yt63pD/7lyL67DaMb88uKxq4rRNe3e3kPBUESVd0XqfUGCV6gA+
         tizIoScsjgUpi9xMMN4J0LZhCPgvSsPixR+LIL2a3548kWHtA0GjC9k+JHoKThpvLnnQ
         Mi+sQHaw3fEUA4eJwZaxrZSMq2IeJVnMyUb+8=
Received: by 10.180.4.167 with SMTP id l7mr14947247wil.51.1323124576730;
        Mon, 05 Dec 2011 14:36:16 -0800 (PST)
Received: from lenovo.localnet ([2a01:e35:2f70:4010:21d:7dff:fe45:5399])
        by mx.google.com with ESMTPS id d17sm30224723wbh.19.2011.12.05.14.36.09
        (version=SSLv3 cipher=OTHER);
        Mon, 05 Dec 2011 14:36:11 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
To:     Jonas Gorski <jonas.gorski@gmail.com>
Subject: Re: [PATCH 0/7] MTD: MAPS: remove bcm963xx-flash
Date:   Mon, 5 Dec 2011 23:36:07 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.0-1-amd64; KDE/4.6.5; x86_64; ; )
Cc:     linux-mtd@lists.infradead.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Artem Bityutskiy <Artem.Bityutskiy@intel.com>
References: <1323097691-16414-1-git-send-email-jonas.gorski@gmail.com>
In-Reply-To: <1323097691-16414-1-git-send-email-jonas.gorski@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <201112052336.07901.florian@openwrt.org>
X-archive-position: 32040
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3874

Hello Jonas,

Le lundi 05 décembre 2011 16:08:04, Jonas Gorski a écrit :
> While trying to improve the bcm963xx CFE partition parsing, I noticed
> that it could be completely replaced by the generic physmap flash
> driver using a custom parser.
> 
> The following patch set tries to accomplish that.
> 
> The first few patches clean take care of some minor code style issues
> first to prevent checkpatch from complaining when moving code around.
> 
> After that I move the CFE partition parsing into a parser and make
> bcm963xx-flash use it to make sure I don't create a non working version.
> 
> Finally I'll allow physmap_flash_data to take partition parser names for
> overriding the default parsers list (the OF version already allows that),
> let BCM63XX use it, and remove the bcm963xx-flash driver as it is now
> completely replaced by physmap + CFE parser.
> 
> While most patches are limited to the MTD tree, patch 6/7 touches MIPS,
> so it could go in either tree. But since the MTD tree already has some
> modifications for bcm963xx-flash, I think it's better to let it go
> through the MTD tree, to reduce the (potential for) conflicts.

For the whole series, feel free to add my:

Acked-by: Florian Fainelli <florian@openwrt.org>

thanks!

> 
> Regards
> Jonas
> 
> P.S: This patchset is based on l2-mtd-2.6.git, which seems to be the
> "correct" tree now (the website says mtd-2.6.git, but it doesn't look
> like the correct one, having no commits).
> 
> Jonas Gorski (7):
>   MTD: MAPS: bcm963xx-flash: fix word order for spare partition
>   MTD: MAPS: bcm963xx-flash: remove superfluous semicolons
>   MTD: MAPS: bcm963xx-flash: clean up printk usage
>   MTD: MAPS: bcm963xx-flash: make CFE partition parsing an mtd parser
>   MTD: MAPS: physmap: allow partition parsers for physmap_flash_data
>   MIPS: BCM63XX: use the new bcm63xxpart parser
>   MTD: MAPS: remove the now unused bcm963xx-flash
> 
>  arch/mips/bcm63xx/boards/board_bcm963xx.c |    3 +
>  drivers/mtd/Kconfig                       |    8 +
>  drivers/mtd/Makefile                      |    1 +
>  drivers/mtd/bcm63xxpart.c                 |  189 ++++++++++++++++++++
>  drivers/mtd/maps/Kconfig                  |    1 +
>  drivers/mtd/maps/bcm963xx-flash.c         |  265
> ----------------------------- drivers/mtd/maps/physmap.c                | 
>   5 +-
>  include/linux/mtd/physmap.h               |    1 +
>  8 files changed, 207 insertions(+), 266 deletions(-)
>  create mode 100644 drivers/mtd/bcm63xxpart.c
>  delete mode 100644 drivers/mtd/maps/bcm963xx-flash.c

-- 
Florian
