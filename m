Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Nov 2002 14:34:05 +0100 (CET)
Received: from p508B75AF.dip.t-dialin.net ([80.139.117.175]:61072 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1123974AbSKRNeE>; Mon, 18 Nov 2002 14:34:04 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gAIDXrB12216;
	Mon, 18 Nov 2002 14:33:53 +0100
Date: Mon, 18 Nov 2002 14:33:53 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Alignment of FP Context Storage
Message-ID: <20021118143353.A12096@linux-mips.org>
References: <015201c28f05$cb583800$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <015201c28f05$cb583800$10eca8c0@grendel>; from kevink@mips.com on Mon, Nov 18, 2002 at 02:24:06PM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 665
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 18, 2002 at 02:24:06PM +0100, Kevin D. Kissell wrote:

> I'm cleaning up some old Linux kernel sandboxes, and
> came across a patch which I had long ago made in a
> local copy of include/asm-mips/processor.h but which
> does not seem to have been propagated more widely.
> I had added "__attribute__((aligned(8))))" to the
> declarations of the mips_fpu_hard_struct and
> mips_fpu_soft_struct data structures, presumably
> because there was a need to ensure 64-bit alignment
> of the elements so that LDC1 instructions would work.
> We don't generally have a problem here, presumably
> because either the previous data declarations naturally
> align things to 64-bits, or because we've ensured things 
> at a higher level of makfile compiler directives.  Are we 
> in fact guarnateed to be safe without the source code 
> directive, or should those __attribute__ directives be 
> added as insurance?

The definition of mips_cpu_hard_struct uses doubles which is ensuring
mips_fpu_hard_struct will have 64-bit alignment.  This is actually part
of thread_struct which itself has 8kB alignment on 32-bit and 16kB
alignment on 64-bit.

  Ralf
