Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7KCRbEC025409
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 20 Aug 2002 05:27:37 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7KCRbiB025408
	for linux-mips-outgoing; Tue, 20 Aug 2002 05:27:37 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft16-f39.dialo.tiscali.de [62.246.16.39])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7KCRSEC025399
	for <linux-mips@oss.sgi.com>; Tue, 20 Aug 2002 05:27:30 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g7JDgGG21374;
	Mon, 19 Aug 2002 15:42:16 +0200
Date: Mon, 19 Aug 2002 15:42:15 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@oss.sgi.com
Subject: Re: CVS Update@oss.sgi.com: linux
Message-ID: <20020819154215.B14266@linux-mips.org>
References: <200208130138.g7D1cYk3010974@oss.sgi.com> <Pine.GSO.3.96.1020819141201.14441C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020819141201.14441C-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Aug 19, 2002 at 02:35:19PM +0200
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Aug 19, 2002 at 02:35:19PM +0200, Maciej W. Rozycki wrote:

> > Modified files:
> > 	arch/mips      : config-shared.in defconfig defconfig-decstation 
> > 	                 defconfig-ip22 defconfig-nino defconfig-osprey 
> > 	                 defconfig-sb1250-swarm defconfig-sead 
> > 	arch/mips64    : defconfig-ip22 defconfig-sb1250-swarm 
> > 	                 defconfig-sead 
> > 
> > Log message:
> > 	Make CONFIG_IDE selectable independant of the bus type.
> 
>  Hmm, what's the intent of the change?  IDE, or more properly ATA, was
> originally an ISA-only device and is still only available as ISA-style
> implementations, AFAIK.  I'd prefer it to be available only if any of
> CONFIG_ISA, CONFIG_EISA, CONFIG_PCI (unsure about CONFIG_MCA) is set.
> 
>  That said, the place for such decisions seems to be inappropriate
> currently.  It'd be much more elegant just to source all relevant drivers,
> net, etc. Config.in scripts unconditionally and make global enable/disable
> decisions at the top of the relevant script, like e.g. 
> drivers/message/i2o/Config.in already does. 

Even before the changes Alan mentioned we had a bunch of machines like the
SWARM which had PCI but it's PIO IDE adapter wasn't living on the PCI bus.
So disabling PCI on that machine would disable IDE also.  Other machines
had IDE on PCMCIA with the PCMCIA bridge not hanging off an (E)ISA or PCI
bridge.  Basically I could have changed that if statement into an
increasingly obscure and braindamagedly complex if statement.

  Ralf
