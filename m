Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Dec 2004 07:25:20 +0000 (GMT)
Received: from web209.biz.mail.re2.yahoo.com ([IPv6:::ffff:68.142.224.171]:45467
	"HELO web209.biz.mail.re2.yahoo.com") by linux-mips.org with SMTP
	id <S8224905AbUL2HZL>; Wed, 29 Dec 2004 07:25:11 +0000
Message-ID: <20041229072454.30862.qmail@web209.biz.mail.re2.yahoo.com>
Received: from [63.194.214.47] by web209.biz.mail.re2.yahoo.com via HTTP; Tue, 28 Dec 2004 23:24:54 PST
Date: Tue, 28 Dec 2004 23:24:54 -0800 (PST)
From: Peter Popov <ppopov@embeddedalley.com>
Subject: Re: Problem when the CPU cache is turned on
To: priya <priya@procsys.com>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <41D23806.BC19A3C9@procsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6788
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


> Iam trying to bring up a custom board
> with RM5231A MIPS processor and IT8172
> companion chip. Right now i have an
> issue related to running Linux 2.4.25 on
> MIPS with cache enabled.
 
> When i run the kernel with CPU Cache
> enabled, i get the following error
> messages.
> A. "Unhandled kernel unaligned access or
> invalid instruction in
> unaligned.c::emulate_load_store_insn,
> line 493:"
> B. "Reserved instruction in kernel code
> in traps.c::do_ri, line 663:"
> C. "Unable to handle kernel paging
> request at virtual address 00000000
> 
> These errors happen when i run fsck, vi
> or a simple du command.
 
> When i trun on the "Run uncached"
> option  these errors disapper.
> 
> I do not know where to start debugging.
> Can any one tell me what could be the
> problem when the cache is turned on.

That CPU and coprocessor are/were supported in 2.4 so
in general, the kernel "should" run. If you have
access to an off the shelf reference board with that
CPU and system processor, start there and see if the
kernel runs on that board. If it does not, you may be
looking at a kernel issue. If the kernel runs on the
reference board, then your issue is most likely a
hardware problem with your board. If you don't have
access to a reference board, then you'll be trying to
figure out if this is a hardware or kernel problem.
I'm guessing it's hardware but hopefully not. Hook in
kgdb and try to reproduce the problem with the most
simple test you can find that causes the crash.
Examine the point of failure and try to make sense of
it to figure out if it's kernel or hardware related.
Of course I assume you've already ran at least basic
memory tests on the board and that much passes. If
not, then start there.

Pete
