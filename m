Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jan 2003 12:27:48 +0000 (GMT)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:17887 "EHLO
	mail.sonytel.be") by linux-mips.org with ESMTP id <S8225349AbTA1M1r>;
	Tue, 28 Jan 2003 12:27:47 +0000
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id NAA14383;
	Tue, 28 Jan 2003 13:27:41 +0100 (MET)
Date: Tue, 28 Jan 2003 13:27:42 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Mike Uhler <uhler@mips.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: unaligned load in branch delay slot
In-Reply-To: <20030128124750.A25956@linux-mips.org>
Message-ID: <Pine.GSO.4.21.0301281315380.9269-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1251
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 28 Jan 2003, Ralf Baechle wrote:
> On Tue, Jan 28, 2003 at 10:30:20AM +0100, Geert Uytterhoeven wrote:
> > If it happens, I should get a SIGILL, right?
> 
> Right.
> 
> Hmm...  If you can't reproduce this anymore I guess we should pull this
> patch again?  Despite Mike basically acknowledging that such behaviour

I cannot reproduce it in user space. I can still reproduce it in kernel space
when an incoming TCP connection is accepted:

| 8034d568 <tcp_v4_conn_request>:
| 8034d568:       27bdfe20        addiu   sp,sp,-480
| 8034d56c:       afb601d8        sw      s6,472(sp)
| 8034d570:       afb301cc        sw      s3,460(sp)
| 8034d574:       afb101c4        sw      s1,452(sp)
| 8034d578:       afbf01dc        sw      ra,476(sp)
| 8034d57c:       afb501d4        sw      s5,468(sp)
| 8034d580:       afb401d0        sw      s4,464(sp)
| 8034d584:       afb201c8        sw      s2,456(sp)
| 8034d588:       afb001c0        sw      s0,448(sp)
| 8034d58c:       00a08821        move    s1,a1
| 8034d590:       8ca50020        lw      a1,32(a1)
| 8034d594:       8e260028        lw      a2,40(s1)
| 8034d598:       8e320044        lw      s2,68(s1)
| 8034d59c:       8ca2000c        lw      v0,12(a1)
| 8034d5a0:       00809821        move    s3,a0
| 8034d5a4:       0000b021        move    s6,zero
| 8034d5a8:       afa201b8        sw      v0,440(sp)
| 8034d5ac:       8cc30064        lw      v1,100(a2)
| 8034d5b0:       3c023000        lui     v0,0x3000
| 8034d5b4:       00621824        and     v1,v1,v0
| 8034d5b8:       14600012        bnez    v1,8034d604 <tcp_v4_conn_request+0x9c>
| 8034d5bc:       8cb50010        lw      s5,16(a1)
                                  ^^^^^^^^^^^^^^^^^
This load may cause an unaligned address exception. Sometimes pc (after
correction based on the branch delay flag) points to 8034d5bc, sometimes it
points to 8034d5b8. In the latter case I found out that the branch was not
taken.

> exists I don't feel to well about applying patches for non-reproducable
> processor behaviour and would rather prefer to wait until we believe to
> know the full details.
> 
> > > +	case bcond_op:
> > > +	case j_op:
> > > +	case jal_op:
> > > +	case beq_op:
> > > +	case bne_op:
> > > +	case blez_op:
> > > +	case bgtz_op:
> > > +	case beql_op:
> > > +	case bnel_op:
> > > +	case blezl_op:
> > > +	case bgtzl_op:
> > > +	case jalx_op:
> > > +		return 1;	
> > 
> > I think you can remove the unconditional jumps, cfr. Mike's comments.
> 
> That's one of the points where I felt a bit unsafe about the extend of
> the issue so I left the jumps in.  Anyway, why should it make a difference
> if an instruction is conditional or not?

Jumps are always taken, and the behavior I saw happened when the branch was
untaken (cfr. above).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
