Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Nov 2008 08:44:30 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:31629 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22830100AbYJaOrK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 31 Oct 2008 14:47:10 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9VEl7kJ009605;
	Fri, 31 Oct 2008 14:47:07 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9VEl6dR009603;
	Fri, 31 Oct 2008 14:47:06 GMT
Date:	Fri, 31 Oct 2008 14:47:06 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Phil Sutter <n0-1@freewrt.org>
Cc:	linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH] rb532: gpio register offsets are relatives to GPIOBASE
Message-ID: <20081031144706.GA9149@linux-mips.org>
References: <200810261112.37008.florian@openwrt.org> <1225459469-12279-1-git-send-email-n0-1@freewrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1225459469-12279-1-git-send-email-n0-1@freewrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21151
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 31, 2008 at 02:24:29PM +0100, Phil Sutter wrote:

> From: Florian Fainelli <florian@openwrt.org>
> 
> This patch fixes the wrong use of GPIO register offsets
> in devices.c. To avoid further problems, use gpio_get_value
> to return the NAND status instead of our own expanded code.
> 
> Also define the zero offset of the alternate function register to allow
> consistent access.
> 
> Signef-off-by: Phil Sutter <n0-1@freewrt.org>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>

Thanks, applied - with the SOBs fixed up.

  Ralf
