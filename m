Received:  by oss.sgi.com id <S553972AbQKMWLN>;
	Mon, 13 Nov 2000 14:11:13 -0800
Received: from u-174.karlsruhe.ipdial.viaginterkom.de ([62.180.10.174]:25356
        "EHLO u-174.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553967AbQKMWLB>; Mon, 13 Nov 2000 14:11:01 -0800
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869076AbQKMJrf>;
        Mon, 13 Nov 2000 10:47:35 +0100
Date:   Mon, 13 Nov 2000 10:47:35 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     linux-mips@oss.sgi.com
Subject: Re: Build failure for R3000 DECstation
Message-ID: <20001113104735.A3253@bacchus.dhis.org>
References: <20001112210049.C26606@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001112210049.C26606@lug-owl.de>; from jbglaw@lug-owl.de on Sun, Nov 12, 2000 at 09:00:49PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, Nov 12, 2000 at 09:00:49PM +0100, Jan-Benedict Glaw wrote:

> I see this build failure:
> 
> mipsel-linux-gcc -D__KERNEL__ -I/usr/src/mipsel/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -G 0 -mno-abicalls -fno-pic -mcpu=r3000 -mips1 -pipe     -c -o sysmips.o sysmips.c
> sysmips.c: In function `sys_sysmips':
> sysmips.c:109: warning: implicit declaration of function `syscall_trace'
> {standard input}: Assembler messages:
> {standard input}:337: Error: opcode requires -mips2 or greater `ll'
> {standard input}:339: Error: opcode requires -mips2 or greater `sc'
> {standard input}:340: Error: opcode requires -mips2 or greater `beqzl'
> {standard input}:341: Error: opcode requires -mips2 or greater `ll'
> make[1]: *** [sysmips.o] Error 1

The sysmips(MIPS_ATOMIC_SET, ...) implementation used to be completly broken.
I fixed it for CPUs with ll/sc and left the part with ll/sc to others.

Obviously none of them seemed to care so now I'm doing the quick fix.
Frankly, a syscall which shouldn't be used doesn't deserve more attention ...

  Ralf
