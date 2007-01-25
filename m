Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Jan 2007 08:20:49 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:55564 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20048408AbXAYIUp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Jan 2007 08:20:45 +0000
Received: (qmail 8370 invoked by uid 1000); 25 Jan 2007 09:19:44 +0100
Date:	Thu, 25 Jan 2007 09:19:44 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Pierre Ossman <drzeus-mmc@drzeus.cx>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MMC: au1xmmc R6 response support
Message-ID: <20070125081944.GA8358@roarinelk.homelinux.net>
References: <20070123100814.GA5001@roarinelk.homelinux.net> <45B65A73.90308@drzeus.cx> <20070124055202.GA6446@roarinelk.homelinux.net> <45B72F13.4040707@drzeus.cx> <20070125072000.GA8257@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070125072000.GA8257@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.11
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hi Pierre,
> 
> > HEAD has this fixed. Every spec I can get my hands on states that R1 and
> > R6 have the same format. So it sounds like this controller is doing
> > something stupid.
> 
> Apparently my HW is broken... I got a hold of a DB1200 demoboard and
> the distributed version works fine there.

Actually, the bug is that because of MMC_RSP_R6 not being handled in
the switch in au1xmmc_send_command(), the controller gets told that
no response is expected. I changed the R6 to R1 in mmc.h, thats why
it worked in the demoboard, and it also works now on the previously
thought-to-be-broken HW.

So it's only broken in releases < 2.6.20-rc6.

Thanks,

-- 
 ml.
