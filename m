Received:  by oss.sgi.com id <S305208AbQD1S5f>;
	Fri, 28 Apr 2000 11:57:35 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:34926 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305202AbQD1S51>;
	Fri, 28 Apr 2000 11:57:27 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id LAA21361; Fri, 28 Apr 2000 11:52:40 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA55585
	for linux-list;
	Fri, 28 Apr 2000 11:49:20 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA65105;
	Fri, 28 Apr 2000 11:49:07 -0700 (PDT)
	mail_from (geert@linux-m68k.org)
Received: from styx.cs.kuleuven.ac.be (styx.cs.kuleuven.ac.be [134.58.40.3]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA07338; Fri, 28 Apr 2000 11:48:27 -0700 (PDT)
	mail_from (geert@linux-m68k.org)
Received: from cassiopeia.home (root@dialup004.cs.kuleuven.ac.be [134.58.47.133])
	by styx.cs.kuleuven.ac.be (8.9.3/8.9.3) with ESMTP id UAA20325;
	Fri, 28 Apr 2000 20:48:17 +0200 (MET DST)
Received: from localhost (geert@localhost)
	by cassiopeia.home (8.9.3/8.9.3/Debian/GNU) with ESMTP id UAA00921;
	Fri, 28 Apr 2000 20:22:11 +0200
X-Authentication-Warning: cassiopeia.home: geert owned process doing -bs
Date:   Fri, 28 Apr 2000 20:22:11 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Jay Carlson <nop@nop.com>
cc:     Ralf Baechle <ralf@oss.sgi.com>, Andreas Jaeger <aj@suse.de>,
        Jun Sun <jsun@mvista.com>,
        Ulf Carlsson <ulfc@calypso.engr.sgi.com>,
        linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
Subject: Re: failed to compile glibc 2.1.2 - BFD_RELOC_16_PCREL_S2 problem
In-Reply-To: <228c01bfb107$fb22c2f0$0a00000a@decoy>
Message-ID: <Pine.LNX.4.10.10004282020310.454-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, 28 Apr 2000, Jay Carlson wrote:
> 2.0 may still be the better choice on very space-constrained platforms until
> there are good options for reducing the size of 2.2.  I mean, 2.2 is not
> huge, but on devices with 2M non-volatile store *total*, it's an obvious
> target.
> 
> I am not volunteering to work on this (yet), but I suspect that people who
> care intensely about size will have to start digging around in the link
> maps.  H. J. Lu has done some of the work in this direction already.

FYI, on PPC some people are working on kernel size optimization, ranging from
automatically throwing away never used functions and data at link time to
getting rid of all the kernel messages (I heard that's about 150 kB of textual
data).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
