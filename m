Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g75BHxRw005148
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 5 Aug 2002 04:17:59 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g75BHxcg005147
	for linux-mips-outgoing; Mon, 5 Aug 2002 04:17:59 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g75BHoRw005135;
	Mon, 5 Aug 2002 04:17:51 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA21395;
	Mon, 5 Aug 2002 13:20:12 +0200 (MET DST)
Date: Mon, 5 Aug 2002 13:20:12 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@oss.sgi.com
Subject: Re: [patch] 2.4: Revert interface removal
In-Reply-To: <20020805124154.B6365@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1020805131033.18894L-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 5 Aug 2002, Ralf Baechle wrote:

> Sorry for simply removing the structure, that was an accident.  The
> question why the use of struct mmu_sglist still hasn't been replaced by
> newer interfaces stays ...

 Because the structure wasn't removed at the 2.3 time?  M68k still keeps
it as well and their sun3x_esp.c driver uses it (I think dec_esp.c was
derived from that one). 

 For 2.5, I'll work on adding an appropriate DMA addressing layer for the
TURBOchannel bus and the I/O ASIC and fixing the driver, of course. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
