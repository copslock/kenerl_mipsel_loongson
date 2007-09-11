Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2007 22:43:49 +0100 (BST)
Received: from tim.rpsys.net ([194.106.48.114]:48297 "EHLO tim.rpsys.net")
	by ftp.linux-mips.org with ESMTP id S20022340AbXIKVnk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 11 Sep 2007 22:43:40 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id l8BLhZr0029908;
	Tue, 11 Sep 2007 22:43:35 +0100
Received: from tim.rpsys.net ([127.0.0.1])
 by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 29681-06; Tue, 11 Sep 2007 22:43:31 +0100 (BST)
Received: from [192.168.1.15] (max.rpnet.com [192.168.1.15])
	(authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id l8BLhU9j029902
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Tue, 11 Sep 2007 22:43:30 +0100
Subject: Re: [PATCH][MIPS][4/7] AR7: leds driver
From:	Richard Purdie <rpurdie@rpsys.net>
To:	Matteo Croce <technoboy85@gmail.com>
Cc:	linux-mips@linux-mips.org, Nicolas Thill <nico@openwrt.org>,
	openwrt-devel@lists.openwrt.org,
	Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <200709080220.49064.technoboy85@gmail.com>
References: <200709080143.12345.technoboy85@gmail.com>
	 <200709080220.49064.technoboy85@gmail.com>
Content-Type: text/plain
Date:	Tue, 11 Sep 2007 22:43:29 +0100
Message-Id: <1189547009.6163.81.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.1 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: amavisd-new at rpsys.net
Return-Path: <rpurdie@rpsys.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rpurdie@rpsys.net
Precedence: bulk
X-list: linux-mips

On Sat, 2007-09-08 at 02:20 +0200, Matteo Croce wrote:
> Support for the leds in front of the board usually used to show power
> status, network traffic, connected eth devices etc.
> 
> Signed-off-by: Matteo Croce <technoboy85@gmail.com>
> Signed-off-by: Nicolas Thill <nico@openwrt.org>

The usual approach to drivers like this is to add the device definition
(ar7_leds_device) to the platform specific code which is probably in
arch/mips/ somewhere? See arch/arm/mach-pxa/{corgi|poodle|spitz}.c for
example.

Also, does MIPS have any kind of generic GPIO framework? A quick look at
the code suggests you might be able to use drivers/leds/leds-gpio.c
although you might need to add a definition of gpio_set_value_cansleep()
since MIPS appears to lack it.

Regards,

Richard
(LED Maintainer)
