Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Sep 2002 03:10:40 +0200 (CEST)
Received: from jeeves.momenco.com ([64.169.228.99]:9479 "EHLO
	host099.momenco.com") by linux-mips.org with ESMTP
	id <S1122977AbSIDBKj>; Wed, 4 Sep 2002 03:10:39 +0200
Received: from beagle (natbox.momenco.com [64.169.228.98])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g841AV602010;
	Tue, 3 Sep 2002 18:10:31 -0700
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Jun Sun" <jsun@mvista.com>
Cc: "Linux-MIPS" <linux-mips@linux-mips.org>
Subject: RE: Interrupt handling....
Date: Tue, 3 Sep 2002 18:10:31 -0700
Message-ID: <NEBBLJGMNKKEEMNLHGAIEEMBCIAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
In-Reply-To: <3D6E87EB.4010000@mvista.com>
Return-Path: <mdharm@momenco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 70
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mdharm@momenco.com
Precedence: bulk
X-list: linux-mips

Okay... I think I've got a problem that isn't covered by the usual
examples.

I'm now trying to implment a second-level interrupt demuxer.  My
exception handler, when it sees a certain bit set in the CP0_CAUSE
register set, attempts to read from the second-level controller.  The
problem is, that code looks like this:

	li	t0, 0xfc000000
	lb	t1, 0xc(t0)

Which, as you can see, attempts to access address 0xfc00000c.  And
then I get:

Unable to handle kernel paging request at virtual address fc00000c,
epc == 801af2ac, ra == 80102eb8
Oops in fault.c::do_page_fault, line 206:

I'm guessing I'm in trouble here.  My instincts tell me the the only
way out of this might be to add a wired TLB entry to make certain I
can always access physical address 0xfc00000c... but I'm hoping there
is a better solution than tying up a TLB entry like that.  After all,
isn't that what ioremap is supposed to do?

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org
> [mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Jun Sun
> Sent: Thursday, August 29, 2002 1:46 PM
> To: Matthew Dharm
> Cc: Linux-MIPS
> Subject: Re: Interrupt handling....
>
>
> Matthew Dharm wrote:
> > I've taken it upon myself to re-write some interrupt
> handling code.
> > It's a mess, and it needs cleaning.
> >
>
> That is usually a right attitude to start ... :=)
>
> >
> > An interrupt handler must be registered with
> set_except_vector(0, ...)
> > which must return a numeric code in the range of
> 0..NR_IRQS -- it can
> > do this in any way it wants, including limited function calls (ie
> > there is a stack in place).
> >
>
> Interrupt is setup throught request_irq()/setup_irq().
> set_except_vector()
> for setting exception handlers, which is different from interrupts.
>
> > The irq_desc array of irq_desc_t structures is where the magic
> > happens.  The value returned by the interrupt handler is
> used as an
> > index into this array to do the dispatch a specific handler.  The
> > 'status' and 'action' fields are pretty much
> self-explanatory.  The
> > 'handler' field seems to point to a set of function
> pointers used for
> > enabling/disabling the IRQ.  But what is 'depth' for?
> Boards seem to
> > set it to either 0 or 1 commonly, but I don't see why.
>
> For nested disabling and enabling of interrupts.
>
> > I also don't
> > see how IRQ sharing is accomplished...
>
> Yes, it is there.  See do_IRQ() and a sub-routine
> handle_event() (or something
> like that)
>
>  > Is this pretty much how it all works?
>
> I have a more detailed description in my porting guide.
>
> http://linux.junsun.net/porting-howto/porting-howto.html#cha
pter-interrupt

Jun
