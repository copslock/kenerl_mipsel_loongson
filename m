Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g72HT8Rw009553
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 2 Aug 2002 10:29:08 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g72HT8gB009552
	for linux-mips-outgoing; Fri, 2 Aug 2002 10:29:08 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from rwcrmhc51.attbi.com (rwcrmhc51.attbi.com [204.127.198.38])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g72HT0Rw009542
	for <linux-mips@oss.sgi.com>; Fri, 2 Aug 2002 10:29:00 -0700
Received: from ocean.lucon.org ([12.234.143.38]) by rwcrmhc51.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020802173035.WYPC19356.rwcrmhc51.attbi.com@ocean.lucon.org>;
          Fri, 2 Aug 2002 17:30:35 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id EA21D125D2; Fri,  2 Aug 2002 10:30:34 -0700 (PDT)
Date: Fri, 2 Aug 2002 10:30:34 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Ryan Martindale <ryan@qsicorp.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Today's OSS doesn't work on Malta
Message-ID: <20020802103034.A5075@lucon.org>
References: <20020802100714.A4669@lucon.org> <3D4ACD9D.AB3FC45C@qsicorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D4ACD9D.AB3FC45C@qsicorp.com>; from ryan@qsicorp.com on Fri, Aug 02, 2002 at 11:21:17AM -0700
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Aug 02, 2002 at 11:21:17AM -0700, Ryan Martindale wrote:
> "H. J. Lu" wrote:
> > 
> > The 2.4 kernel from today's OSS doesn't work on Malta. I got
> > 
> > hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63, (U)DMA
> > Partition check:
> >  hda:<1>Unable to handle kernel paging request at virtual address 611c2000,
> > epc4
> > Oops in fault.c::do_page_fault, line 206:
> > $0 : 00000000 1000fc00 00000001 00001000 00001000 00001000 81191000 00000001
> > $8 : 811c0000 81199000 00000001 00008000 00010000 802d1358 00000000 00000080
> > $16: 611c2000 00000001 802d1338 00000000 00000000 00000008 00000000 00000000
> > $24: 0000000a 811ddd91                   8027a000 8027bd10 8009e0d0 801eaa24
> > Hi : 0000004f
> > Lo : df328000
> > epc  : 801eaa98    Not tainted
> > Status: 1000fc03
> > Cause : 0080000c
> > Process swapper (pid: 0, stackpage=8027a000)
> > Stack: 8027bd08 8027bd08 802b5c20 00000000 00001240 802d12c8 802d1338 801eb170
> >        0000000e 00000001 b8000000 802d1338 81198320 802d1338 81198320 802d12c8
> >        0000000e 00000001 801efc14 1000fc00 811dde48 802d1338 811dddd0 802d12c8
> >        0000000e 00000001 801e3ca8 802d12c8 8027bd88 1000fc00 8027bde0 1000fc00
> >        00000000 802d1338 81198320 801e406c 1000fc00 802d12c8 801e93e4 00000000
> >        00000003 ...
> > Call Trace: [<801eb170>] [<801efc14>] [<801e3ca8>] [<801e406c>] [<801e93e4>]
> > [<]
> >  [<801db1b4>] [<801e44ec>] [<801e3008>] [<8012ea04>] [<801e9290>] [<801e4be8>]
> >  [<80109690>] [<80109970>] [<8010ae3c>] [<80254554>] [<80254d10>] [<80254860>]
> >  [<801089a4>] [<80102e40>] [<80102e9c>] [<80102e44>] [<8010042c>] [<80255800>]
> > 
> > Code: 54e00001  00a02021  3083ffff <ae060000> 00a42823  14600008  26100004  263
> > Kernel panic: Aiee, killing interrupt handler!
> > In interrupt handler - not syncing
> 
> Looks like what I was dealing with - check process.c patch I submitted a
> couple of days ago (gp doesn't get set to the appropriate type of
> structure).
> 

I couldn't find your process.c patch for 2.4 kernel. The only one I
saw is for 2.5.


H.J.
