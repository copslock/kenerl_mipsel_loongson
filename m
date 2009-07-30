Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jul 2009 22:10:03 +0200 (CEST)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:35860
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493757AbZG3UJ4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 30 Jul 2009 22:09:56 +0200
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 519B1C8C485;
	Thu, 30 Jul 2009 13:10:00 -0700 (PDT)
Date:	Thu, 30 Jul 2009 13:10:00 -0700 (PDT)
Message-Id: <20090730.131000.259116391.davem@davemloft.net>
To:	sshtylyov@ru.mvista.com
Cc:	florian@openwrt.org, ralf@linux-mips.org,
	manuel.lauss@googlemail.com, linux-mips@linux-mips.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 0/4] au1000_eth platform device/driver conversion
From:	David Miller <davem@davemloft.net>
In-Reply-To: <4A71F8FD.3060002@ru.mvista.com>
References: <200907282300.07144.florian@openwrt.org>
	<20090730.123450.224830320.davem@davemloft.net>
	<4A71F8FD.3060002@ru.mvista.com>
X-Mailer: Mew version 6.2.51 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23802
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Date: Thu, 30 Jul 2009 23:48:13 +0400

>   Because they were only posted to linux-mips. And we didn't see #2 and
>   #4 in linux-mips either.

That's not going to work.

You can't apply some of these patches to one tree, and some to
the other.  That leaves the driver in a half-baked state in BOTH
trees during the entire development period.

So one of the two trees has to be chosen and all 4 patches added
there, and there only.
