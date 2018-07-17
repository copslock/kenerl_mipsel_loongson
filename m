Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jul 2018 23:42:22 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:37656 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993032AbeGQVmQs5Yx8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Jul 2018 23:42:16 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6CFF2207AB; Tue, 17 Jul 2018 23:42:12 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4836B206A6;
        Tue, 17 Jul 2018 23:42:12 +0200 (CEST)
Date:   Tue, 17 Jul 2018 23:42:12 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
Subject: Re: [PATCH 1/5] spi: dw: fix possible race condition
Message-ID: <20180717214212.GE3211@piout.net>
References: <20180717142314.32337-1-alexandre.belloni@bootlin.com>
 <20180717142314.32337-2-alexandre.belloni@bootlin.com>
 <CAHp75Vc4SrMXznc6PSrO2Lfrc3gspu_g1QYjuFDWT9-J=C+bjw@mail.gmail.com>
 <CAHp75VfRS_gSv6x22M1TiTariUftF04sLyd84dQpxudOmT0s7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfRS_gSv6x22M1TiTariUftF04sLyd84dQpxudOmT0s7w@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64906
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

On 18/07/2018 00:30:49+0300, Andy Shevchenko wrote:
> On Wed, Jul 18, 2018 at 12:30 AM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, Jul 17, 2018 at 5:23 PM, Alexandre Belloni
> > <alexandre.belloni@bootlin.com> wrote:
> 
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >
> >> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> Shouldn't it have a Fixes tag?
> 

Well, I'm not sure how far this can be backported. It also seems nobody
ever hit that while our hardware will hit it at every boot.

I'll try to find out.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
