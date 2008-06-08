Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Jun 2008 19:57:14 +0100 (BST)
Received: from wsip-70-184-212-2.om.om.cox.net ([70.184.212.2]:65463 "EHLO
	hachi.dashjr.org") by ftp.linux-mips.org with ESMTP
	id S20026287AbYFHS5M (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 8 Jun 2008 19:57:12 +0100
Received: from yokochan.lan (yokochan.lan [IPv6:2002:440d:6de2:0:20d:60ff:fe77:7d85])
	(Authenticated sender: luke-jr)
	by hachi.dashjr.org (Postfix) with ESMTP id 32749961BC7;
	Sun,  8 Jun 2008 18:57:09 +0000 (UTC)
From:	Luke -Jr <luke@dashjr.org>
Organization: -Jr Family
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: bcm33xx port
Date:	Sun, 8 Jun 2008 13:56:56 -0500
User-Agent: KMail/1.9.9
Cc:	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org
References: <200806072113.26433.luke@dashjr.org> <200806072332.06460.luke@dashjr.org> <Pine.LNX.4.55.0806081332560.15673@cliff.in.clinika.pl>
In-Reply-To: <Pine.LNX.4.55.0806081332560.15673@cliff.in.clinika.pl>
PGP-Key-Fingerprint: CE5A D56A 36CC 69FA E7D2 3558 665F C11D D53E 9583
Jabber-ID: luke@dashjr.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200806081357.02601.luke@dashjr.org>
Return-Path: <luke@dashjr.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19433
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luke@dashjr.org
Precedence: bulk
X-list: linux-mips

On Sunday 08 June 2008, Maciej W. Rozycki wrote:
> On Sat, 7 Jun 2008, Luke -Jr wrote:
> > VxWorks, including the boot loader, is not CFE as far as I am aware. If
> > you're referring to the "CFEv2" in the log, that appears to be the
> > default of a switch (eg, if Linux doesn't detect anything else).
>
>  That message is not included in the standard kernel -- how can I know it
> is meaningless?  As I wrote CFE is standard Broadcom firmware.

It's not? Guess it came from the bcm63xx patches OpenWrt has that I'm using as 
a base for this... Either way, it seems unlikely something claiming to 
be "VxWorks System Boot" is a standard firmware.

> > The calibration code was crashing, so I set it to a fixed 1 value.
> > Worst case, some code won't delay as long as it wants to, right?
>
>  That's grossly wrong.  If you need to preset it for the time being till
> you debug calibration, then for a MIPS processor assume one instruction
> per clock tick and two instructions per loop -- that may not be entirely
> correct, but is a good approximation.  Otherwise you risk peripheral
> devices are not driven correctly with all sorts of the nasty results.

Meaning this?
	preset_lpj = loops_per_jiffy = 2;

> > >  You have got something seriously broken -- __bzero traps exceptions on
> > > stores for graceful recovery as user addresses may be accessed as is
> > > the case here.  If the reserved instruction exception handler is
> > > reached, then clearly the store instruction is not the immediate cause.
> >
> > What else could it be?
>
>  Well, you've got the system and I have no crystal ball.  You have means
> to debug it.  See how control is passed to the RI exception.  Find which
> of the TLB exceptions happens and how it proceeds.  Etc...

Unfortunately, I don't understand how to "see how control is passed" or 
finding TLB exceptions... Could you point me in the right direction to learn 
about this?

On Sunday 08 June 2008, Kevin D. Kissell wrote:
> The universe of possible failures is large.  The two most likely categories
> are (a) configuring the build for a variant of the architecture (64-bit,
> MIPS32R2) that your hardware doesn't support - this is what Maciej was
> referring to,

CONFIG_CPU_MIPS32_R1=y

> and (b) control being transferred to a block of memory that isn't actually
> code, as can happen if exception vectors or global pointers-to-functions
> aren't set up correctly, or if the kernel stack is being corrupted.   When
> you say "the instruction in question is a store word", how do you know that? 

The RI error spits out a bunch of info, including epc which presumably points 
to the instruction causing the problem: ac85ffc0; this is 'sw a1,-64(a0)'

Luke
