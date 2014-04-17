Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Apr 2014 13:23:57 +0200 (CEST)
Received: from mail-out.m-online.net ([212.18.0.9]:53424 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834698AbaDQLXzXdGk5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Apr 2014 13:23:55 +0200
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
        by mail-out.m-online.net (Postfix) with ESMTP id 3g8dNj0nGZz4KK4F;
        Thu, 17 Apr 2014 13:23:48 +0200 (CEST)
X-Auth-Info: yvl9lennTYmo+vFVGEajPQ7NwMAdHkSsvBu09lrL1oQ=
Received: from chi.localnet (unknown [195.140.253.167])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mnet-online.de (Postfix) with ESMTPSA id 3g8dNh5lbBzbbl2;
        Thu, 17 Apr 2014 13:23:48 +0200 (CEST)
From:   Marek Vasut <marex@denx.de>
To:     Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 0/5] defconfigs: add MTD_SPI_NOR (dependency for M25P80)
Date:   Thu, 17 Apr 2014 13:07:44 +0200
User-Agent: KMail/1.13.7 (Linux/3.13-trunk-amd64; KDE/4.11.3; x86_64; ; )
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org,
        Russell King <linux@arm.linux.org.uk>,
        Shawn Guo <shawn.guo@freescale.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        Steven Miao <realmz6@gmail.com>,
        adi-buildroot-devel@lists.sourceforge.net,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org
References: <1397719309-2022-1-git-send-email-computersforpeace@gmail.com>
In-Reply-To: <1397719309-2022-1-git-send-email-computersforpeace@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201404171307.44214.marex@denx.de>
Return-Path: <marex@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39850
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marex@denx.de
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Thursday, April 17, 2014 at 09:21:44 AM, Brian Norris wrote:
> Hi all,
> 
> We are introducing a new SPI-NOR library/framework for MTD, to support
> various types of SPI-NOR flash controllers which require (or benefit from)
> intimate knowledge of the flash interface, rather than just the relatively
> dumb SPI interface. This library borrows much of the m25p80 driver for its
> abstraction and moves this code into a spi-nor module.
> 
> This means CONFIG_M25P80 now has a dependency on CONFIG_MTD_SPI_NOR, which
> should be added to the defconfigs. I'm not sure what is the best process
> for doing this. Should each $ARCH maintainer just take their respective
> patch, even if the MTD_SPI_NOR Kconfig symbol is not defined for them yet?
> Or should maintainers plan on merging the relevant SPI-NOR code into their
> trees during the development cycle? Or some third option?

Shouldn't the M25P80 driver just "select" the SPI NOR framework? Then you won't 
need the adjustment to defconfigs at all I think.

Best regards,
Marek Vasut
