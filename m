Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Sep 2009 12:49:47 +0200 (CEST)
Received: from bamako.nerim.net ([62.4.17.28]:58852 "EHLO bamako.nerim.net"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492244AbZIJKtk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 10 Sep 2009 12:49:40 +0200
Received: from localhost (localhost [127.0.0.1])
	by bamako.nerim.net (Postfix) with ESMTP id E09B639DCB0;
	Thu, 10 Sep 2009 12:49:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at nerim.net
Received: from bamako.nerim.net ([127.0.0.1])
	by localhost (bamako.nerim.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 04+egjYJ86w8; Thu, 10 Sep 2009 12:49:36 +0200 (CEST)
Received: from hyperion.delvare (jdelvare.pck.nerim.net [62.212.121.182])
	by bamako.nerim.net (Postfix) with ESMTP id 96A1839DCA1;
	Thu, 10 Sep 2009 12:49:36 +0200 (CEST)
Date:	Thu, 10 Sep 2009 12:49:37 +0200
From:	Jean Delvare <khali@linux-fr.org>
To:	Wolfram Sang <w.sang@pengutronix.de>
Cc:	linux-i2c@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
	uclinux-dist-devel@blackfin.uclinux.org
Subject: Re: Removing deprecated drivers from drivers/i2c/chips
Message-ID: <20090910124937.7b3df062@hyperion.delvare>
In-Reply-To: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
References: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.14.4; i586-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <khali@linux-fr.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khali@linux-fr.org
Precedence: bulk
X-list: linux-mips

Hi Wolfram,

On Wed,  9 Sep 2009 23:22:47 +0200, Wolfram Sang wrote:
> continuing the quest to clean up and ultimately remove the drivers/i2c/chips
> directory, this patch series removes three drivers for GPIO-expanders which are
> obsoleted and marked as deprecated for more than a year. The newer (and better)
> drivers can be found in drivers/gpio.
> 
> As it is ensured that the newer drivers cover the same i2c_device_ids, all
> platform_devices will still match. Some defconfig updates may be necessary
> though, but according to [1] this is left to the arch|platform-maintainers
> (also as most defconfigs are quite outdated). For that reason, I put the
> relevant arch-mailing-lists to Cc. Comments are welcome.

Looks very good, I'll apply the 3 patches removing the legacy drivers.

Not sure about the patch to drivers/gpio/pcf857x.c, as there is no gpio
tree and no maintainer either AFAIK, I guess I shall pick it too?

Thanks,
-- 
Jean Delvare
