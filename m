Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Sep 2007 00:05:48 +0100 (BST)
Received: from tim.rpsys.net ([194.106.48.114]:64387 "EHLO tim.rpsys.net")
	by ftp.linux-mips.org with ESMTP id S20024218AbXITXFk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Sep 2007 00:05:40 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id l8KN5dsw021285;
	Fri, 21 Sep 2007 00:05:39 +0100
Received: from tim.rpsys.net ([127.0.0.1])
 by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 20969-08; Fri, 21 Sep 2007 00:05:35 +0100 (BST)
Received: from [192.168.1.15] (max.rpnet.com [192.168.1.15])
	(authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id l8KN5X9A021277
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Fri, 21 Sep 2007 00:05:34 +0100
Subject: Re: [PATCH][1/6] led: rename leds-cobalt
From:	Richard Purdie <rpurdie@rpsys.net>
To:	Florian Fainelli <florian.fainelli@telecomint.eu>
Cc:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <200709201617.12773.florian.fainelli@telecomint.eu>
References: <20070920230204.0ad15513.yoichi_yuasa@tripeaks.co.jp>
	 <200709201617.12773.florian.fainelli@telecomint.eu>
Content-Type: text/plain; charset=ISO-8859-1
Date:	Fri, 21 Sep 2007 00:05:33 +0100
Message-Id: <1190329533.5658.84.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.1 
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: amavisd-new at rpsys.net
Return-Path: <rpurdie@rpsys.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rpurdie@rpsys.net
Precedence: bulk
X-list: linux-mips

On Thu, 2007-09-20 at 16:17 +0200, Florian Fainelli wrote:
> Le jeudi 20 septembre 2007, Yoichi Yuasa a écrit :
> > The leds-cobalt driver only supports the Coable Qube series
> > (not included in Cobalt Raq series).
> > This patch has fixed Kconfig and renamed the driver.
> >
> > Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> >
> Acked-by: Florian Fainelli <florian.fainelli@telecomint.eu>
> 
> Thanks Yoichi !

I've queued this on in the LEDs tree.

Cheers,

Richard
