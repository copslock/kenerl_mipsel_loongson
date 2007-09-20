Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2007 23:51:26 +0100 (BST)
Received: from tim.rpsys.net ([194.106.48.114]:10122 "EHLO tim.rpsys.net")
	by ftp.linux-mips.org with ESMTP id S20024836AbXITWvR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Sep 2007 23:51:17 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id l8KMpHcO020799;
	Thu, 20 Sep 2007 23:51:17 +0100
Received: from tim.rpsys.net ([127.0.0.1])
 by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 20598-06; Thu, 20 Sep 2007 23:51:13 +0100 (BST)
Received: from [192.168.1.15] (max.rpnet.com [192.168.1.15])
	(authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id l8KMpBEf020792
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Thu, 20 Sep 2007 23:51:12 +0100
Subject: Re: [PATCH][2/6] led: add Cobalt Raq series LEDs support
From:	Richard Purdie <rpurdie@rpsys.net>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <20070920230322.6600dd83.yoichi_yuasa@tripeaks.co.jp>
References: <20070920230204.0ad15513.yoichi_yuasa@tripeaks.co.jp>
	 <20070920230322.6600dd83.yoichi_yuasa@tripeaks.co.jp>
Content-Type: text/plain
Date:	Thu, 20 Sep 2007 23:51:10 +0100
Message-Id: <1190328670.5658.77.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.1 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: amavisd-new at rpsys.net
Return-Path: <rpurdie@rpsys.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16604
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rpurdie@rpsys.net
Precedence: bulk
X-list: linux-mips

On Thu, 2007-09-20 at 23:03 +0900, Yoichi Yuasa wrote:
> Add Cobalt Raq series LEDs support.
> 
> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> 
[...]
> diff -pruN -X mips/Documentation/dontdiff mips-orig/drivers/leds/leds-cobalt-raq.c mips/drivers/leds/leds-cobalt-raq.c
> --- mips-orig/drivers/leds/leds-cobalt-raq.c	1970-01-01 09:00:00.000000000 +0900
> +++ mips/drivers/leds/leds-cobalt-raq.c	2007-09-14 13:06:03.900173500 +0900
> @@ -0,0 +1,135 @@
[...]
> +static void __iomem *led_port;
> +static u8 led_value;
> +static DEFINE_SPINLOCK(led_value_lock);
> +
> +static void raq_web_led_set(struct led_classdev *led_cdev,
> +                            enum led_brightness brightness)
> +{
> +	spin_lock_irq(&led_value_lock);
> +
> +	if (brightness)
> +		led_value |= LED_WEB;
> +	else
> +		led_value &= ~LED_WEB;
> +	writeb(led_value, led_port);
> +
> +	spin_unlock_irq(&led_value_lock);
> +}

You can't use the spin lock like that since the set function can get
called in interrupt context, you need to use irqsave/irqrestore
versions. I've already said this once...

Richard
