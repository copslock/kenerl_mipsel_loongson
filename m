Received:  by oss.sgi.com id <S305208AbQD1TAF>;
	Fri, 28 Apr 2000 12:00:05 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:56169 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305202AbQD1S7v>; Fri, 28 Apr 2000 11:59:51 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id MAA05787; Fri, 28 Apr 2000 12:04:02 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA66480
	for linux-list;
	Fri, 28 Apr 2000 11:48:27 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA72003
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 28 Apr 2000 11:48:20 -0700 (PDT)
	mail_from (geert@linux-m68k.org)
Received: from styx.cs.kuleuven.ac.be (styx.cs.kuleuven.ac.be [134.58.40.3]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA02814
	for <linux@cthulhu.engr.sgi.com>; Fri, 28 Apr 2000 11:48:08 -0700 (PDT)
	mail_from (geert@linux-m68k.org)
Received: from cassiopeia.home (root@dialup004.cs.kuleuven.ac.be [134.58.47.133])
	by styx.cs.kuleuven.ac.be (8.9.3/8.9.3) with ESMTP id UAA20316;
	Fri, 28 Apr 2000 20:47:52 +0200 (MET DST)
Received: from localhost (geert@localhost)
	by cassiopeia.home (8.9.3/8.9.3/Debian/GNU) with ESMTP id UAA00924;
	Fri, 28 Apr 2000 20:25:04 +0200
X-Authentication-Warning: cassiopeia.home: geert owned process doing -bs
Date:   Fri, 28 Apr 2000 20:25:04 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc:     linux@cthulhu.engr.sgi.com
Subject: Re: Just a little question ..
In-Reply-To: <20000428143455.C25322@lug-owl.de>
Message-ID: <Pine.LNX.4.10.10004282023290.454-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, 28 Apr 2000, Jan-Benedict Glaw wrote:
> Btw, my box has a card added which has transceivers vor glass cables. Does
> anybody know what this is (FDDI or 10MBit ethernet...)?
> Transmitter:	AMP 269011-1, 125MBit/s, @1300nm
> Receiver:	AMP 269011-1, 125MBit/s, @1300nm
> The board is connected on top of the CPU board and labeled with "SILICON
> GRAPHICS INC. ASSY NO. 030-0246-006 REV A  MADE IN U.S.A 1992". Next to
> transmitter/receiver, there's a crystal oscillator with 25MHz. That card also
> has an own "processor", a AMD Am29030, build 1991.

The 125 MBit/s looks like a 100 Mbps signal with 4-to-5 encoding. Since
100-Base FX Ethernet didn't exist in 1992 and ATM runs at 155 Mbps, I guess
it's FDDI.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
