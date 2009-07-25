Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Jul 2009 23:06:49 +0200 (CEST)
Received: from ogre.sisk.pl ([217.79.144.158]:55467 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492976AbZGYVGn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 25 Jul 2009 23:06:43 +0200
Received: from localhost (localhost.localdomain [127.0.0.1])
	by ogre.sisk.pl (Postfix) with ESMTP id 1C3FD1441EB;
	Sat, 25 Jul 2009 20:18:12 +0200 (CEST)
Received: from ogre.sisk.pl ([127.0.0.1])
 by localhost (ogre.sisk.pl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 22238-03; Sat, 25 Jul 2009 20:17:54 +0200 (CEST)
Received: from tosh.localnet (220-bem-13.acn.waw.pl [82.210.184.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ogre.sisk.pl (Postfix) with ESMTP id 16FDC144A23;
	Sat, 25 Jul 2009 20:17:54 +0200 (CEST)
From:	"Rafael J. Wysocki" <rjw@sisk.pl>
To:	Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH V2] au1xmmc: dev_pm_ops conversion
Date:	Sat, 25 Jul 2009 23:06:56 +0200
User-Agent: KMail/1.11.2 (Linux/2.6.31-rc4-rjw; KDE/4.2.4; x86_64; ; )
Cc:	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Manuel Lauss <manuel.lauss@googlemail.com>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Manuel Lauss <manuel.lauss@gmail.com>,
	Arnaud Faucher <arnaud.faucher@gmail.com>,
	Erik Ekman <erik@kryo.se>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Paul Mundt <lethal@linux-sh.org>
References: <1248275919-3296-1-git-send-email-manuel.lauss@gmail.com> <200907252221.45407.elendil@planet.nl> <200907252238.05296.elendil@planet.nl>
In-Reply-To: <200907252238.05296.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200907252306.57430.rjw@sisk.pl>
X-Virus-Scanned: amavisd-new at ogre.sisk.pl using MkS_Vir for Linux
Return-Path: <rjw@sisk.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23779
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rjw@sisk.pl
Precedence: bulk
X-list: linux-mips

On Saturday 25 July 2009, Frans Pop wrote:
> On Saturday 25 July 2009, you wrote:
> > > I'll fix up the floppy and hp-wmi patches.
> >
> > Note that those are already in mainline, as is pcspkr.
> 
> Here's an overview of commits (that I could find) already in mainline that 
> look to have gotten it wrong:
> 
> 6daa79b3  drivers/serial/sh-sci.c	(Paul Mundt)
> 2dbc8a23  drivers/video/hitfb.c		(Paul Mundt)
> 35db715b  drivers/input/misc/pcspkr.c	(/me)
> 2702403c  drivers/platform/x86/hp-wmi.c	(/me)
> 142a735b  drivers/block/floppy.c	(/me)

Are you sure they're all in mainline?

The last change in mainline floppy.c happened on Jun 30 and I have the last
two (fixed up already) in my linux-next branch.

Best,
Rafael
