Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g25FDLA27851
	for linux-mips-outgoing; Tue, 5 Mar 2002 07:13:21 -0800
Received: from hlubocky.del.cz (hlubocky.del.cz [212.27.221.67])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g25FDD927847
	for <linux-mips@oss.sgi.com>; Tue, 5 Mar 2002 07:13:14 -0800
Received: from ladis (helo=localhost)
	by hlubocky.del.cz with local-esmtp (Exim 3.12 #1 (Debian))
	id 16iFgM-0006oX-00; Tue, 05 Mar 2002 15:12:46 +0100
Date: Tue, 5 Mar 2002 15:12:46 +0100 (CET)
From: Ladislav Michl <ladislav.michl@hlubocky.del.cz>
To: Andrea Venturi <a.venturi@cineca.it>
cc: linux-mips@oss.sgi.com
Subject: Re: device support on indy WS !?
In-Reply-To: <3C84CD2A.6070901@cineca.it>
Message-ID: <Pine.LNX.4.21.0203051453460.24029-100000@hlubocky.del.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 5 Mar 2002, Andrea Venturi wrote:

> it's a digital audio interface, for some info, see here:
> 
>    http://www.epanorama.net/documents/audio/spdif.html

ah. it is known as AES in SGI world...

> in the indy there is a consumer mini-jack connector; you should be able 
> to link a dolby surround digital amplifier or a dat or similar digital 
> audio device..
> 
> see here:
> 
>    http://www.futuretech.vuurwerk.nl/i2sec3.html
> 
> BTW, on the mainboard, i can see the cs-8411, and there is the 8411.pdf 
> inside the audio.zip doc package

basically, it should be easy to support it (but there is no support,
because i have no such device and therefore don't need it). HAL2 binding
to CS8411 is the same as to CS4216. HAL2 hides all hardware details of
Crystal chips and provides you indirect PIO access.

> >>2. isdn: there is a siemens isac-s chip (BTW i didn't see the hscx 
> >>twin): is it supported now? it should be not to difficult to leverage 
> >>the ia32-isdn hisax (passive) isac driver _if_ the hpc3 delivers the 
> >>irq? what do you think about it?
> >>
> > 
> > there is currenty no support. any documentation available?
> > 
> 
> apart from the hpc3.ps on:
> 
>    ftp://oss.sgi.com/pub/linux/mips/doc/indy/

ISDN glue is connected to IOC chip, but implementation details are 
missing :-( see section 4.6 of ioc.ps

> you should find the isac-s (peb2086) specs here:
> http://www.infineon.com/cgi/ecrm.dll/ecrm/scripts/prod_ov.jsp?oid=13633&cat_oid=-9183
> 
> but i don't know if it's enough.. i mean, if we should know something 
> more on the way the isac-s chip is linked thru the pbus to the hpc3 chip.

that is exactly what i'm not able to figure out...

	ladis
