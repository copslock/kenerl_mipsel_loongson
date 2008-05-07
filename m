Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 May 2008 08:05:33 +0100 (BST)
Received: from zone0.gcu-squad.org ([212.85.147.21]:4899 "EHLO
	services.gcu-squad.org") by ftp.linux-mips.org with ESMTP
	id S20044581AbYEGHF3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 May 2008 08:05:29 +0100
Received: from jdelvare.pck.nerim.net ([62.212.121.182] helo=hyperion.delvare)
	by services.gcu-squad.org (GCU Mailer Daemon) with esmtpsa id 1Jteeb-0004uz-ID
	(TLSv1:AES256-SHA:256)
	(envelope-from <khali@linux-fr.org>)
	; Wed, 07 May 2008 10:05:34 +0200
Date:	Wed, 7 May 2008 09:05:14 +0200
From:	Jean Delvare <khali@linux-fr.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Alessandro Zummo <a.zummo@towertech.it>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	rtc-linux@googlegroups.com, i2c@lm-sensors.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2/4] RTC: SWARM I2C board initialization
Message-ID: <20080507090514.3a86cf4b@hyperion.delvare>
In-Reply-To: <Pine.LNX.4.55.0805070031410.16173@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0805070031410.16173@cliff.in.clinika.pl>
X-Mailer: Claws Mail 3.4.0 (GTK+ 2.10.6; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <khali@linux-fr.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khali@linux-fr.org
Precedence: bulk
X-list: linux-mips

Oh, BTW...

On Wed, 7 May 2008 01:40:27 +0100 (BST), Maciej W. Rozycki wrote:
> (...)
> 1. i2c-swarm.c -- SWARM I2C board setup, currently for the M41T80 chip on 
>    the bus #1 only.
> (...)
> --- linux-2.6.26-rc1-20080505.macro/arch/mips/sibyte/swarm/Makefile	2004-01-29 04:57:05.000000000 +0000
> +++ linux-2.6.26-rc1-20080505/arch/mips/sibyte/swarm/Makefile	2008-05-06 01:18:21.000000000 +0000
> @@ -1,3 +1,4 @@
> -lib-y				= setup.o rtc_xicor1241.o rtc_m41t81.o
> +obj-y				:= setup.o rtc_xicor1241.o rtc_m41t81.o
>  
> -lib-$(CONFIG_KGDB)		+= dbg_io.o
> +obj-$(CONFIG_I2C_BOARDINFO)	+= i2c-swarm.o
> +obj-$(CONFIG_KGDB)		+= dbg_io.o
> (...)
> --- linux-2.6.26-rc1-20080505.macro/arch/mips/sibyte/swarm/i2c-swarm.c	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.26-rc1-20080505/arch/mips/sibyte/swarm/i2c-swarm.c	2008-05-06 23:51:34.000000000 +0000

i2c-foo.c is consistently used for i2c bus driver themselves so far.
It's somewhat confusing to see you name platform code that way. It's
also redundant, given that the file lives in the swarm platform
directory. May I suggest naming this file just
arch/mips/sibyte/swarm/i2c.c? Other architectures (cris, arm) are doing
this already.

-- 
Jean Delvare
