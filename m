Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Nov 2006 09:40:59 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:21520 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20037611AbWKTJky (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Nov 2006 09:40:54 +0000
Received: (qmail 13519 invoked by uid 1000); 20 Nov 2006 10:40:53 +0100
Date:	Mon, 20 Nov 2006 10:40:53 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org
Subject: au1xmmc.c: does it work?
Message-ID: <20061120094053.GA13509@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13222
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hello folks,

I'm trying to get the au1x mmc driver working on a Au1200 board.
I insert a known working card, and the mmc cmd trace suggests
CMD9 (send CSD) times out. Before I go about to trace the
problem I'd like to know if other people see this problem too
or if it's specific to my system.
(Au1200, 2.6.19-rc6)

Thanks!

-- 
 ml.
