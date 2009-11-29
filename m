Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Nov 2009 23:35:26 +0100 (CET)
Received: from ogre.sisk.pl ([217.79.144.158]:37482 "EHLO ogre.sisk.pl"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491030AbZK2WfX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 29 Nov 2009 23:35:23 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
        by ogre.sisk.pl (Postfix) with ESMTP id 355A116BF16;
        Sun, 29 Nov 2009 23:16:53 +0100 (CET)
Received: from ogre.sisk.pl ([127.0.0.1])
 by localhost (ogre.sisk.pl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 05164-06; Sun, 29 Nov 2009 23:16:35 +0100 (CET)
Received: from tosh.localnet (220-bem-13.acn.waw.pl [82.210.184.220])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by ogre.sisk.pl (Postfix) with ESMTP id 1B44A16BEDF;
        Sun, 29 Nov 2009 23:16:35 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@sisk.pl>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Subject: Re: [PATCH v5 7/8] Loongson: YeeLoong: add suspend driver
Date:   Sun, 29 Nov 2009 23:35:39 +0100
User-Agent: KMail/1.12.3 (Linux/2.6.32-rc8-rjw; KDE/4.3.3; x86_64; ; )
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-mips@linux-mips.org, zhangfx@lemote.com, yanh@lemote.com,
        huhb@lemote.com, Pavel Machek <pavel@ucw.cz>,
        linux-pm@lists.linux-foundation.org
References: <cover.1259414649.git.wuzhangjin@gmail.com> <f758058af5e45ec98bdc849e7762f32d795177e1.1259414649.git.wuzhangjin@gmail.com>
In-Reply-To: <f758058af5e45ec98bdc849e7762f32d795177e1.1259414649.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200911292335.40055.rjw@sisk.pl>
X-Virus-Scanned: amavisd-new at ogre.sisk.pl using MkS_Vir for Linux
Return-Path: <rjw@sisk.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25199
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rjw@sisk.pl
Precedence: bulk
X-list: linux-mips

On Saturday 28 November 2009, Wu Zhangjin wrote:
> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> This patch adds Suspend Driver, which will suspend the YeeLoong Platform
> specific devices.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  .../loongson/lemote-2f/yeeloong_laptop/Kconfig     |    9 ++
>  .../loongson/lemote-2f/yeeloong_laptop/Makefile    |    1 +
>  .../loongson/lemote-2f/yeeloong_laptop/suspend.c   |  141 ++++++++++++++++++++
>  3 files changed, 151 insertions(+), 0 deletions(-)
>  create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/suspend.c
> 
> diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
> index c4398ff..49d63c5 100644
> --- a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
> +++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
> @@ -45,4 +45,13 @@ config YEELOONG_VO
>  	  This option adds Video Output Driver, which provides standard
>  	  interface to turn on/off the video output of LCD, CRT.
>  
> +config YEELOONG_SUSPEND
> +	tristate "Suspend Driver"

Why tristate?

> +	depends on YEELOONG_HWMON && YEELOONG_VO
> +	select SUSPEND

I'm not sure if that's going to work.  Please make it depend on SUSPEND rather
than select it.

> +	default y
> +	help
> +	  This option adds Suspend Driver, which will suspend the YeeLoong
> +	  Platform specific devices.
> +
>  endif

Thanks,
Rafael
