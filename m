Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Feb 2004 00:11:40 +0000 (GMT)
Received: from web9503.mail.yahoo.com ([IPv6:::ffff:216.136.129.133]:47499
	"HELO web9503.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225324AbUBSALj>; Thu, 19 Feb 2004 00:11:39 +0000
Message-ID: <20040219001132.30180.qmail@web9503.mail.yahoo.com>
Received: from [128.107.253.38] by web9503.mail.yahoo.com via HTTP; Wed, 18 Feb 2004 16:11:32 PST
Date: Wed, 18 Feb 2004 16:11:32 -0800 (PST)
From: Indigodfw <indigodfw@yahoo.com>
Subject: Re: question about memory constraint in atomic_add
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
In-Reply-To: <20040218134501.GA24330@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <indigodfw@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4381
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: indigodfw@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi Ralf

Thanks for response, but I did not understand your
point. Please read inline.

--- Ralf Baechle <ralf@linux-mips.org> wrote:
> On Sat, Feb 14, 2004 at 07:11:52AM -0800, Indigodfw
> wrote:
> 
> > 2. Result of (C expression) should go into %xyz
> > register 
> > So v->counter goes into %1, IOW ll from an int!
> > 
> > Does not make sense to me.
> > Why does it work, What am I missing?
> 
> > I mean in general what is the expression for a m
> > constraint ptr (because I want ptr to be in
> regiser)
> > or *ptr (because I wanna tell compiler that *ptr
> is
> > what gets changed) 
> 
> "m" gives you *something* suitable to address a
> memory object; that isn't
> necessarily a memory address.  On MIPS it can't even
> be just an address
> in a register because "m" constraints are used with
> loads and stores and
> those only accept the offset(reg) addressing mode. 
> If you want an address
> use something like "r" (&v->counter), then lw
> reg,(%xxx).

Well, is not that what we want?
That is, we want to load (using ll) from &v->counter.

Should not the code have been
ll     %0, 0(%1) 
where %1 is "=m" (&v->counter)

The way I interpret it is:
a) %1 will contain address of v->counter
b) We would do ll (load with reservation/lock) from %1
which is &v->counter (and not from v->counter)
c)We want to tell the compiler that &v->counter is
output constraint and it may be modified. (Since
compiler does not look inside asm). 
But I fear that with the syntax "=m" (&v->counter) we
are informing the compiler that this ptr itself may be
modified instead of its contents. 

Thanks


__________________________________
Do you Yahoo!?
Yahoo! Mail SpamGuard - Read only the mail you want.
http://antispam.yahoo.com/tools
