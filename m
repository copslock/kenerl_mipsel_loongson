Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g16JHwO29161
	for linux-mips-outgoing; Wed, 6 Feb 2002 11:17:58 -0800
Received: from dea.linux-mips.net (a1as20-p202.stg.tli.de [195.252.194.202])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g16JHmA29157
	for <linux-mips@oss.sgi.com>; Wed, 6 Feb 2002 11:17:49 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g16AWxB15749;
	Wed, 6 Feb 2002 11:32:59 +0100
Date: Wed, 6 Feb 2002 11:32:59 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: Dominic Sweetman <dom@algor.co.uk>,
   GNU C Library <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com,
   binutils@sources.redhat.com
Subject: Re: PATCH: Fix ll/sc for mips (take 3)
Message-ID: <20020206113259.A15431@dea.linux-mips.net>
References: <20020202120354.A1522@lucon.org> <mailpost.1012680250.7159@news-sj1-1> <yov5ofj65elj.fsf@broadcom.com> <15454.22661.855423.532827@gladsmuir.algor.co.uk> <20020204083115.C13384@lucon.org> <15454.47823.837119.847975@gladsmuir.algor.co.uk> <20020204172857.A22337@lucon.org> <20020204215804.A2095@nevyn.them.org> <20020205113017.A6144@lucon.org> <20020205135407.A8309@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020205135407.A8309@lucon.org>; from hjl@lucon.org on Tue, Feb 05, 2002 at 01:54:07PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Feb 05, 2002 at 01:54:07PM -0800, H . J . Lu wrote:

>   __asm__ __volatile__
>     ("/* Inline compare & swap */\n"
>      "1:\n\t"
>      "ll        %1,%5\n\t"
>      "move      %0,$0\n\t"
>      "bne       %1,%3,2f\n\t"
>      "move      %0,%4\n\t"
>      "sc        %0,%2\n\t"
>      "beqz      %0,1b\n\t"
>      "2:\n\t"
>      "/* End compare & swap */"
>      : "=&r" (ret), "=&r" (temp), "=m" (*p)
>      : "r" (oldval), "r" (newval), "m" (*p)
>      : "memory");
> 
> The assembler will do
> 
> 0xd724 <__pthread_alt_lock+212>:        ll      v1,0(s1)
> 0xd728 <__pthread_alt_lock+216>:        move    a1,zero
> 0xd72c <__pthread_alt_lock+220>:	bne v1,s0,0xd744 <__pthread_alt_lock+244>
> 0xd730 <__pthread_alt_lock+224>:        nop
> 0xd734 <__pthread_alt_lock+228>:        move    a1,v0
> 0xd738 <__pthread_alt_lock+232>:        sc      a1,0(s1)
> 0xd73c <__pthread_alt_lock+236>:	beqz        a1,0xd724 <__pthread_alt_lock+212>
> 0xd740 <__pthread_alt_lock+240>:        nop
> 
> There is an extra "nop" in the delay slot. I don't think gas is smart
> enough to fill the delay slot. I will put back those ".set noredor".

The solution is to move the move instruction in front of the branch
instruction.  The assembler will then move it into the delay slot:

   __asm__ __volatile__
     ("/* Inline compare & swap */\n"
      "1:\n\t"
      "ll        %1,%5\n\t"
      "move      %0,$0\n\t"
      "move      %0,%4\n\t"
      "bne       %1,%3,2f\n\t"
      "sc        %0,%2\n\t"
      "beqz      %0,1b\n\t"
      "2:\n\t"
      "/* End compare & swap */"
      : "=&r" (ret), "=&r" (temp), "=m" (*p)
      : "r" (oldval), "r" (newval), "m" (*p)
      : "memory");

Also this function looks like a good candidate for inlining (Is it actually
inlined?  Haven't checked ...) where depending on it's use the address of
*p is loaded twice from the GOT, so changing the code to:

   __asm__ __volatile__
     ("/* Inline compare & swap */\n"
      "1:\n\t"
      "ll        %1,(%5)\n\t"
      "move      %0,$0\n\t"
      "move      %0,%4\n\t"
      "bne       %1,%3,2f\n\t"
      "sc        %0,(%2)\n\t"
      "beqz      %0,1b\n\t"
      "2:\n\t"
      "/* End compare & swap */"
      : "=&r" (ret), "=&r" (temp), "=r" (p)
      : "r" (oldval), "r" (newval), "r" (p)
      : "memory");

will avoid having to pay that PIC bloat twice and get you around the gas
inefficiency of putting in too many nops into PIC code.

  Ralf
