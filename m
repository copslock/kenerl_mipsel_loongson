Received:  by oss.sgi.com id <S305195AbQDRVvJ>;
	Tue, 18 Apr 2000 14:51:09 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:53287 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305188AbQDRVuu>;
	Tue, 18 Apr 2000 14:50:50 -0700
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA02743; Tue, 18 Apr 2000 14:46:05 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id OAA04324; Tue, 18 Apr 2000 14:50:18 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA97594
	for linux-list;
	Tue, 18 Apr 2000 14:36:09 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA99897
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 18 Apr 2000 14:36:07 -0700 (PDT)
	mail_from (geert@linux-m68k.org)
Received: from styx.cs.kuleuven.ac.be (styx.cs.kuleuven.ac.be [134.58.40.3]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA02606
	for <linux@cthulhu.engr.sgi.com>; Tue, 18 Apr 2000 14:36:05 -0700 (PDT)
	mail_from (geert@linux-m68k.org)
Received: from cassiopeia.home (root@dialup006.cs.kuleuven.ac.be [134.58.47.135])
	by styx.cs.kuleuven.ac.be (8.9.3/8.9.3) with ESMTP id XAA10273;
	Tue, 18 Apr 2000 23:35:20 +0200 (MET DST)
Received: from localhost (geert@localhost)
	by cassiopeia.home (8.9.3/8.9.3/Debian/GNU) with ESMTP id RAA00630;
	Tue, 18 Apr 2000 17:13:48 +0200
X-Authentication-Warning: cassiopeia.home: geert owned process doing -bs
Date:   Tue, 18 Apr 2000 17:13:48 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     Mike Klar <mfklar@ponymail.com>, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr
Subject: Re: Unaligned address handling, and the cause of that login problem
In-Reply-To: <20000417164333.B3123@uni-koblenz.de>
Message-ID: <Pine.LNX.4.10.10004181713250.562-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, 17 Apr 2000, Ralf Baechle wrote:
> I'll put __attribute__ ((aligned(64))) to the structure which will fix this.
                                   ^^
8, I suppose?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
