Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Dec 2002 12:14:54 +0100 (CET)
Received: from mx2.mips.com ([206.31.31.227]:25592 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S8225265AbSLELOx>;
	Thu, 5 Dec 2002 12:14:53 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gB5BEiNf028815;
	Thu, 5 Dec 2002 03:14:44 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id DAA11424;
	Thu, 5 Dec 2002 03:14:43 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id gB5BEib25980;
	Thu, 5 Dec 2002 12:14:44 +0100 (MET)
Message-ID: <3DEF3524.7A5CDE57@mips.com>
Date: Thu, 05 Dec 2002 12:14:44 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Latest sources from CVS.
References: <3DEDBDFC.D87C1B84@mips.com> <005701c29b74$f1f76870$10eca8c0@grendel> <20021205043444.B29939@linux-mips.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

> On Wed, Dec 04, 2002 at 10:09:54AM +0100, Kevin D. Kissell wrote:
>
> > For those on the list who don't understand Carsten's sense
> > of humour, I think that was missing a smiley!  ;-)
> > I mean, sure, we'd like to move more people toward SDE,
> > but "force" is putting it a bit strongly!  And if those directives
> > are really being used unconditionally, I worry that the code
> > being generated is likewise emitting MIPS32 instructions
> > that won't work on the "ghost fleet" of abandoned workstations
> > now running Linux on R4K/R5K CPUs.
>
> A fix is now in CVS.  With this fix only compiling a kernel for MIPS32
> and MIPS64 CPUs will require a the new tools.
>
> Everybody satisfied?

Not quite, I afraid.
I would like to be able to compile a 64-bit kernel, using the
MIPS32/MIPS64 config1 register, but I don't have a MIPS64 compliant n64
compiler (assembler). So I need the hardcoded ".word" opcode version, we
previously had.

Something like this:

/*
 * This should be changed when we get a compiler that support the MIPS32
ISA.
 */
#define read_mips32_cp0_config1()                               \
({ int __res;                                                   \
        __asm__ __volatile__(                                   \
 ".set\tnoreorder\n\t"                                   \
 ".set\tnoat\n\t"                                        \
 "#.set\tmips64\n\t"     \
 "#mfc0\t$1, $16, 1\n\t"     \
 "#.set\tmips0\n\t"     \
      ".word\t0x40018001\n\t"                                 \
 "move\t%0,$1\n\t"                                       \
 ".set\tat\n\t"                                          \
 ".set\treorder"                                         \
 :"=r" (__res));                                         \
        __res;})


>
> I was quite amazed how much email in just like 2 days this change was
> producing, even people binutils 2.8 started yelling ...
>
>   Ralf

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
