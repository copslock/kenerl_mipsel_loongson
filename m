Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 10:26:18 +0100 (WEST)
Received: from mail-fx0-f223.google.com ([209.85.220.223]:51911 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022399AbZFDJ0L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Jun 2009 10:26:11 +0100
Received: by fxm23 with SMTP id 23so604503fxm.0
        for <multiple recipients>; Thu, 04 Jun 2009 02:26:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=MFfUKYm5edvcUJ/yiH3WWV3tLwZPRvl6ENvsQiGvf6Y=;
        b=QmhmjmUmUy6eMvkN2717ugPb45jPq0Jf9ozNNuYzteVlHoiGxfJQcAmN8YEEK3Cg3f
         zQQ+5YsVniT4PpzB6dSPZijPacEhDWGkthSXhA3bkTzqq6Pkn4lw6nycNjqTFqxM7RAS
         W6QuY6ViXKLi5nT/1oVCJ0dnxwrB3QkrG7+xE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=r8RwTxLz1dgljiKWMesEXW8d/mUJ5XsNFKc8BJshk4HhXx/oXwjPSsLya4MPlKsN8x
         Xd2JV20IxoyAi/LTNqOzxhLlm1YqrLmzbNiKm+4WEkhAI/otyfYk+FAANK/9USP4DJRs
         yC3sTVwlSaZQZ0z+ES2d2CocdvX/Z0wwGWTBo=
Received: by 10.103.172.9 with SMTP id z9mr1191723muo.58.1244107565779;
        Thu, 04 Jun 2009 02:26:05 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 12sm3151521muq.53.2009.06.04.02.26.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Jun 2009 02:26:04 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH 0/5] Alchemy GPIO rewrite v6
Date:	Thu, 4 Jun 2009 11:26:02 +0200
User-Agent: KMail/1.9.9
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
References: <1244045888-16259-1-git-send-email-manuel.lauss@gmail.com>
In-Reply-To: <1244045888-16259-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200906041126.02982.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Manuel,

Le Wednesday 03 June 2009 18:18:03 Manuel Lauss, vous avez écrit :
> Rewrite Alchemy GPIO support to be compatible with the Linux
> GPIO framework, both with and without gpiolib.  For a list of
> justifications, see blurb in patch #2.
> Patches #3-#5 replace a few open-coded GPIO accesses in the board
> files with calls to the new gpio functions.
>
> Tested on DB1200 and a custom Au1200 platform.
>
> v6 - renamed gpio.[ch] to gpio-au1000.[ch], since this code only affects
>      pre-Au1300 chips.  Should make integration of Au1300 GPIO a bit
>      easier.
> v5 - fix gpio1 bug in inlined gpio_get_value()
> v4 - GPIO2 shared interrupt management, styling.
> v3 - fixed thinko in alchemy_gpio2_set_value (16->32 bit)
> v2 - added gpio_to_irq and irq_to_gpio, some renaming.

Thanks for this work ! For the whole serie you got my Acked-by: Florian 
Fainelli <florian@openwrt.org>. Thanks !

>
> Manuel Lauss (5):
>   Alchemy: remove unused au1000_gpio.h header
>   Alchemy: rewrite GPIO support.
>   Alchemy: mtx-1: use linux gpio api.
>   Alchemy: xxs1500: use linux gpio api.
>   Alchemy: devboards: convert to gpio calls.
>
>  arch/mips/Makefile                               |    5 +-
>  arch/mips/alchemy/Kconfig                        |   19 +-
>  arch/mips/alchemy/common/Makefile                |   11 +-
>  arch/mips/alchemy/common/gpio-au1000.c           |  130 +++++
>  arch/mips/alchemy/common/gpio.c                  |  201 -------
>  arch/mips/alchemy/common/reset.c                 |    5 +-
>  arch/mips/alchemy/devboards/db1x00/board_setup.c |    8 +-
>  arch/mips/alchemy/devboards/pb1000/board_setup.c |   10 +-
>  arch/mips/alchemy/devboards/pb1100/board_setup.c |    3 +-
>  arch/mips/alchemy/devboards/pb1500/board_setup.c |   10 +-
>  arch/mips/alchemy/devboards/pm.c                 |    2 +-
>  arch/mips/alchemy/mtx-1/board_setup.c            |   24 +-
>  arch/mips/alchemy/xxs1500/board_setup.c          |   21 +-
>  arch/mips/include/asm/mach-au1x00/au1000_gpio.h  |   56 --
>  arch/mips/include/asm/mach-au1x00/gpio-au1000.h  |  604
> ++++++++++++++++++++++ arch/mips/include/asm/mach-au1x00/gpio.h         |  
> 35 +-
>  16 files changed, 818 insertions(+), 326 deletions(-)
>  create mode 100644 arch/mips/alchemy/common/gpio-au1000.c
>  delete mode 100644 arch/mips/alchemy/common/gpio.c
>  delete mode 100644 arch/mips/include/asm/mach-au1x00/au1000_gpio.h
>  create mode 100644 arch/mips/include/asm/mach-au1x00/gpio-au1000.h



-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
