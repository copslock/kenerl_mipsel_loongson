Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Nov 2004 12:56:59 +0000 (GMT)
Received: from pD95621F5.dip.t-dialin.net ([IPv6:::ffff:217.86.33.245]:13116
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225329AbUKIM4z>; Tue, 9 Nov 2004 12:56:55 +0000
Received: from fluff.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id iA9Cup2G006431;
	Tue, 9 Nov 2004 13:56:51 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id iA9CupoD006430;
	Tue, 9 Nov 2004 13:56:51 +0100
Date: Tue, 9 Nov 2004 13:56:51 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] Function / prototype mismatch
Message-ID: <20041109125651.GD5652@linux-mips.org>
References: <200411091328.42360.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411091328.42360.thomas.koeller@baslerweb.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6284
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 09, 2004 at 01:28:42PM +0100, Thomas Koeller wrote:

> The definition of do_IRQ() in arch/mips/kernel/irq.c
> does not match the prototype in include/asm-mips/irq.h,
> resulting in a compile error.

[ralf@fluff linux]$ grep -r do_IRQ include/linux
include/linux/irq.h:extern asmlinkage unsigned int __do_IRQ(unsigned int irq, struct pt_regs *regs);
[ralf@fluff linux]$

Just reposting somebody else's broken fix doesn't increase chances that I
take a patch ...

  Ralf
