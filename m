Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2009 17:30:42 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:14771 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20024511AbZCaQak (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2009 17:30:40 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n2VGJ6la030019;
	Tue, 31 Mar 2009 18:19:07 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n2VGFoGL029549;
	Tue, 31 Mar 2009 18:15:50 +0200
Date:	Tue, 31 Mar 2009 18:15:50 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	"Kevin D. Kissell" <kevink@paralogos.com>,
	Linux MIPS org <linux-mips@linux-mips.org>
Subject: Re: PATCH for SMTC: Fix Name Collision in _clockevent_init
	functions
Message-ID: <20090331161550.GA24154@linux-mips.org>
References: <49D1FA28.4030308@paralogos.com> <20090331131251.GC3804@linux-mips.org> <20090331153213.GA11043@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090331153213.GA11043@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22204
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 31, 2009 at 05:32:13PM +0200, Manuel Lauss wrote:
> From: Manuel Lauss <mano@roarinelk.homelinux.net>
> Date: Tue, 31 Mar 2009 17:32:13 +0200
> To: Ralf Baechle <ralf@linux-mips.org>,
> 	"Kevin D. Kissell" <kevink@paralogos.com>
> Cc: Linux MIPS org <linux-mips@linux-mips.org>
> Subject: Re: PATCH for SMTC: Fix Name Collision in _clockevent_init
> 	functions
> Content-Type: text/plain; charset=us-ascii
> 
> Hi Kevin, Ralf,
> 
> On Tue, Mar 31, 2009 at 03:12:51PM +0200, Ralf Baechle wrote:
> > On Tue, Mar 31, 2009 at 01:10:32PM +0200, Kevin D. Kissell wrote:
> > > From: "Kevin D. Kissell" <kevink@paralogos.com>
> > > Date: Tue, 31 Mar 2009 13:10:32 +0200
> > > To: Linux MIPS org <linux-mips@linux-mips.org>
> > > Subject: PATCH for SMTC: Fix Name Collision in _clockevent_init functions
> > > Content-Type: multipart/mixed;
> > > 	boundary="------------070601030706030107070108"
> > > 
> > > Commit 779e7d41ad004946603da139da99ba775f74cb1c created a name collision
> > > in SMTC builds.  The attached patch corrects this in a a
> 
> Oh, I'm sorry.
> 
> 
> > > not-too-terribly-ugly manner.  Note that the SMTC case has to come
> > > first, because CEVT_R4K will also be true.
> 
> I'm curious: Is it required to use the CP0 counter for SMTC kernels, or
> could the SMTC-specific parts somehow be abstracted out and called by
> other timer backends? (for a hypothetical SMTC-enhanced Alchemy core)

The very special and odd SMTC time and interrupt code is required due
to the special architecture of the processor.  A MIPS MT-enabled core
can have multiple VPEs and TCs.  A TC is a thread context, basically
just a register set and the bare minimum set of cp0 that is needed to
be able to allow clever software to pretend a TC is a processor to
applications.  TCs are associated with VPEs.  VPEs duplicate many more cp0
resources, including for example all TLB, interrupt-related registers - and
count/compare.

This means for the VSMP kernel model (think of it as fairly similar to
Intel's hyperthreading) each VPE (and VPEs are equivalent to processors
as visible to Linux) has its own count/compare register.  World is nice
:imple and sane, the birds are singing and the skies are blue:

    TC 0 --  VPE 0    TC 1 --  VPE 1

SMTC shows each TC into a processor.  by the hardware architecture each
TC is associated with a VPE.  For example on a 2 VPE, 5 TC configuration
which is fairly common:

    TC 0              TC 4
          \                 \
    TC 1 --  VPE 0    TC 5 --  VPE 1
          /
    TC 2

The count compare registers are part of the VPEs, that is count/compare
suddenly have become shared resources.  More complicated, the cp0 status
and cause registers which also are cp0 resources are also per VPE and
interrupts are delivered to a random (let's skip the details) TC of a
VPE.  To allow reliable delivery of timer interrupts to a processor
the SMTC kernel has to do a few fairly ingeniously crazy software tricks
which are complicated enough that we keep that code separated in its
own cevt-smtc.c file.

Any other timer would suffer from similar issues.  Interrupts would be
delivered to a random TC associated with the VPE that is target of the
interrupt and software might have to forward it.  Also resource sharing
might require some sort method to deal with the situation where there
are fewer timers available than TCs.

  Ralf
