Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Nov 2002 13:36:42 +0100 (CET)
Received: from p508B4A7D.dip.t-dialin.net ([80.139.74.125]:935 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1123956AbSKTMgm>; Wed, 20 Nov 2002 13:36:42 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gAKCZbK28496;
	Wed, 20 Nov 2002 13:35:37 +0100
Date: Wed, 20 Nov 2002 13:35:37 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: atul srivastava <atulsrivastava9@rediffmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: epc status cause all are reported zero?
Message-ID: <20021120133537.A26255@linux-mips.org>
References: <20021120104638.23926.qmail@webmail36.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021120104638.23926.qmail@webmail36.rediffmail.com>; from atulsrivastava9@rediffmail.com on Wed, Nov 20, 2002 at 10:46:38AM -0000
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 680
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 20, 2002 at 10:46:38AM -0000, atul srivastava wrote:

> During exec there is a page fault of 4000b0 but immediately after 
> that i get another page fault 0f 0x0fc01788 and following register 
> dump after it
> fails to get a fixup address.
> 
> Unable to handle kernel paging request at virtual address 
> 0fc01788, epc == 00000Oops in fault.c:do_page_fault, line 230:
> $0 : 00000000 00000000 00000000 00000000
> $4 : 00007340 800f0474 00000000 801fa000
> $8 : 00000000 00000000 00000000 4c696e75
> $12: 78000000 00000000 00000000 00000000
> $16: 00000000 00000000 00000000 00000000
> $20: 00000000 00000000 00000000 00000000
> $24: 00000000 00000000
> $28: 6e652900 00000000 00000000 00000000
> epc   : 00000000
> Status: 00000000
> Cause : 00000000
> Process sh (pid: 1, stackpage=801fa000)
> 
> 
> i am confused how come the epc status and cause register all are 
> reported zero.
> whether my regs ( pointer to struct pt_regs) is pointing somewhere 
> else..?

Let me elaborate a bit beyond what Kevin already said.  Normally a
sane register dump will contain an 8kB aligned KSEG0 address in $28;
$29 which is the stack pointer should be a little bit less than 8kB
bigger than $28.  The status register should never become 0.

The value in $28 should be identical to the address printed by
for stackpage, 0x801fa000.  They're not in your case so you may want
to start tracking there and find why they're not identical.

  Ralf
