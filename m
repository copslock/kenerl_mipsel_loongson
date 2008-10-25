Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Oct 2008 15:45:10 +0100 (BST)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:32994 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22362681AbYJYOpF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 25 Oct 2008 15:45:05 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9PEj2Sm004458;
	Sat, 25 Oct 2008 15:45:02 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9PEj2Nm004456;
	Sat, 25 Oct 2008 15:45:02 +0100
Date:	Sat, 25 Oct 2008 15:45:02 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MIPS] sgi_btns: add license specification
Message-ID: <20081025144502.GA2050@linux-mips.org>
References: <1224888417-26494-1-git-send-email-dmitri.vorobiev@movial.fi> <1224888417-26494-2-git-send-email-dmitri.vorobiev@movial.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1224888417-26494-2-git-send-email-dmitri.vorobiev@movial.fi>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20968
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Oct 25, 2008 at 01:46:57AM +0300, Dmitri Vorobiev wrote:

> The SGI Volume Button interface driver uses GPL-only symbols
> platform_driver_unregister and platform_driver_register, but
> lacks license specification. Thus, when compiled as a module,
> this driver cannot be installed. This patch fixes this by
> adding the MODULE_LICENSE() specification.
> 
> Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>

Patch is correct - but it stumped my nose at another bug.

A platform driver is supposed to be safe if loaded into a kernel for another
machine.  With the #ifdef'ed sections of this driver, a crash would be
likely if the module built for IP22 would be loaded into an IP32 kernel or
vice versa.

  Ralf
