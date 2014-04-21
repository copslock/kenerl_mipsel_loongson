Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Apr 2014 23:29:58 +0200 (CEST)
Received: from mail-out.m-online.net ([212.18.0.9]:59510 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6815921AbaDUV3y5hKp3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Apr 2014 23:29:54 +0200
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
        by mail-out.m-online.net (Postfix) with ESMTP id 3gCLf414v0z4KK36;
        Mon, 21 Apr 2014 23:29:47 +0200 (CEST)
X-Auth-Info: 4orBAbtNI5hwJA61HdUBhJQ/+k6wYLVxqnnl4tbppoA=
Received: from chi.localnet (unknown [195.140.253.167])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mnet-online.de (Postfix) with ESMTPSA id 3gCLf367qKzbbfT;
        Mon, 21 Apr 2014 23:29:47 +0200 (CEST)
From:   Marek Vasut <marex@denx.de>
To:     Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 0/5] defconfigs: add MTD_SPI_NOR (dependency for M25P80)
Date:   Mon, 21 Apr 2014 16:52:39 +0200
User-Agent: KMail/1.13.7 (Linux/3.13-trunk-amd64; KDE/4.11.3; x86_64; ; )
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org,
        Russell King <linux@arm.linux.org.uk>,
        Shawn Guo <shawn.guo@freescale.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        Steven Miao <realmz6@gmail.com>,
        adi-buildroot-devel@lists.sourceforge.net,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org
References: <1397719309-2022-1-git-send-email-computersforpeace@gmail.com> <20140417105302.GA32603@ulmo> <20140418063054.GK5512@norris-Latitude-E6410>
In-Reply-To: <20140418063054.GK5512@norris-Latitude-E6410>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201404211652.39704.marex@denx.de>
Return-Path: <marex@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39879
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

On Friday, April 18, 2014 at 08:30:54 AM, Brian Norris wrote:
> Hi,
> 
> On Thu, Apr 17, 2014 at 12:53:03PM +0200, Thierry Reding wrote:
> > On Thu, Apr 17, 2014 at 12:21:44AM -0700, Brian Norris wrote:
> > > We are introducing a new SPI-NOR library/framework for MTD, to support
> > > various types of SPI-NOR flash controllers which require (or benefit
> > > from) intimate knowledge of the flash interface, rather than just the
> > > relatively dumb SPI interface. This library borrows much of the m25p80
> > > driver for its abstraction and moves this code into a spi-nor module.
> > 
> > If this is a common library, then the more common approach to solve this
> > would be to have each driver that uses it to select MTD_SPI_NOR rather
> > than depend on it. That way you can drop this whole series to update the
> > default configurations.
> 
> But does MTD_SPI_NOR (and drivers/mtd/spi-nor/) qualify as a "library"
> or as a "subsystem"? I thought the latter were typically expected to be
> user-selectable options, not automatically-"select"ed.

I agree the "subsystem" is user-selectable while the "library" is to be 
'select'ed .

> I would say that, except for its age, MTD_SPI_NOR is very similar in to
> MTD_NAND (driver/mtd/nand/), which I'd consider a kind of subsystem, and
> which users must select before they are asked about drivers which fall
> under its category.
> 
> Perhaps my usage of the word "library" in the description was a mistake,
> as I don't exactly consider it like a library in the sense of many other
> "select"ed libraries.

It did look like a library to me at first, but it's rather a subsystem that 
contains a small library in it. Thus, I retract my previous comment about using 
'select' and add :

Acked-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
