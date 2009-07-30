Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jul 2009 21:34:52 +0200 (CEST)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:46067
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493440AbZG3Teq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 30 Jul 2009 21:34:46 +0200
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 1DB01C8C485;
	Thu, 30 Jul 2009 12:34:50 -0700 (PDT)
Date:	Thu, 30 Jul 2009 12:34:50 -0700 (PDT)
Message-Id: <20090730.123450.224830320.davem@davemloft.net>
To:	florian@openwrt.org
Cc:	ralf@linux-mips.org, manuel.lauss@googlemail.com,
	linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/4] au1000_eth platform device/driver conversion
From:	David Miller <davem@davemloft.net>
In-Reply-To: <200907282300.07144.florian@openwrt.org>
References: <200907282300.07144.florian@openwrt.org>
X-Mailer: Mew version 6.2.51 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23800
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: Florian Fainelli <florian@openwrt.org>
Date: Tue, 28 Jul 2009 23:00:04 +0200

> Hi Ralf, David, Manuel,
> 
> The following patches convert the AMD Alchemy au1000_eth driver
> to become a platform device/driver. The patches are splitted that way:

I was only able to see patch #2 and #4 in this series and
checking the netdev patch postings that made it to:

	http://patchwork.ozlabs.org/project/netdev/list/

confirms that patches #1 and #3 didn't make it to the list
either.
