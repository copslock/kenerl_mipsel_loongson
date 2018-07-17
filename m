Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jul 2018 14:31:27 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:46425 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993030AbeGQMbYMiDqd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Jul 2018 14:31:24 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7267E20765; Tue, 17 Jul 2018 14:31:18 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4315B207B4;
        Tue, 17 Jul 2018 14:31:08 +0200 (CEST)
Date:   Tue, 17 Jul 2018 14:31:08 +0200
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
Subject: Re: [PATCH 1/5] i2c: designware: factorize setting SDA hold time
Message-ID: <20180717123108.GA23935@piout.net>
References: <20180717114837.21839-1-alexandre.belloni@bootlin.com>
 <20180717114837.21839-2-alexandre.belloni@bootlin.com>
 <5a1846aa7c03cc889f072d1aab6967ff254b49de.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a1846aa7c03cc889f072d1aab6967ff254b49de.camel@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64881
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

On 17/07/2018 15:11:50+0300, Andy Shevchenko wrote:
> On Tue, 2018-07-17 at 13:48 +0200, Alexandre Belloni wrote:
> > Factorize setting the SDA hold time in a new function
> > i2c_dw_set_sda_hold_time() that is used for both master and slave
> > mode.
> > 
> > This conveniently pulls the fix for the spurious warning from commit
> > 7a20e707aae2 ("i2c: designware: suppress unneeded SDA hold time
> > warnings")
> > in slave mode.
> 
> Isn't this a duplication of 
> 
> commit 1080ee7e28e1cea86310739e5dd4612868768aed
> Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Date:   Tue Jun 19 14:23:22 2018 +0300
> 
>     i2c: designware: Move SDA hold time configuration to common code
> 
> ?
> 

Indeed, I was on 4.18-rc1, not -next.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
