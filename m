Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 21:14:12 +0100 (BST)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:47554 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22314359AbYJXUNy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Oct 2008 21:13:54 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9OKDouv031347;
	Fri, 24 Oct 2008 21:13:50 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9OKDn39031345;
	Fri, 24 Oct 2008 21:13:49 +0100
Date:	Fri, 24 Oct 2008 21:13:49 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	Phil Sutter <n0-1@freewrt.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] rb532: set gpio interrupt status and level for
	CompactFlash
Message-ID: <20081024201349.GF25297@linux-mips.org>
References: <200810241953.55841.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200810241953.55841.florian@openwrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20953
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 24, 2008 at 07:53:55PM +0200, Florian Fainelli wrote:

> This patch sets the correct interrupt status and level
> in order to get the CompactFlash adapter working.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>

Thanks, applied.

  Ralf
