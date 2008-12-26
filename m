Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Dec 2008 00:52:21 +0000 (GMT)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:11170
	"EHLO sunset.davemloft.net") by ftp.linux-mips.org with ESMTP
	id S24208289AbYLZAwT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 26 Dec 2008 00:52:19 +0000
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id A82F5C8C1AA;
	Thu, 25 Dec 2008 16:52:19 -0800 (PST)
Date:	Thu, 25 Dec 2008 16:52:19 -0800 (PST)
Message-Id: <20081225.165219.83442602.davem@davemloft.net>
To:	ddaney@caviumnetworks.com
Cc:	linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: Re: [PATCH 3/3] netdev: New driver for OCTEON's MGMT ethernet
 devices.
From:	David Miller <davem@davemloft.net>
In-Reply-To: <1229730192-11870-3-git-send-email-ddaney@caviumnetworks.com>
References: <494C312E.9000901@caviumnetworks.com>
	<1229730192-11870-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: Mew version 6.1 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21670
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: David Daney <ddaney@caviumnetworks.com>
Date: Fri, 19 Dec 2008 15:43:12 -0800

> +#define CVMX_MDIO_PHY_REG_CONTROL 0
> +union cvmx_mdio_phy_reg_control {
> +	uint16_t u16;
> +	struct {
> +		uint16_t reset:1;
> +		uint16_t loopback:1;
> +		uint16_t speed_lsb:1;

Please use the standard Linux in-kernel types for fixed sized
integers, such as u16, u32, etc.

Having a union member named the same as a standard type defined in the
kernel is very confusing.
