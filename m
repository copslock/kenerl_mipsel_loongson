Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 07 Jun 2009 09:41:53 +0100 (WEST)
Received: from kirsty.vergenet.net ([202.4.237.240]:38654 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20021838AbZFGIlq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 7 Jun 2009 09:41:46 +0100
Received: from harry.kent.sydney.vergenet.net (124-170-70-82.dyn.iinet.net.au [124.170.70.82])
	by kirsty.vergenet.net (Postfix) with ESMTP id DB4C72404F;
	Sun,  7 Jun 2009 18:41:41 +1000 (EST)
Received: by harry.kent.sydney.vergenet.net (Postfix, from userid 7100)
	id 4B3394740E7; Sun,  7 Jun 2009 18:41:39 +1000 (EST)
Date:	Sun, 7 Jun 2009 18:41:38 +1000
From:	Simon Horman <horms@verge.net.au>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] net/netfilter/ipvs/ip_vs_wrr.c: use lib/gcd.c
Message-ID: <20090607084137.GB8007@verge.net.au>
References: <200906041616.22786.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200906041616.22786.florian@openwrt.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <horms@verge.net.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23316
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: horms@verge.net.au
Precedence: bulk
X-list: linux-mips

On Thu, Jun 04, 2009 at 04:16:21PM +0200, Florian Fainelli wrote:
> This patch removes the open-coded version of the
> greatest common divider to use lib/gcd.c, the latter
> also implementing the a < b case.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>

Acked-by: Simon Horman <horms@verge.net.au>
