Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA07187; Thu, 27 Mar 1997 13:43:21 -0800
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA02673 for linux-list; Thu, 27 Mar 1997 13:43:11 -0800
Received: from atocha.sb.aw.sgi.com (atocha.sb.aw.sgi.com [144.253.1.35]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA02632 for <linux@cthulhu.engr.sgi.com>; Thu, 27 Mar 1997 13:43:05 -0800
Received: from zone by atocha.sb.aw.sgi.com (940816.SGI.8.6.9/8.6.9) with SMTP id NAA01852; 
Message-ID: <333AE9CF.167E@aw.sgi.com>
Date: Thu, 27 Mar 1997 13:42:40 -0800
From: Emmanuel Mogenet <mgix@aw.sgi.com>
Organization: Alias, Wavefront, Silicon Graphics, ...
X-Mailer: Mozilla 3.01 (X11; I; IRIX 6.2 IP22)
MIME-Version: 1.0
To: Mike Shaver <shaver@neon.ingenia.ca>
CC: linux@cthulhu.engr.sgi.com
Subject: Re: Sheepish question
References: <199703272048.PAA13651@neon.ingenia.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Mike Shaver wrote:
> 
> If I were, say, a total newbie when it comes to assembly, what would
> be a good place to start?  I've always meant to learn assembly, and
> this would seem an ideal opportunity -- and to do it on real hardware!
> =)
> 
> Any good references?  Anything MIPS-specific?

For general references on assembly programming, I'm not sure.
Is there a need for such a thing ?

But for MIPS specific, if you've go an SGI with a proper
development toolkit on it, it should come with an online
book entitled "MIPS Assembly Programming Guide".

That's quite a complete reference, but not a tutorial.

The hacker way of looking at things (the one I like) is
to write tiny C programs, compile them with cc -S,
look at the output, and try to understand what happens.

Even better, compile your c program and use dis (the sgi disassembler)
to look at the result (cc -S output something that's not really the
final
thing the CPU groks)

Also, dbx has quite a few command that allow you
to follow a program step by step at  assembly level:

ni			(next instruction, don't follow subroutine calls)
si			(next instruction, follow)
stopi at 		(add an asm level breakpoint)
syscall catch call xx	(stop on system call xx)
$pc-20/50i		(list asm fragment around current PC)
pr			(dump registers)
assign $pc=xxxx		(change value of register pc to xxxx)

etc ...


Finally, beware of pipelining weirdies.
A most striking example is:

[   4] 0x40092c:  03 e0 00 08         jr        ra		// Return from
subroutine
[   4] 0x400930:  24 02 00 03         li        v0,3		// Load return
value in v0

At first reading, it seems like the routine returns
before loading the return value in v0.

Actually, both instructions are executed at the same time.

	- Mgix
