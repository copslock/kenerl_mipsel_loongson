Received:  by oss.sgi.com id <S305208AbQD1Tjp>;
	Fri, 28 Apr 2000 12:39:45 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:33917 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305202AbQD1Tj3>;
	Fri, 28 Apr 2000 12:39:29 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id MAA28454; Fri, 28 Apr 2000 12:34:42 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA81749
	for linux-list;
	Fri, 28 Apr 2000 12:30:51 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA66689
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 28 Apr 2000 12:30:28 -0700 (PDT)
	mail_from (nick@ns.snowman.net)
From:   nick@ns.snowman.net
Received: from ns.snowman.net (ns.snowman.net [63.80.4.34]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA00303
	for <linux@cthulhu.engr.sgi.com>; Fri, 28 Apr 2000 12:30:11 -0700 (PDT)
	mail_from (nick@ns.snowman.net)
Received: from localhost (nick@localhost)
	by ns.snowman.net (8.9.1a/8.9.0) with ESMTP id PAA29832;
	Fri, 28 Apr 2000 15:40:05 -0400
Date:   Fri, 28 Apr 2000 15:40:05 -0400 (EDT)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux@cthulhu.engr.sgi.com
Subject: Re: Just a little question ..
In-Reply-To: <Pine.LNX.4.10.10004282023290.454-100000@cassiopeia.home>
Message-ID: <Pine.LNX.4.05.10004281539310.29506-100000@ns.snowman.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

FDDI sounds right.  What does the physical connector look like?  I think
FDDI does 4-5 encoding?
	Nick

On Fri, 28 Apr 2000, Geert Uytterhoeven wrote:

> On Fri, 28 Apr 2000, Jan-Benedict Glaw wrote:
> > Btw, my box has a card added which has transceivers vor glass cables. Does
> > anybody know what this is (FDDI or 10MBit ethernet...)?
> > Transmitter:	AMP 269011-1, 125MBit/s, @1300nm
> > Receiver:	AMP 269011-1, 125MBit/s, @1300nm
> > The board is connected on top of the CPU board and labeled with "SILICON
> > GRAPHICS INC. ASSY NO. 030-0246-006 REV A  MADE IN U.S.A 1992". Next to
> > transmitter/receiver, there's a crystal oscillator with 25MHz. That card also
> > has an own "processor", a AMD Am29030, build 1991.
> 
> The 125 MBit/s looks like a 100 Mbps signal with 4-to-5 encoding. Since
> 100-Base FX Ethernet didn't exist in 1992 and ATM runs at 155 Mbps, I guess
> it's FDDI.
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> 
