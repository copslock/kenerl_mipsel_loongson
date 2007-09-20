Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2007 23:55:05 +0100 (BST)
Received: from tim.rpsys.net ([194.106.48.114]:21642 "EHLO tim.rpsys.net")
	by ftp.linux-mips.org with ESMTP id S20023903AbXITWy5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Sep 2007 23:54:57 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id l8KMsmg9020922;
	Thu, 20 Sep 2007 23:54:48 +0100
Received: from tim.rpsys.net ([127.0.0.1])
 by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 20598-09; Thu, 20 Sep 2007 23:54:44 +0100 (BST)
Received: from [192.168.1.15] (max.rpnet.com [192.168.1.15])
	(authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id l8KMsfU0020913
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Thu, 20 Sep 2007 23:54:41 +0100
Subject: Re: [PATCH][MIPS][4/7] AR7: leds driver
From:	Richard Purdie <rpurdie@rpsys.net>
To:	Matteo Croce <technoboy85@gmail.com>
Cc:	linux-mips@linux-mips.org, Nicolas Thill <nico@openwrt.org>,
	Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <200709201803.42734.technoboy85@gmail.com>
References: <200709201728.10866.technoboy85@gmail.com>
	 <200709201803.42734.technoboy85@gmail.com>
Content-Type: text/plain
Date:	Thu, 20 Sep 2007 23:54:41 +0100
Message-Id: <1190328881.5658.80.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.1 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: amavisd-new at rpsys.net
Return-Path: <rpurdie@rpsys.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16605
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rpurdie@rpsys.net
Precedence: bulk
X-list: linux-mips

On Thu, 2007-09-20 at 18:03 +0200, Matteo Croce wrote:
> Support for the leds in front of the board usually used to show power
> status, network traffic, connected eth devices etc.
> Will convert it to use leds-gpio when 2.6.23 will out.

Ok, I'll wait for the leds-gpio version before applying, thanks. 2.6.23
is due very soon...

Cheers,

Richard
