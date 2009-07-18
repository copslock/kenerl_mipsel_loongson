Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Jul 2009 21:09:44 +0200 (CEST)
Received: from mailrelay010.isp.belgacom.be ([195.238.6.177]:3546 "EHLO
	mailrelay010.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493103AbZGRTJh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 18 Jul 2009 21:09:37 +0200
X-Belgacom-Dynamic: yes
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAAa5YUpR93io/2dsb2JhbADMUwmEAwU
Received: from 168.120-247-81.adsl-dyn.isp.belgacom.be (HELO infomag) ([81.247.120.168])
  by relay.skynet.be with ESMTP; 18 Jul 2009 21:09:31 +0200
Received: from wim by infomag with local (Exim 4.69)
	(envelope-from <wim@infomag.iguana.be>)
	id 1MSFHn-0002ev-2h; Sat, 18 Jul 2009 21:09:31 +0200
Date:	Sat, 18 Jul 2009 21:09:31 +0200
From:	Wim Van Sebroeck <wim@iguana.be>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] ar7_wdt: convert to become a platform driver
Message-ID: <20090718190930.GC23797@infomag.iguana.be>
References: <200907151210.20294.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200907151210.20294.florian@openwrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <wim@iguana.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23751
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wim@iguana.be
Precedence: bulk
X-list: linux-mips

Hi Florian,

> This patch converts the ar7_wdt driver to become a platform
> driver. The AR7 SoC specific identification and base register
> calculation is performed by the board code, therefore we no
> longer need to have access to ar7_chip_id.

> @@ -298,22 +285,33 @@ static struct miscdevice ar7_wdt_miscdev = {
>  	.fops		= &ar7_wdt_fops,
>  };
>  
> -static int __init ar7_wdt_init(void)
> +static int __init ar7_wdt_probe(struct platform_device *pdev)

Should be __devinit .

> +static struct platform_driver ar7_wdt_driver = {
> +	.driver.name = "ar7_wdt",
> +	.probe = ar7_wdt_probe,
> +	.remove = __devexit_p(ar7_wdt_remove),
> +};

I prefer to have it as follows (so that the driver.owner field is also set):
static struct platform_driver ar7_wdt_driver = {
	.probe = ar7_wdt_probe,
	.remove = __devexit_p(ar7_wdt_remove),
	.driver = {
		.owner = THIS_MODULE,
		.name = "ar7_wdt",
	},
};

I suggest to also change the reboot notifier code into a platform shutdown method.
You then get something like the attached patch (untested, uncompiled and I included above 2 remarks).
For the rest: code is OK for me. After the __init to __devinit fix you can add my signed-off-by.

Kind regards,
Wim.
