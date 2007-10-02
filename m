Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Oct 2007 23:35:52 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:18075 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023614AbXJBWfu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 Oct 2007 23:35:50 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l92MZnKN022102;
	Tue, 2 Oct 2007 23:35:49 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l92MZlER022100;
	Tue, 2 Oct 2007 23:35:47 +0100
Date:	Tue, 2 Oct 2007 23:35:47 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Aurelien Jarno <aurelien@aurel32.net>
Cc:	Alan Cox <alan@lxorguk.ukuu.org.uk>, qemu-devel@nongnu.org,
	linux-mips@linux-mips.org
Subject: Re: [Qemu-devel] QEMU/MIPS & dyntick kernel
Message-ID: <20071002223547.GA21687@linux-mips.org>
References: <20071002200644.GA19140@hall.aurel32.net> <4702A99B.7020008@qumranet.com> <4702AC0F.1000906@aurel32.net> <20071002214826.7ee2fae8@the-village.bc.nu> <4702B0B4.6080909@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4702B0B4.6080909@aurel32.net>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16808
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 02, 2007 at 10:57:24PM +0200, Aurelien Jarno wrote:
> From: Aurelien Jarno <aurelien@aurel32.net>
> Date: Tue, 02 Oct 2007 22:57:24 +0200
> To: Alan Cox <alan@lxorguk.ukuu.org.uk>
> CC: qemu-devel@nongnu.org, linux-mips@linux-mips.org
> Subject: Re: [Qemu-devel] QEMU/MIPS & dyntick kernel
> Content-Type: text/plain; charset=ISO-8859-1
> 
> Alan Cox a écrit :
> >> Well on real hardware, the instruction rate and the timer are linked:
> >> the timer run at half the speed of the CPU. As the corresponding
> >> assembly code is very small, only uses registers and is run in kernel
> >> mode, you know for sure that 48 cycles is more than enough.
> > 
> > What happens on NMI or if you take an ECC exception and scrubbing stall
> > off the memory controller while loading part of that cache line of code
> > into memory ?
> > 
> 
> The code returns -ETIME, and the function is run again with the minimum
> delay.
> 
> So as long as you don't have an exception every time, the code works.

The current setting should be safe on real hardware - but a value of
just 48 cycles for max_delta_ns is probably lower than the lowest
useful value, so I don't mind raising it.  This number really is a
tunable.

  Ralf
