Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Apr 2014 08:31:08 +0200 (CEST)
Received: from mail-pa0-f51.google.com ([209.85.220.51]:44313 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816414AbaDRGbGjpdo- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Apr 2014 08:31:06 +0200
Received: by mail-pa0-f51.google.com with SMTP id kq14so1183609pab.10
        for <multiple recipients>; Thu, 17 Apr 2014 23:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=FYZmGBMHr72rEb02gslz6C0pKPGwXGZJp5PaQv2dG5Y=;
        b=RcrNT+zkMWG6wSVkHkEUsdgyGkBxR1DZq+OCuVPpHO9RZWsAb6UJHezF9s/b6EYegy
         iIS5Mwmo1+uwH0cDfwAWMEu0s/OHJRnhrse4Ue78JDKaPZHICdnaTxmplzjVSq1utXQI
         dzoQ6t86ojfNuvnMPhsIGuJLBh5gWcZ4/jhqcoVAZ1+PUm7c2oA1bLmMNwnd9iEu3O54
         mLOkP1/FmpnOjMLZjjXalaaW7Q/x/FYibUoewnwmeETFHSQh7SOuUV5TSWdTOxZ5ZPvM
         hcvwPgGTYTeVkn7J1BaPuvDrkQH8ChOxSG+sBv1hvMv1nkNlwyRYGF0eeJdQ+XZYQs75
         jo1w==
X-Received: by 10.66.254.3 with SMTP id ae3mr20355836pad.49.1397802659556;
        Thu, 17 Apr 2014 23:30:59 -0700 (PDT)
Received: from norris-Latitude-E6410 (cpe-98-154-223-43.socal.res.rr.com. [98.154.223.43])
        by mx.google.com with ESMTPSA id pv4sm57647650pbb.55.2014.04.17.23.30.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 17 Apr 2014 23:30:58 -0700 (PDT)
Date:   Thu, 17 Apr 2014 23:30:54 -0700
From:   Brian Norris <computersforpeace@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Marek Vasut <marex@denx.de>, linux-mtd@lists.infradead.org,
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
Subject: Re: [PATCH 0/5] defconfigs: add MTD_SPI_NOR (dependency for M25P80)
Message-ID: <20140418063054.GK5512@norris-Latitude-E6410>
References: <1397719309-2022-1-git-send-email-computersforpeace@gmail.com>
 <20140417105302.GA32603@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140417105302.GA32603@ulmo>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39859
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: computersforpeace@gmail.com
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

Hi,

On Thu, Apr 17, 2014 at 12:53:03PM +0200, Thierry Reding wrote:
> On Thu, Apr 17, 2014 at 12:21:44AM -0700, Brian Norris wrote:
> > We are introducing a new SPI-NOR library/framework for MTD, to support various
> > types of SPI-NOR flash controllers which require (or benefit from) intimate
> > knowledge of the flash interface, rather than just the relatively dumb SPI
> > interface. This library borrows much of the m25p80 driver for its abstraction
> > and moves this code into a spi-nor module.
> 
> If this is a common library, then the more common approach to solve this
> would be to have each driver that uses it to select MTD_SPI_NOR rather
> than depend on it. That way you can drop this whole series to update the
> default configurations.

But does MTD_SPI_NOR (and drivers/mtd/spi-nor/) qualify as a "library"
or as a "subsystem"? I thought the latter were typically expected to be
user-selectable options, not automatically-"select"ed.

I would say that, except for its age, MTD_SPI_NOR is very similar in to
MTD_NAND (driver/mtd/nand/), which I'd consider a kind of subsystem, and
which users must select before they are asked about drivers which fall
under its category.

Perhaps my usage of the word "library" in the description was a mistake,
as I don't exactly consider it like a library in the sense of many other
"select"ed libraries.

Brian
