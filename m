Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g75BqbRw005668
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 5 Aug 2002 04:52:37 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g75BqbU4005667
	for linux-mips-outgoing; Mon, 5 Aug 2002 04:52:37 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g75BqRRw005657;
	Mon, 5 Aug 2002 04:52:27 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g75BrdXb006428;
	Mon, 5 Aug 2002 04:53:39 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id EAA04826;
	Mon, 5 Aug 2002 04:53:40 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g75Brdb18990;
	Mon, 5 Aug 2002 13:53:39 +0200 (MEST)
Message-ID: <3D4E6743.58776F67@mips.com>
Date: Mon, 05 Aug 2002 13:53:39 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   linux-mips@oss.sgi.com
Subject: Re: [patch] 2.4: Revert interface removal
References: <Pine.GSO.3.96.1020805105624.18894C-100000@delta.ds2.pg.gda.pl> <20020805124154.B6365@dea.linux-mips.net> <3D4E5BFE.595DA175@mips.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf, could we please revert the latest changes to include/asm-mips/scatterlist.h
and include/asm-mips/pci.h

/Carsten


Carsten Langgaard wrote:

> Changing the scatterlist and the pci functions seems to break things in the IDE
> interface.
>
> /Carsten
>
> Ralf Baechle wrote:
>
> > On Mon, Aug 05, 2002 at 11:05:40AM +0200, Maciej W. Rozycki wrote:
> >
> > >  A recent change to include/asm-mips/scatterlist.h broke
> > > drivers/scsi/dec_esp.c.  Since 2.4.19 is not the proper version to remove
> > > interfaces, I'm going to check in the following patch to the 2.4 branch to
> > > revert the change (with a slightly sanitized type for the dvma_address
> > > member).
> > >
> > >  Any objections?
> >
> > Sorry for simply removing the structure, that was an accident.  The
> > question why the use of struct mmu_sglist still hasn't been replaced by
> > newer interfaces stays ...
> >
> > So please go ahead and commit your patch.
> >
> >   Ralf
>
> --
> _    _ ____  ___   Carsten Langgaard  Mailto:carstenl@mips.com
> |\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
> | \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
>   TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
>                    Denmark            http://www.mips.com

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
