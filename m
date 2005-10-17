Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2005 14:11:20 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:53781 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133576AbVJQNLA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Oct 2005 14:11:00 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9HDAma6011218;
	Mon, 17 Oct 2005 14:10:48 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9HDAmWH011217;
	Mon, 17 Oct 2005 14:10:48 +0100
Date:	Mon, 17 Oct 2005 14:10:47 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoann Allain <yallain@avilinks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: sti() freezes the kernel
Message-ID: <20051017131047.GF4884@linux-mips.org>
References: <4353656E.8070601@avilinks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4353656E.8070601@avilinks.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9239
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 17, 2005 at 10:48:46AM +0200, Yoann Allain wrote:

> I'm actually trying to start a 2.4 kernel on our new card.
> The kernel freezes when enabling interrupts with sti() in start_kernel() 
> (just before calculating BogoMips...).
> This looks like an interrupts is up when enabling so that it stops the 
> MIPS and freezes the kernel.
> I'm looking after this interrupt but I would like to know if there could 
> be any others reasons for my kernel to freeze when doing a call to sti();

This is a fairly scenario and as you suspect it's being caused by interrupt
problems, such as interrupts still pending from the firmware, being
not initialized at all or similar.

  Ralf
