Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2009 10:09:08 +0200 (CEST)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:49019
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492328AbZJNIJB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Oct 2009 10:09:01 +0200
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id D2298C8C2A6;
	Wed, 14 Oct 2009 01:09:13 -0700 (PDT)
Date:	Wed, 14 Oct 2009 01:09:13 -0700 (PDT)
Message-Id: <20091014.010913.21176323.davem@davemloft.net>
To:	ddaney@caviumnetworks.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 0/6] netdev: Octeon MGMT new driver + octeon_ethernet
 updates.
From:	David Miller <davem@davemloft.net>
In-Reply-To: <4ACD1F4E.8090603@caviumnetworks.com>
References: <4ACD1F4E.8090603@caviumnetworks.com>
X-Mailer: Mew version 6.2.51 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24294
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: David Daney <ddaney@caviumnetworks.com>
Date: Wed, 07 Oct 2009 16:07:58 -0700

> The main thrust of this patch set is to add a driver for the Cavium
> Networks Octeon processor's MII (Management port) Ethernet devices.
> Since it shares an mdio bus with the existing octeon-ethernet driver,
> there is also some rearrangement of that code.

Ralf how do you want to handle this patch set?

Since it's mostly MIPS infrastructure bits, please just add my:

Acked-by: David S. Miller <davem@davemloft.net>

to the commit that adds the actual driver under drivers/net/
and you can merge all of it via your tree.

Thanks!
