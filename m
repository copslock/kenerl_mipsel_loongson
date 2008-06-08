Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Jun 2008 21:20:53 +0100 (BST)
Received: from wsip-70-184-212-2.om.om.cox.net ([70.184.212.2]:12752 "EHLO
	hachi.dashjr.org") by ftp.linux-mips.org with ESMTP
	id S20026579AbYFHUUv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 8 Jun 2008 21:20:51 +0100
Received: from yokochan.lan (yokochan.lan [IPv6:2002:440d:6de2:0:20d:60ff:fe77:7d85])
	(Authenticated sender: luke-jr)
	by hachi.dashjr.org (Postfix) with ESMTP id 74160961BC8;
	Sun,  8 Jun 2008 20:20:48 +0000 (UTC)
From:	Luke -Jr <luke@dashjr.org>
Organization: -Jr Family
To:	"Kevin D. Kissell" <kevink@mips.com>
Subject: Re: bcm33xx port
Date:	Sun, 8 Jun 2008 15:20:38 -0500
User-Agent: KMail/1.9.9
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org
References: <200806072113.26433.luke@dashjr.org> <200806081357.02601.luke@dashjr.org> <484C38A6.7080503@mips.com>
In-Reply-To: <484C38A6.7080503@mips.com>
PGP-Key-Fingerprint: CE5A D56A 36CC 69FA E7D2 3558 665F C11D D53E 9583
Jabber-ID: luke@dashjr.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200806081520.43090.luke@dashjr.org>
Return-Path: <luke@dashjr.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19437
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luke@dashjr.org
Precedence: bulk
X-list: linux-mips

On Sunday 08 June 2008, Kevin D. Kissell wrote:
> Luke -Jr wrote:
> > On Sunday 08 June 2008, Kevin D. Kissell wrote:
> >> and (b) control being transferred to a block of memory that isn't
> >> actually code, as can happen if exception vectors or global
> >> pointers-to-functions aren't set up correctly, or if the kernel stack is
> >> being corrupted.   When you say "the instruction in question is a store
> >> word", how do you know that?
> >
> > The RI error spits out a bunch of info, including epc which presumably
> > points to the instruction causing the problem: ac85ffc0; this is 'sw
> > a1,-64(a0)'
>
> But unless the processor itself is actually defective, there is no way that
> a  SW instruction can cause an RI exception. Sometimes a kernel crash 
> is so violent that the kernel stack frame cannot be reliably decoded by
> the crash dump code, and this would appear to be one of those cases.

In that case, wouldn't the "kernel stack" appear to be complete nonsense?
Yet the stack in this case is quite logical and consistent. Furthermore, if I 
skip the bzero stuff (by commenting out the call), it will crash shortly 
thereafter when the ELF loader attempts to write to it in another way.
Is it very unlikely that the bcm3345 is simply raising the wrong exception (or 
perhaps Linux is misinterpreting the exception)?

> I find the address of 0xac85ffc0 to be a bit suspicious, myself.  That's
> a kseg1 (non-cacheable identity map) address for physical address
> 0x0c85ffc0, which would be legitimate (though suspicious) if you had
> 256MB of RAM, but the boot log quote you posted earlier suggests
> that you've only got 16M.  Is there really memory of some kind at
> that address?  Are you calling routines in a boot ROM from Linux?

ac85ffc0 is the instruction for 'sw a1,-64(a0)', not an address.
The board has only 8 MB RAM, to the best I can tell from looking up the RAM 
chip (hynix KOREA HY57V641620HG 0229A T-7).

> Debugging Linux kernel crashes is probably not the best way to learn
> the MIPS privileged resource architecture.  I'd strongly recommend
> http://www.amazon.com/See-MIPS-Second-Dominic-Sweetman/dp/0120884216/

Can you recommend any gratis materials to read? I don't have room in my budget 
to spend money on this hobby right now..

Luke
