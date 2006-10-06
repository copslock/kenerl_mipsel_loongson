Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Oct 2006 07:43:23 +0100 (BST)
Received: from smtp.osdl.org ([65.172.181.4]:48056 "EHLO smtp.osdl.org")
	by ftp.linux-mips.org with ESMTP id S20038416AbWJFGnW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Oct 2006 07:43:22 +0100
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k966hBaX011229
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 5 Oct 2006 23:43:12 -0700
Received: from box (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k966hA1G020591;
	Thu, 5 Oct 2006 23:43:11 -0700
Date:	Thu, 5 Oct 2006 23:43:10 -0700
From:	Andrew Morton <akpm@osdl.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Jeff Garzik <jgarzik@pobox.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Andy Fleming <afleming@freescale.com>, netdev@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [patch 3/6] 2.6.18: sb1250-mac: Phylib IRQ handling fixes
Message-Id: <20061005234310.6c8042b5.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64N.0610031509380.4642@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0610031509380.4642@blysk.ds.pg.gda.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Return-Path: <akpm@osdl.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@osdl.org
Precedence: bulk
X-list: linux-mips

On Tue, 3 Oct 2006 16:18:35 +0100 (BST)
"Maciej W. Rozycki" <macro@linux-mips.org> wrote:

> 
> 2. The driver uses schedule_work() for handling interrupts, but does not 
>    make sure any pending work scheduled thus has been completed before 
>    driver's structures get freed from memory.  This is especially 
>    important as interrupts may keep arriving if the line is shared with 
>    another PHY.
> 
>    The solution is to ignore phy_interrupt() calls if the reported device 
>    has already been halted and calling flush_scheduled_work() from 
>    phy_stop_interrupts() (but guarded with current_is_keventd() in case 
>    the function has been called through keventd from the MAC device's 
>    close call to avoid a deadlock on the netlink lock).
> 

eww, hack.

Also not module-friendly:

WARNING: "current_is_keventd" [drivers/net/phy/libphy.ko] undefined!

Does this

static void flush_cpu_workqueue(struct cpu_workqueue_struct *cwq)
{
	if (cwq->thread == current) {
		/*
		 * Probably keventd trying to flush its own queue. So simply run
		 * it by hand rather than deadlocking.
		 */
		run_workqueue(cwq);

not work???
