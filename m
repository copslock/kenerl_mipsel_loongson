Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jul 2018 22:41:44 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:59695 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993087AbeGaUllANXOh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jul 2018 22:41:41 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 574B820875; Tue, 31 Jul 2018 22:41:34 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2C22C207AB;
        Tue, 31 Jul 2018 22:41:24 +0200 (CEST)
Date:   Tue, 31 Jul 2018 22:41:25 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
Subject: Re: [PATCH v2 1/6] i2c: designware: use generic table matching
Message-ID: <20180731204125.GA1491@piout.net>
References: <20180731134740.441-1-alexandre.belloni@bootlin.com>
 <20180731134740.441-2-alexandre.belloni@bootlin.com>
 <44e52856371e4b5c102df8f2efebd527fd26b066.camel@linux.intel.com>
 <0559c93256ae4f59aed278912bcbfd996e279839.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0559c93256ae4f59aed278912bcbfd996e279839.camel@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
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

On 31/07/2018 17:23:04+0300, Andy Shevchenko wrote:
> On Tue, 2018-07-31 at 17:02 +0300, Andy Shevchenko wrote:
> > On Tue, 2018-07-31 at 15:47 +0200, Alexandre Belloni wrote:
> > > Switch to device_get_match_data in probe to match the device
> > > specific
> > > data
> > > instead of using the acpi specific function.
> > > 
> > 
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Oops. See below.
> 
> > > -	id = acpi_match_device(pdev->dev.driver->acpi_match_table,
> > > &pdev->dev);
> > > -	if (id && id->driver_data)
> > > -		dev->flags |= (u32)id->driver_data;
> 

I'll change that cast to (uintptr_t). Else gcc complains about the size
mismatch on 64 bit platform. I'm letting kbuild play with my branch a
bit before sending v3.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
