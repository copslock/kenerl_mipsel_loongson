Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Jan 2018 15:07:19 +0100 (CET)
Received: from mail.free-electrons.com ([62.4.15.54]:52077 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993599AbeAIOHMhRS4l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Jan 2018 15:07:12 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id AE8532072F; Tue,  9 Jan 2018 15:07:04 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 81F27206A6;
        Tue,  9 Jan 2018 15:07:04 +0100 (CET)
Date:   Tue, 9 Jan 2018 15:07:05 +0100
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] pinctrl: Add Microsemi Ocelot SoC driver
Message-ID: <20180109140705.GC2719@piout.net>
References: <CACRpkdZ=+pFZYteq=wM=z-CGejY+dX_SqhtDbbGBn+q60arQ4w@mail.gmail.com>
 <20180106000926.13770-1-alexandre.belloni@free-electrons.com>
 <CACRpkdaCfjW7hWS1VnC6MR+j48=Q0uo7OSMA_6G90D7Cz7NMZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdaCfjW7hWS1VnC6MR+j48=Q0uo7OSMA_6G90D7Cz7NMZA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Return-Path: <alexandre.belloni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@free-electrons.com
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

On 09/01/2018 at 14:56:36 +0100, Linus Walleij wrote:
> On Sat, Jan 6, 2018 at 1:09 AM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
> 
> > The Microsemi Ocelot SoC has a few pins that can be used as GPIOs or take
> > multiple other functions. Add a driver for the pinmuxing and the GPIOs.
> >
> > There is currently no support for interrupts.
> >
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > ---
> >  - use  pinctrl_gpio_direction_input/output from
> >    ocelot_gpio_direction_input/output
> >  - add a comment for ALT0/ALT1
> >  - fill .max_register of ocelot_pinctrl_regmap_config
> 
> Patch applied. And it looks very good too.
> 
> This was all I had to do, right? No dependent patches?
> 

Nothing more for you, thanks! I'll get back to this driver if there is
interest in having IRQ support but I don't think this will happen soon.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
