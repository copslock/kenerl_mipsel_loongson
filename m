Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2005 16:15:02 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:7193 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133535AbVJQPOp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Oct 2005 16:14:45 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9HFEaoL015304;
	Mon, 17 Oct 2005 16:14:36 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9HFEalk015303;
	Mon, 17 Oct 2005 16:14:36 +0100
Date:	Mon, 17 Oct 2005 16:14:36 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoann Allain <yallain@avilinks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: sti() freezes the kernel
Message-ID: <20051017151436.GH4884@linux-mips.org>
References: <4353656E.8070601@avilinks.com> <20051017131047.GF4884@linux-mips.org> <4353A98C.80508@avilinks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4353A98C.80508@avilinks.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9241
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 17, 2005 at 03:39:24PM +0200, Yoann Allain wrote:

> Since last mail I played with the interrupt masks (IM - bits 15-8 in 
> MIPS status register) . From the MIPS cause register, it seems that the 
> bit 15 (hardware interrupt 5 or timer interrupt) is the originator of 
> the freezing interrupt. And the exception code shown for this interrupt 
> is 6 corresponding to a Bus error exception. I think there's a pointer 
> to the interrupt handler not correctly initialized. So that the 
> interrupt makes a jump to nowhere.

In which case you should get a nice register dump with $ra pointing to
offending jalr instruction + 8 bytes.  Of course that requieres you
to get printk working even earlier but with a serial console that's
trivial.

  Ralf
