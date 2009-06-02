Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2009 10:26:13 +0100 (WEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:47169 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20021873AbZFBJ0F (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 Jun 2009 10:26:05 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n529Pf89004716;
	Tue, 2 Jun 2009 10:25:41 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n529Pfv9004714;
	Tue, 2 Jun 2009 10:25:41 +0100
Date:	Tue, 2 Jun 2009 10:25:41 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>
Subject: Re: [PATCH 10/10] bcm63xx: compile fixes for bcm63xx_enet.c
Message-ID: <20090602092541.GB3527@linux-mips.org>
References: <200905312031.35241.florian@openwrt.org> <20090601145552.GI6604@linux-mips.org> <200906011702.40561.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200906011702.40561.florian@openwrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23167
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 01, 2009 at 05:02:38PM +0200, Florian Fainelli wrote:

> > You should eventually run this patch by the network maintainers.  It's
> > a driver patch so I won't merge it upstream unless it's been acked by one
> > of the network guys.
> 
> Actually Maxime already submitted those patches, without much answer from the 
> network guys so I guess they just skipped it.

Patches do get dropped so just resubmit until you get an ACK or NACK.

  Ralf
