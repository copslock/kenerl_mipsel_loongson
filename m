Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jan 2003 11:47:56 +0000 (GMT)
Received: from p508B65B9.dip.t-dialin.net ([IPv6:::ffff:80.139.101.185]:10911
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225345AbTA1Lrz>; Tue, 28 Jan 2003 11:47:55 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h0SBloP27217;
	Tue, 28 Jan 2003 12:47:50 +0100
Date: Tue, 28 Jan 2003 12:47:50 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mike Uhler <uhler@mips.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: unaligned load in branch delay slot
Message-ID: <20030128124750.A25956@linux-mips.org>
References: <20030128033901.A23492@linux-mips.org> <Pine.GSO.4.21.0301281024060.9269-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0301281024060.9269-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Tue, Jan 28, 2003 at 10:30:20AM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1250
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 28, 2003 at 10:30:20AM +0100, Geert Uytterhoeven wrote:

> If it happens, I should get a SIGILL, right?

Right.

Hmm...  If you can't reproduce this anymore I guess we should pull this
patch again?  Despite Mike basically acknowledging that such behaviour
exists I don't feel to well about applying patches for non-reproducable
processor behaviour and would rather prefer to wait until we believe to
know the full details.

?

> > +	set_fs(seg);
> 
> `seg' is never initialized?

Yep ...

> > +	case bcond_op:
> > +	case j_op:
> > +	case jal_op:
> > +	case beq_op:
> > +	case bne_op:
> > +	case blez_op:
> > +	case bgtz_op:
> > +	case beql_op:
> > +	case bnel_op:
> > +	case blezl_op:
> > +	case bgtzl_op:
> > +	case jalx_op:
> > +		return 1;	
> 
> I think you can remove the unconditional jumps, cfr. Mike's comments.

That's one of the points where I felt a bit unsafe about the extend of
the issue so I left the jumps in.  Anyway, why should it make a difference
if an instruction is conditional or not?

> Isn't the Vr4120A core MIPS32?

Vr4120 is MIPS III.

  Ralf
