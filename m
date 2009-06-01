Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 15:56:22 +0100 (BST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:49302 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20025378AbZFAO4P (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Jun 2009 15:56:15 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n51Etqfq012753;
	Mon, 1 Jun 2009 15:55:52 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n51EtqnC012751;
	Mon, 1 Jun 2009 15:55:52 +0100
Date:	Mon, 1 Jun 2009 15:55:52 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>
Subject: Re: [PATCH 10/10] bcm63xx: compile fixes for bcm63xx_enet.c
Message-ID: <20090601145552.GI6604@linux-mips.org>
References: <200905312031.35241.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200905312031.35241.florian@openwrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23118
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, May 31, 2009 at 08:31:34PM +0200, Florian Fainelli wrote:

> This patch makes the ethernet driver compile again
> after commit 908a7a1. netif_rx_schedule became
> napi_schedule and __netif_rx_complete became
> __napi_rx_complete.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>

Folded into the "MIPS: BCM63XX: Add integrated ethernet mac support."
patch.

You should eventually run this patch by the network maintainers.  It's
a driver patch so I won't merge it upstream unless it's been acked by one
of the network guys.

Thanks,

  Ralf
