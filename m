Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jul 2008 18:40:34 +0100 (BST)
Received: from ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk ([217.169.26.28]:28139
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S28580484AbYGYRkc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 25 Jul 2008 18:40:32 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m6PHeRO1000944;
	Fri, 25 Jul 2008 18:40:27 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m6PHeP03000943;
	Fri, 25 Jul 2008 18:40:25 +0100
Date:	Fri, 25 Jul 2008 18:40:25 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	danieljlaird@hotmail.com
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: Watchdog drivers where to post
Message-ID: <20080725174025.GA793@linux-mips.org>
References: <COL102-DS16F8C6A03D54FF8B7A87C4DC860@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <COL102-DS16F8C6A03D54FF8B7A87C4DC860@phx.gbl>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 25, 2008 at 06:37:55PM +0100, danieljlaird@hotmail.com wrote:

> I am wanting to post a watchdog driver for pnx833x.
> 
> I can find all the mailing lists for netdev/i2c/.... 
> 
> However, where do I post a watchdog driver?
> 
> Can I post here or do i post somewhere else

Just check the MAINTAINERS file; it says:

WATCHDOG DEVICE DRIVERS
P:      Wim Van Sebroeck
M:      wim@iguana.be
T:      git kernel.org:/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git
S:      Maintained

Cc'ing linux-mips and whoever else you consider to be possibly interested
can't harm.

  Ralf
