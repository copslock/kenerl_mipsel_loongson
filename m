Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Feb 2007 10:23:42 +0000 (GMT)
Received: from mail.baslerweb.com ([145.253.187.130]:18882 "EHLO
	mail.baslerweb.com") by ftp.linux-mips.org with ESMTP
	id S20038447AbXBHKXi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Feb 2007 10:23:38 +0000
Received: (from smtpd@127.0.0.1) by mail.baslerweb.com (8.13.4/8.13.4)
	id l18AKSOD021602; Thu, 8 Feb 2007 11:20:28 +0100
Received: from unknown [172.16.20.75] by gateway id /processing/kwEkM5s9; Thu Feb 08 11:20:27 2007
Received: from ahr040s.basler.corp ([172.16.20.40]) by AHR075S.basler.corp with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 8 Feb 2007 11:20:27 +0100
From:	Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Date:	Thu, 8 Feb 2007 11:20:25 +0100
User-Agent: KMail/1.9.5
Cc:	linux-mips@linux-mips.org
References: <200702080157.25432.thomas.koeller@baslerweb.com> <200702080920.12723.eckhardt@satorlaser.com>
In-Reply-To: <200702080920.12723.eckhardt@satorlaser.com>
MIME-Version: 1.0
Message-Id: <200702081120.26026.thomas.koeller@baslerweb.com>
X-OriginalArrivalTime: 08 Feb 2007 10:20:27.0140 (UTC) FILETIME=[C07D4440:01C74B6A]
X-SecurE-Mail-Gateway: Version: 5.00.3.1 (smtpd: 6.53.8.7) Date: 20070208102028Z
Subject: Re: [PATCH] eXcite nand flash driver
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13976
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

On Thursday 08 February 2007 09:20, Ulrich Eckhardt wrote:
> Just some cosmetic notes ...
>
> On Thursday 08 February 2007 01:57, Thomas Koeller wrote:
> > @@ -216,10 +216,26 @@ config MTD_NAND_DISKONCHIP_BBTWRITE
> >  	  Even if you leave this disabled, you can enable BBT writes at module
> >  	  load time (assuming you build diskonchip as a module) with the module
> >  	  parameter "inftl_bbt_write=1".
> > -
> > +
>
> This just inserts whitespace.

No, it actually _removes_ whitspace.

>
> >         tristate "NAND support for OLPC CAFÉ chip"
>
> The accent on the E might cause problems, but I'm not sure.

This has been in there before.

>
> > +#define io_readb(__a__)		__raw_readb((__a__))
> > +#define io_writeb(__v__, __a__)	__raw_writeb((__v__), (__a__))
>
> I would have used an inline function. Also, aren't there functions to use
> IOs already? What's the reason here?
>
> > +/* prefix for debug output */
> > +static const char module_id[] = "excite_nandflash";
>
> I'd have used
>
>   static const char* module_id = "excite_nandflash";
>
> except if you need the sizeof it to capture the length.

Then I'd have used
	static const char * const module_id = "excite_nandflash";

but what is the advantage of doing so?

>
> > +static inline const struct resource *excite_nand_get_resource
> > +    (struct platform_device *d, unsigned long flags, const char
> > *basename){ +	const char fmt[] = "%s_%u";
>
> Here, too, is no need for a local buffer, just use a pointer.
>
> > +/* excite_nand_probe
> > + *
> > + * called by device layer when it finds a device matching
> > + * one our driver can handled. [...]
>
> "... when it finds a device our driver can handle."

Right.

>
> Otherwise I'd say it looks very clean, better than quite some other stuff I
> have seen.
>
> Uli
>

Thanks for your comments!


_______________________________

Thomas Köller, Software Developer

Basler Vision Technologies
An der Strusbek 60-62
22926 Ahrensburg
Germany

Tel. +49 (0) 4102 - 463 390
Fax +49 (0) 4102 - 463 390

mailto:thomas.koeller@baslerweb.com
http://www.baslerweb.com

Vorstand: Dr.-Ing. Dietmar Ley (Vorsitzender) · John P. Jennings · Peter Krumhoff · Aufsichtsratsvorsitzender: Norbert Basler
Basler AG · Amtsgericht Ahrensburg HRB 4090 · Ust-IdNr.: DE 135 098 121 · Steuer-Nr.: 30 292 04497

_______________________________
