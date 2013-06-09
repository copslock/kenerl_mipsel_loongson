Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Jun 2013 16:43:30 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:40693 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835040Ab3FIOn37Qi-T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 9 Jun 2013 16:43:29 +0200
Date:   Sun, 9 Jun 2013 15:43:29 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Alexis BRENON <abrenon@wyplay.com>
cc:     linux-mips@linux-mips.org
Subject: Re: Immediate branch offset
In-Reply-To: <51B1B739.7080104@wyplay.com>
Message-ID: <alpine.LFD.2.03.1306082206540.18329@linux-mips.org>
References: <51B1B739.7080104@wyplay.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36758
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Fri, 7 Jun 2013, Alexis BRENON wrote:

> To create the JIT, I have to load some MIPS instruction directly in memory
> without passing through a .asm file or else. So, I cannot set some labels. So
> to make some branches, I try to load the equivalent instruction of :
>     bne $t0, $t1, -8
> to go back, just before the bne instruction, if $t0 and $t1 are equals. But
> when it run, I've got an illegal instruction error.

 Please note that BNE means Branch-if-Not-Equal, your quoted instruction
will jump backwards if $t0 and $t1 are *not* equal.

> To debug, I write a small program in the MARS MIPS simulator with this
> instruction. But when compiling, assembler says me that -8 is an operand of
> incorrect type.

 The instruction you quoted assembles for me successfully, what version of 
binutils do you use and what exact error message do you get?

 Please note however that this instruction is not what I understand you 
need -- it is treated as a branch to the absolute address -8 (0xfffffff8 
in the o32 ABI), rather than 8 bytes back (there's an off-by-four bug in 
GAS here too making it jump to -4 instead, and some other issues; I'll see 
if I can get them fixed sometime -- see the discussion around 
http://sourceware.org/ml/binutils/2012-09/msg00288.html if interested in 
the gory details).

 If you want to jump to the instruction immediately preceding the branch 
and avoid a label (assuming the standard MIPS ISA), use:

	bne	$t0, $t1, . - 4

-- "." is a special "the address of this instruction" designator (see the 
GAS manual for further information), so this produces the machine 
instruction you require (the jump is calculated as relative to the next 
instruction -- that is (. + 4) -- so the ultimate effective (i.e. shifted 
rather than as encoded in the instruction's 16-bit immediate operand 
field) offset is -8).

$ cat foo.s
	bne	$t0, $t1, . - 4
$ mips-linux-as -o foo.o foo.s
$ mips-linux-objdump -dr foo.o

foo.o:     file format elf32-tradbigmips


Disassembly of section .text:

00000000 <.text>:
   0:	1509fffe 	bne	t0,t1,0xfffffffc
   4:	00000000 	nop
	...
$ mips-linux-as --version
GNU assembler (GNU Binutils) 2.23.2
[...]

Likewise with the current binutils trunk.

 I hope this helps.

  Maciej
