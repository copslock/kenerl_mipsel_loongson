Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Oct 2007 21:43:27 +0100 (BST)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:9105 "EHLO
	the-village.bc.nu") by ftp.linux-mips.org with ESMTP
	id S20023160AbXJBUnT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 Oct 2007 21:43:19 +0100
Received: from the-village.bc.nu (localhost.localdomain [127.0.0.1])
	by the-village.bc.nu (8.14.1/8.13.8) with ESMTP id l92KmQL2007284;
	Tue, 2 Oct 2007 21:48:26 +0100
Date:	Tue, 2 Oct 2007 21:48:26 +0100
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Aurelien Jarno <aurelien@aurel32.net>
Cc:	qemu-devel@nongnu.org, linux-mips@linux-mips.org
Subject: Re: [Qemu-devel] QEMU/MIPS & dyntick kernel
Message-ID: <20071002214826.7ee2fae8@the-village.bc.nu>
In-Reply-To: <4702AC0F.1000906@aurel32.net>
References: <20071002200644.GA19140@hall.aurel32.net>
	<4702A99B.7020008@qumranet.com>
	<4702AC0F.1000906@aurel32.net>
X-Mailer: Claws Mail 2.10.0 (GTK+ 2.10.14; i386-redhat-linux-gnu)
Organization: Red Hat UK Cyf., Amberley Place, 107-111 Peascod Street,
 Windsor, Berkshire, SL4 1TE, Y Deyrnas Gyfunol. Cofrestrwyd yng Nghymru a
 Lloegr o'r rhif cofrestru 3798903
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16806
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

> Well on real hardware, the instruction rate and the timer are linked:
> the timer run at half the speed of the CPU. As the corresponding
> assembly code is very small, only uses registers and is run in kernel
> mode, you know for sure that 48 cycles is more than enough.

What happens on NMI or if you take an ECC exception and scrubbing stall
off the memory controller while loading part of that cache line of code
into memory ?

Alan
