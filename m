Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g15LsHe15818
	for linux-mips-outgoing; Tue, 5 Feb 2002 13:54:17 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g15Ls9A15815
	for <linux-mips@oss.sgi.com>; Tue, 5 Feb 2002 13:54:09 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 09DAF125C8; Tue,  5 Feb 2002 13:54:08 -0800 (PST)
Date: Tue, 5 Feb 2002 13:54:07 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Dominic Sweetman <dom@algor.co.uk>,
   GNU C Library <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com,
   binutils@sources.redhat.com
Subject: Re: PATCH: Fix ll/sc for mips (take 3)
Message-ID: <20020205135407.A8309@lucon.org>
References: <1012676003.1563.6.camel@xyzzy.stargate.net> <20020202120354.A1522@lucon.org> <mailpost.1012680250.7159@news-sj1-1> <yov5ofj65elj.fsf@broadcom.com> <15454.22661.855423.532827@gladsmuir.algor.co.uk> <20020204083115.C13384@lucon.org> <15454.47823.837119.847975@gladsmuir.algor.co.uk> <20020204172857.A22337@lucon.org> <20020204215804.A2095@nevyn.them.org> <20020205113017.A6144@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020205113017.A6144@lucon.org>; from hjl@lucon.org on Tue, Feb 05, 2002 at 11:30:17AM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Feb 05, 2002 at 11:30:17AM -0800, H . J . Lu wrote:
> On Mon, Feb 04, 2002 at 09:58:04PM -0500, Daniel Jacobowitz wrote:
> > On Mon, Feb 04, 2002 at 05:28:57PM -0800, H . J . Lu wrote:
> > > On Mon, Feb 04, 2002 at 04:46:07PM +0000, Dominic Sweetman wrote:
> > > > 
> > > > H . J . Lu (hjl@lucon.org) writes:
> > > > 
> > > > > I can change glibc not to use branch-likely without using nop. But it
> > > > > may require one or two instructions outside of the loop. Should I do
> > > > > it given what we know now?
> > > > 
> > > > I would not recommend using "branch likely" in assembler coding, if
> > > > that's what you're asking.
> > > > 
> > > 
> > > Here is a patch to remove branch likely. But I couldn't find a way
> > > not to fill the delay slot with nop. BTW, is that safe to remove
> > > ".set noreorder"?
> > 
> > You mean, if there is nothing which can be put there?  Yes, it's safe.
> > 
> 
> Here is a new patch. I removed the extra "ll" in the delay slot.
> 

This patch is wrong. The assmebler turns that into

0x2ab0f724 <__pthread_alt_lock+212>:    ll      v1,0(s1)
0x2ab0f728 <__pthread_alt_lock+216>:	bne v1,s0,0x2ab0f744 <__pthread_alt_lock+244>
0x2ab0f72c <__pthread_alt_lock+220>:    nop
0x2ab0f730 <__pthread_alt_lock+224>:    move    a1,zero
0x2ab0f734 <__pthread_alt_lock+228>:    move    a1,v0
0x2ab0f738 <__pthread_alt_lock+232>:    sc      a1,0(s1)
0x2ab0f73c <__pthread_alt_lock+236>:	beqz        a1,0x2ab0f724 <__pthread_alt_lock+212>
0x2ab0f740 <__pthread_alt_lock+240>:    nop

If I do

  __asm__ __volatile__
    ("/* Inline compare & swap */\n"
     "1:\n\t"
     "ll        %1,%5\n\t"
     "move      %0,$0\n\t"
     "bne       %1,%3,2f\n\t"
     "move      %0,%4\n\t"
     "sc        %0,%2\n\t"
     "beqz      %0,1b\n\t"
     "2:\n\t"
     "/* End compare & swap */"
     : "=&r" (ret), "=&r" (temp), "=m" (*p)
     : "r" (oldval), "r" (newval), "m" (*p)
     : "memory");

The assembler will do

0xd724 <__pthread_alt_lock+212>:        ll      v1,0(s1)
0xd728 <__pthread_alt_lock+216>:        move    a1,zero
0xd72c <__pthread_alt_lock+220>:	bne v1,s0,0xd744 <__pthread_alt_lock+244>
0xd730 <__pthread_alt_lock+224>:        nop
0xd734 <__pthread_alt_lock+228>:        move    a1,v0
0xd738 <__pthread_alt_lock+232>:        sc      a1,0(s1)
0xd73c <__pthread_alt_lock+236>:	beqz        a1,0xd724 <__pthread_alt_lock+212>
0xd740 <__pthread_alt_lock+240>:        nop

There is an extra "nop" in the delay slot. I don't think gas is smart
enough to fill the delay slot. I will put back those ".set noredor".


H.J.
