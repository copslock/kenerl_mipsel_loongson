Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Oct 2002 09:38:53 +0200 (CEST)
Received: from mx2.mips.com ([206.31.31.227]:49315 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1122978AbSJAHiw>;
	Tue, 1 Oct 2002 09:38:52 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g917cfrZ001428;
	Tue, 1 Oct 2002 00:38:41 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA15768;
	Tue, 1 Oct 2002 00:39:01 -0700 (PDT)
Received: from mips.com (IDENT:carstenl@coplin20 [192.168.205.90])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g917cZb20128;
	Tue, 1 Oct 2002 09:38:36 +0200 (MEST)
Message-ID: <3D9950FA.78C756EF@mips.com>
Date: Tue, 01 Oct 2002 09:38:34 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.9-31-P3-UP-WS-jg i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kip Walker <kwalker@broadcom.com>
CC: linux-mips@linux-mips.org
Subject: Re: unaligned exception handling
References: <3D987A87.8B855D01@broadcom.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 316
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

You are right there is a potential problem in the 64-bit kernel, when
emulating load/store instructions.
I have previously addressed this problem (and also send a patch).

The problem is the check_axs macro, that checks the access before
actually doing the emulation (any load/stores).
It's a simple copy from the 32-bit kernel, where you do a check for user
space by simple check the most significant bit.
That's fine in the 32-bit world, but it's not sufficient in the 64-bit
case.

Locally I have a check_axs that look like this:

/*
 * User code may only access USEG;
 * Kernel code may access the entire address space, except the area
between
 * USEG (XUSEG) and KSEG0.
 */
#define check_axs(pc,a,s)      \
        if (((pc < KUSIZE) && (((a) | ((a)+(s))) >= KUSIZE)) ||  \
     ((((a) | ((a)+(s))) < K0BASE) &&    \
      (((a) | ((a)+(s))) >= KUSIZE)))    \
  goto sigbus;



Hope that helps you.
/Carsten



Kip Walker wrote:

> After inspecting a strange case in the mips64 kernel with address
> errors, I'm starting to think there's a problem in the do_ade()
> implementation.  I think the 32-bit kernel may have a similar problem,
> but I haven't really inspected it.  The issue is where the kernel's
> emulation of an address error causes another address error (NOT a page
> fault).
>
> Basically, I don't see how the exception table stuff in
> emulate_load_store_insn is going to work.  Consider this scenario:
>
> - user process does a 'sw' (for example) to an illegal address
>   above xuseg but below xsseg
> - do_ade calls emulate_load_store_insn, which tries swl/swr
> - the swl again hits an illegal address, this time in the
>   kernel's context
> - do_ade does NOT check the exception table for the swl
> - emulate_load_store_insn goes to the 'swl' part of the switch
> - die_if_kernel DOES __die before the SIGBUS is delivered.
>
> So I don't see how the ex_table stuff is useful at all.  Shouldn't
> do_ade() do the exception table grovelling before calling
> emulate_load_store_insn?
>
> Kip

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
