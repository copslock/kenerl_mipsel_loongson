Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jul 2018 20:44:21 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:55896 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993081AbeGaSoSgwryz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jul 2018 20:44:18 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 92944207AA; Tue, 31 Jul 2018 20:44:11 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 693A9206A8;
        Tue, 31 Jul 2018 20:44:01 +0200 (CEST)
Date:   Tue, 31 Jul 2018 20:44:02 +0200
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
Message-ID: <20180731184402.GY28585@piout.net>
References: <20180731134740.441-1-alexandre.belloni@bootlin.com>
 <20180731134740.441-2-alexandre.belloni@bootlin.com>
 <44e52856371e4b5c102df8f2efebd527fd26b066.camel@linux.intel.com>
 <0559c93256ae4f59aed278912bcbfd996e279839.camel@linux.intel.com>
 <20180731143059.GV28585@piout.net>
 <1cbe4c184a0a6db1fc5401dbd8bd3a9f6bf22527.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cbe4c184a0a6db1fc5401dbd8bd3a9f6bf22527.camel@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65335
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

On 31/07/2018 17:53:17+0300, Andy Shevchenko wrote:
> On Tue, 2018-07-31 at 16:30 +0200, Alexandre Belloni wrote:
> > On 31/07/2018 17:23:04+0300, Andy Shevchenko wrote:
> > > On Tue, 2018-07-31 at 17:02 +0300, Andy Shevchenko wrote:
> > > > On Tue, 2018-07-31 at 15:47 +0200, Alexandre Belloni wrote:
>  
> > > > > +	dev->flags |= (u32)device_get_match_data(&pdev->dev);
> > > > > +
> > > 
> > > And since it would be changed anyway, can you actually move this
> > > line
> > > closet to  if (has_acpi_companion()) one ?
> > > 
> > 
> > I need that value to be set before calling of_configure though.
> 
> AFAICS, you added those lines later, so, it would be something like
> 
> dev->flags |= ...
> 
> if (of_node)
>  of_configure()
> if (has_acpi_companion())
>  acpi_configure()
> 
> Would it work for you?
> 

Works for me, I'll send v3 soon.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
