Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2009 11:03:28 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:54167 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492484AbZJNJDY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 Oct 2009 11:03:24 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n9E94YDW017641;
	Wed, 14 Oct 2009 11:04:34 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n9E94Tp5017639;
	Wed, 14 Oct 2009 11:04:29 +0200
Date:	Wed, 14 Oct 2009 11:04:29 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Miller <davem@davemloft.net>
Cc:	ddaney@caviumnetworks.com, linux-mips@linux-mips.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 0/6] netdev: Octeon MGMT new driver + octeon_ethernet
	updates.
Message-ID: <20091014090429.GB17300@linux-mips.org>
References: <4ACD1F4E.8090603@caviumnetworks.com> <20091014.010913.21176323.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091014.010913.21176323.davem@davemloft.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 14, 2009 at 01:09:13AM -0700, David Miller wrote:

> > The main thrust of this patch set is to add a driver for the Cavium
> > Networks Octeon processor's MII (Management port) Ethernet devices.
> > Since it shares an mdio bus with the existing octeon-ethernet driver,
> > there is also some rearrangement of that code.
> 
> Ralf how do you want to handle this patch set?
> 
> Since it's mostly MIPS infrastructure bits, please just add my:
> 
> Acked-by: David S. Miller <davem@davemloft.net>
> 
> to the commit that adds the actual driver under drivers/net/
> and you can merge all of it via your tree.

Okay, will merge.  Thanks!

  Ralf
