Received:  by oss.sgi.com id <S305174AbQDNNc3>;
	Fri, 14 Apr 2000 06:32:29 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:25182 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305159AbQDNNcU>;
	Fri, 14 Apr 2000 06:32:20 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id GAA24884; Fri, 14 Apr 2000 06:27:36 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA60175
	for linux-list;
	Fri, 14 Apr 2000 06:07:52 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA57178
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 14 Apr 2000 06:07:49 -0700 (PDT)
	mail_from (geert@linux-m68k.org)
Received: from styx.cs.kuleuven.ac.be (styx.cs.kuleuven.ac.be [134.58.40.3]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA08466
	for <linux@cthulhu.engr.sgi.com>; Fri, 14 Apr 2000 06:07:48 -0700 (PDT)
	mail_from (geert@linux-m68k.org)
Received: from cassiopeia.home (root@dialup006.cs.kuleuven.ac.be [134.58.47.135])
	by styx.cs.kuleuven.ac.be (8.9.3/8.9.3) with ESMTP id PAA09979;
	Fri, 14 Apr 2000 15:07:20 +0200 (MET DST)
Received: from localhost (geert@localhost)
	by cassiopeia.home (8.9.3/8.9.3/Debian/GNU) with ESMTP id OAA00471;
	Fri, 14 Apr 2000 14:48:42 +0200
X-Authentication-Warning: cassiopeia.home: geert owned process doing -bs
Date:   Fri, 14 Apr 2000 14:48:42 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Florian Lohoff <flo@rfc822.org>
cc:     linux@cthulhu.engr.sgi.com, linux-kernel@vger.rutgers.edu
Subject: Re: sgiserial.c / rs_init invoke ?
In-Reply-To: <20000412201829.A451@paradigm.rfc822.org>
Message-ID: <Pine.LNX.4.10.10004141447350.433-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, 12 Apr 2000, Florian Lohoff wrote:
> i am currently digging deeper into sgiserial.c and friends.
> My problem right now is that i dont understand when and how the
> rs_init should and will be called - Currently i have an
> __initcall(rs_init) in arch/mips/sgi/kernel/setup.c which is definitly
> wrong - But should this be invoked - I cant find how i386 does this
> (Could somebody enlighten me what module_init(rs_init) in
> drivers/char/serial.c does ?)

module_init(rs_init) == __initcall(rs_init)

Both add rs_init() to the list (read: array) of functions to be called during
initialization.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
