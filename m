Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Oct 2004 18:06:33 +0100 (BST)
Received: from p508B7611.dip.t-dialin.net ([IPv6:::ffff:80.139.118.17]:46628
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225238AbUJSRGU>; Tue, 19 Oct 2004 18:06:20 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i9JH6Hsm020570;
	Tue, 19 Oct 2004 19:06:17 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i9JH6HK8020569;
	Tue, 19 Oct 2004 19:06:17 +0200
Date: Tue, 19 Oct 2004 19:06:17 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: Linux/MIPS Development <linux-mips@linux-mips.org>,
	Manish Lachwani <mlachwani@mvista.com>
Subject: Re: jump instruction in delay slot
Message-ID: <20041019170617.GC18385@linux-mips.org>
References: <200410191605.47543.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410191605.47543.thomas.koeller@baslerweb.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 19, 2004 at 04:05:47PM +0200, Thomas Koeller wrote:

> 		jal	do_IRQ
> 		j	ret_from_irq

Beyond what Thiemo has said correctly ...  in the cases where I've tried
to debug code where a jmp or branch instruction was being executed in the
delay slot of another jump or branch instruction the CPU does *really*
unexpected things.

  Ralf
