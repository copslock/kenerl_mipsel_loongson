Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Sep 2009 23:23:59 +0200 (CEST)
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41251 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493463AbZIIVXx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 9 Sep 2009 23:23:53 +0200
Received: from themisto.ext.pengutronix.de ([92.198.50.58] helo=pengutronix.de)
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <w.sang@pengutronix.de>)
	id 1MlUdc-00008N-Bh; Wed, 09 Sep 2009 23:23:41 +0200
From:	Wolfram Sang <w.sang@pengutronix.de>
To:	linux-i2c@vger.kernel.org
Cc:	linuxppc-dev@ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@linux-mips.org, uclinux-dist-devel@blackfin.uclinux.org
Date:	Wed,  9 Sep 2009 23:22:47 +0200
Message-Id: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
X-Mailer: git-send-email 1.6.3.3
X-SA-Exim-Connect-IP: 92.198.50.58
X-SA-Exim-Mail-From: w.sang@pengutronix.de
Subject: Removing deprecated drivers from drivers/i2c/chips
X-SA-Exim-Version: 4.2.1 (built Tue, 09 Jan 2007 17:23:22 +0000)
X-SA-Exim-Scanned: Yes (on metis.ext.pengutronix.de)
X-PTX-Original-Recipient: linux-mips@linux-mips.org
Return-Path: <w.sang@pengutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w.sang@pengutronix.de
Precedence: bulk
X-list: linux-mips

Hi,

continuing the quest to clean up and ultimately remove the drivers/i2c/chips
directory, this patch series removes three drivers for GPIO-expanders which are
obsoleted and marked as deprecated for more than a year. The newer (and better)
drivers can be found in drivers/gpio.

As it is ensured that the newer drivers cover the same i2c_device_ids, all
platform_devices will still match. Some defconfig updates may be necessary
though, but according to [1] this is left to the arch|platform-maintainers
(also as most defconfigs are quite outdated). For that reason, I put the
relevant arch-mailing-lists to Cc. Comments are welcome.

Regards,

   Wolfram

[1] http://lkml.org/lkml/2009/5/7/34
