Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jul 2011 20:47:32 +0200 (CEST)
Received: from charlotte.tuxdriver.com ([70.61.120.58]:40924 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491175Ab1GMSrZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jul 2011 20:47:25 +0200
Received: from uucp by smtp.tuxdriver.com with local-rmail (Exim 4.63)
        (envelope-from <linville@tuxdriver.com>)
        id 1Qh4SX-0001pT-SI; Wed, 13 Jul 2011 14:46:57 -0400
Received: from linville-8530p.local (linville-8530p.local [127.0.0.1])
        by linville-8530p.local (8.14.4/8.14.4) with ESMTP id p6DIXUwF030810;
        Wed, 13 Jul 2011 14:33:30 -0400
Received: (from linville@localhost)
        by linville-8530p.local (8.14.4/8.14.4/Submit) id p6DIXRBE030808;
        Wed, 13 Jul 2011 14:33:27 -0400
Date:   Wed, 13 Jul 2011 14:33:27 -0400
From:   "John W. Linville" <linville@tuxdriver.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-wireless@vger.kernel.org,
        zajec5@gmail.com, linux-mips@linux-mips.org, mb@bu3sch.de,
        george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com,
        arnd@arndb.de, julian.calaby@gmail.com, sshtylyov@mvista.com
Subject: Re: [PATCH 00/11] bcma: add support for embedded devices like bcm4716
Message-ID: <20110713183327.GD27827@tuxdriver.com>
References: <1310209563-6405-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1310209563-6405-1-git-send-email-hauke@hauke-m.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30613
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linville@tuxdriver.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9601

On Sat, Jul 09, 2011 at 01:05:52PM +0200, Hauke Mehrtens wrote:
> This patch series adds support for embedded devices like bcm47xx to 
> bcma. Bcma is used on bcm4716 and bcm4718 SoCs as the system bus and
> replaced ssb used on older devices. With these patches my bcm4716 
> device boots up till it tries to access the flash, because the serial 
> flash chip is unsupported for now, this will be my next task. This adds 
> support for MIPS cores, interrupt configuration and the serial console.
> 
> These patches are not containing all functions needed to get the SoC to 
> fully work and support every feature, but it is a good start.
> These patches are now integrated in OpenWrt for everyone how wants to
> test them.
> 
> This was tested with a BCM4704 device (SoC with ssb bus), a BCM4716 
> device and a pcie wireless card supported by bcma.
> 
> 
> @Rafał: If you are fine with the bcma patches could you please give
> your Signed-off on them.

Rafał, ping?

-- 
John W. Linville		Someday the world will need a hero, and you
linville@tuxdriver.com			might be all we have.  Be ready.
