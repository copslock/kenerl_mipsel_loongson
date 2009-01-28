Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2009 10:38:49 +0000 (GMT)
Received: from mail.bugwerft.de ([212.112.241.193]:10154 "EHLO
	mail.bugwerft.de") by ftp.linux-mips.org with ESMTP
	id S21366309AbZA1Kif (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Jan 2009 10:38:35 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.bugwerft.de (Postfix) with ESMTP id 8CFB749400C;
	Wed, 28 Jan 2009 11:38:29 +0100 (CET)
Received: from mail.bugwerft.de ([127.0.0.1])
	by localhost (mail.bugwerft.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b2QltD7MR7XO; Wed, 28 Jan 2009 11:38:29 +0100 (CET)
Received: from [10.1.1.26] (ip-77-25-15-184.web.vodafone.de [77.25.15.184])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bugwerft.de (Postfix) with ESMTP id 1A59E49400B;
	Wed, 28 Jan 2009 11:38:27 +0100 (CET)
Subject: Re: AU1550 Kernel bug detected[#1]  clockevents_register_device
From:	Frank Neuber <frank.neuber@kernelport.de>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Florian Fainelli <florian@openwrt.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
In-Reply-To: <20090128094552.GA25480@roarinelk.homelinux.net>
References: <1233045842.28527.459.camel@t60p>
	 <20090127091107.GA15890@roarinelk.homelinux.net>
	 <1233051181.28527.485.camel@t60p>
	 <20090127121123.GA17132@roarinelk.homelinux.net>
	 <1233060160.28527.497.camel@t60p> <1233134374.28527.524.camel@t60p>
	 <20090128093846.GA25402@roarinelk.homelinux.net>
	 <20090128094552.GA25480@roarinelk.homelinux.net>
Content-Type: text/plain
Date:	Wed, 28 Jan 2009 11:38:25 +0100
Message-Id: <1233139105.28527.547.camel@t60p>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.1 
Content-Transfer-Encoding: 7bit
Return-Path: <frank.neuber@kernelport.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: frank.neuber@kernelport.de
Precedence: bulk
X-list: linux-mips


Am Mittwoch, den 28.01.2009, 10:45 +0100 schrieb Manuel Lauss:
> > > --- a/include/asm-mips/mach-au1x00/au1000.h
> > > +++ b/include/asm-mips/mach-au1x00/au1000.h
> > > @@ -1679,12 +1679,21 @@ enum soc_au1200_ints {
> > >  #define Au1500_PCI_MEM_START      0x440000000ULL
> > >  #define Au1500_PCI_MEM_END        0x44FFFFFFFULL
> > >  
> > > +#if 1
> > > +#define PCI_IO_START    0x00001000
> > > +#define PCI_IO_END      0x000FFFFF
> > > +#define PCI_MEM_START   0x40000000
> > > +#define PCI_MEM_END     0x4FFFFFFF
> > > +#define PCI_FIRST_DEVFN (0 << 3)
> > > +#define PCI_LAST_DEVFN  (19 << 3)
> 
> The current -git sources already have this change.  How come yours
> don't? (it was changed before 2.6.24).
Because I try to track down the PCI resource management problem in
2.6.24 I want to test older versions which does not have this problem
(like 2.6.16) or now after enabeling CONFIG_64BIT_PHYS_ADDR 2.6.19.

For next I will look at 2.6.23 what the problem is with the recource
conflict  ....

Regards,
 Frank
