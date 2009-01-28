Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2009 09:45:55 +0000 (GMT)
Received: from fnoeppeil36.netpark.at ([217.175.205.164]:58504 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S21366296AbZA1Jpx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Jan 2009 09:45:53 +0000
Received: (qmail 25517 invoked by uid 1000); 28 Jan 2009 10:45:52 +0100
Date:	Wed, 28 Jan 2009 10:45:52 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Frank Neuber <frank.neuber@kernelport.de>
Cc:	Florian Fainelli <florian@openwrt.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: AU1550 Kernel bug detected[#1]  clockevents_register_device
Message-ID: <20090128094552.GA25480@roarinelk.homelinux.net>
References: <1233045842.28527.459.camel@t60p> <20090127091107.GA15890@roarinelk.homelinux.net> <1233051181.28527.485.camel@t60p> <20090127121123.GA17132@roarinelk.homelinux.net> <1233060160.28527.497.camel@t60p> <1233134374.28527.524.camel@t60p> <20090128093846.GA25402@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090128093846.GA25402@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21851
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

> > --- a/include/asm-mips/mach-au1x00/au1000.h
> > +++ b/include/asm-mips/mach-au1x00/au1000.h
> > @@ -1679,12 +1679,21 @@ enum soc_au1200_ints {
> >  #define Au1500_PCI_MEM_START      0x440000000ULL
> >  #define Au1500_PCI_MEM_END        0x44FFFFFFFULL
> >  
> > +#if 1
> > +#define PCI_IO_START    0x00001000
> > +#define PCI_IO_END      0x000FFFFF
> > +#define PCI_MEM_START   0x40000000
> > +#define PCI_MEM_END     0x4FFFFFFF
> > +#define PCI_FIRST_DEVFN (0 << 3)
> > +#define PCI_LAST_DEVFN  (19 << 3)

The current -git sources already have this change.  How come yours
don't? (it was changed before 2.6.24).

Best regards,
	Manuel Lauss
