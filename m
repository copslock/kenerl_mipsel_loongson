Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 May 2008 08:37:15 +0100 (BST)
Received: from winston.telenet-ops.be ([195.130.137.75]:41863 "EHLO
	winston.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20029177AbYEGHhM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 May 2008 08:37:12 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by winston.telenet-ops.be (Postfix) with SMTP id 6815BA0042;
	Wed,  7 May 2008 09:37:11 +0200 (CEST)
Received: from anakin.of.borg (78-21-204-88.access.telenet.be [78.21.204.88])
	by winston.telenet-ops.be (Postfix) with ESMTP id D5C48A0051;
	Wed,  7 May 2008 09:37:06 +0200 (CEST)
Received: from anakin.of.borg (localhost [127.0.0.1])
	by anakin.of.borg (8.14.2/8.14.2/Debian-4) with ESMTP id m477b4G0011576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 7 May 2008 09:37:04 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.2/8.14.2/Submit) with ESMTP id m477b38o011573;
	Wed, 7 May 2008 09:37:03 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Wed, 7 May 2008 09:37:01 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Jean Delvare <khali@linux-fr.org>
cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	rtc-linux@googlegroups.com, i2c@lm-sensors.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2/4] RTC: SWARM I2C board initialization
In-Reply-To: <20080507090514.3a86cf4b@hyperion.delvare>
Message-ID: <Pine.LNX.4.64.0805070936060.6341@anakin>
References: <Pine.LNX.4.55.0805070031410.16173@cliff.in.clinika.pl>
 <20080507090514.3a86cf4b@hyperion.delvare>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19123
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 7 May 2008, Jean Delvare wrote:
> Oh, BTW...
> 
> On Wed, 7 May 2008 01:40:27 +0100 (BST), Maciej W. Rozycki wrote:
> > (...)
> > 1. i2c-swarm.c -- SWARM I2C board setup, currently for the M41T80 chip on 
> >    the bus #1 only.
> > (...)
> > --- linux-2.6.26-rc1-20080505.macro/arch/mips/sibyte/swarm/Makefile	2004-01-29 04:57:05.000000000 +0000
> > +++ linux-2.6.26-rc1-20080505/arch/mips/sibyte/swarm/Makefile	2008-05-06 01:18:21.000000000 +0000
> > @@ -1,3 +1,4 @@
> > -lib-y				= setup.o rtc_xicor1241.o rtc_m41t81.o
> > +obj-y				:= setup.o rtc_xicor1241.o rtc_m41t81.o
> >  
> > -lib-$(CONFIG_KGDB)		+= dbg_io.o
> > +obj-$(CONFIG_I2C_BOARDINFO)	+= i2c-swarm.o
> > +obj-$(CONFIG_KGDB)		+= dbg_io.o
> > (...)
> > --- linux-2.6.26-rc1-20080505.macro/arch/mips/sibyte/swarm/i2c-swarm.c	1970-01-01 00:00:00.000000000 +0000
> > +++ linux-2.6.26-rc1-20080505/arch/mips/sibyte/swarm/i2c-swarm.c	2008-05-06 23:51:34.000000000 +0000
> 
> i2c-foo.c is consistently used for i2c bus driver themselves so far.
> It's somewhat confusing to see you name platform code that way. It's
> also redundant, given that the file lives in the swarm platform
> directory. May I suggest naming this file just
> arch/mips/sibyte/swarm/i2c.c? Other architectures (cris, arm) are doing
> this already.

Is there any chance CONFIG_I2C_BOARDINFO could become tristate?
If yes, it's problematic if you have multiple modules called i2c.ko.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
