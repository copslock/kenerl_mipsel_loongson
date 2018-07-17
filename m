Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jul 2018 00:13:10 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:38620 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992891AbeGQWNHT-Qk8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Jul 2018 00:13:07 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 881EE206F6; Wed, 18 Jul 2018 00:13:01 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 41619206F3;
        Wed, 18 Jul 2018 00:13:01 +0200 (CEST)
Date:   Wed, 18 Jul 2018 00:13:01 +0200
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
Message-ID: <20180717221301.GF3211@piout.net>
References: <20180717142314.32337-1-alexandre.belloni@bootlin.com>
 <20180717142314.32337-2-alexandre.belloni@bootlin.com>
 <CAHp75Vc4SrMXznc6PSrO2Lfrc3gspu_g1QYjuFDWT9-J=C+bjw@mail.gmail.com>
 <CAHp75VfRS_gSv6x22M1TiTariUftF04sLyd84dQpxudOmT0s7w@mail.gmail.com>
 <20180717214212.GE3211@piout.net>
 <CAHp75VdEkQ=AC8xUBno7qp0E+cXqwq03WOtVB3sX+Z6zthDJSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdEkQ=AC8xUBno7qp0E+cXqwq03WOtVB3sX+Z6zthDJSw@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64908
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

On 18/07/2018 00:54:21+0300, Andy Shevchenko wrote:
> On Wed, Jul 18, 2018 at 12:42 AM, Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> > On 18/07/2018 00:30:49+0300, Andy Shevchenko wrote:
> >> On Wed, Jul 18, 2018 at 12:30 AM, Andy Shevchenko
> >> <andy.shevchenko@gmail.com> wrote:
> >> > On Tue, Jul 17, 2018 at 5:23 PM, Alexandre Belloni
> >> > <alexandre.belloni@bootlin.com> wrote:
> >>
> >> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >> >
> >> >> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> >>
> >> Shouldn't it have a Fixes tag?
> >>
> >
> > Well, I'm not sure how far this can be backported. It also seems nobody
> > ever hit that while our hardware will hit it at every boot.
> >
> > I'll try to find out.
> 
> No-one enabled CONFIG_DEBUG_SHIRQ?
> 

Nope, this is a real HW IRQ. I meant find out up to when it can be
sanely backported.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
