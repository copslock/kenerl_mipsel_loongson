Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Sep 2017 14:17:35 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:39140 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992262AbdIFMRX5Js42 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Sep 2017 14:17:23 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6422295E;
        Wed,  6 Sep 2017 12:17:14 +0000 (UTC)
Date:   Wed, 6 Sep 2017 14:17:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        "David S. Miller" <davem@davemloft.net>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH 4/8] tty/bcm63xx_uart: allow naming clock in device tree
Message-ID: <20170906121715.GA27869@kroah.com>
References: <20170802093429.12572-1-jonas.gorski@gmail.com>
 <20170802093429.12572-5-jonas.gorski@gmail.com>
 <CAOiHx=mC=GfX0VvuRWR-AmXYfVOEkuruwGHooS08WrL_z-60UA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOiHx=mC=GfX0VvuRWR-AmXYfVOEkuruwGHooS08WrL_z-60UA@mail.gmail.com>
User-Agent: Mutt/1.9.0 (2017-09-02)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59946
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

On Wed, Sep 06, 2017 at 01:01:32PM +0200, Jonas Gorski wrote:
> Hi Greg,
> 
> On 2 August 2017 at 11:34, Jonas Gorski <jonas.gorski@gmail.com> wrote:
> > Codify using a named clock for the refclk of the uart. This makes it
> > easier if we might need to add a gating clock (like present on the
> > BCM6345).
> >
> > Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> 
> Could I please get a (N)Ack so Ralf can add this patch to his tree?
> 
> 
> Regards
> Jonas
> 
> 
> > ---
> >  Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt | 6 ++++++
> >  drivers/tty/serial/bcm63xx_uart.c                              | 6 ++++--
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt b/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt
> > index 5c52e5eef16d..8b2b0460259a 100644
> > --- a/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt
> > +++ b/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt
> > @@ -11,6 +11,11 @@ Required properties:
> >  - clocks: Clock driving the hardware; used to figure out the baud rate
> >    divisor.
> >
> > +
> > +Optional properties:
> > +
> > +- clock-names: Should be "refclk".
> > +
> >  Example:
> >
> >         uart0: serial@14e00520 {
> > @@ -19,6 +24,7 @@ Example:
> >                 interrupt-parent = <&periph_intc>;
> >                 interrupts = <2>;
> >                 clocks = <&periph_clk>;
> > +               clock-names = "refclk";
> >         };
> >
> >         clocks {

I don't ack devtree changes :)

> > diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
> > index a2b9376ec861..f227eff28d3a 100644
> > --- a/drivers/tty/serial/bcm63xx_uart.c
> > +++ b/drivers/tty/serial/bcm63xx_uart.c
> > @@ -841,8 +841,10 @@ static int bcm_uart_probe(struct platform_device *pdev)
> >         if (!res_irq)
> >                 return -ENODEV;
> >
> > -       clk = pdev->dev.of_node ? of_clk_get(pdev->dev.of_node, 0) :
> > -                                 clk_get(&pdev->dev, "refclk");
> > +       clk = clk_get(&pdev->dev, "refclk");
> > +       if (IS_ERR(clk) && pdev->dev.of_node)
> > +               clk = of_clk_get(pdev->dev.of_node, 0);
> > +
> >         if (IS_ERR(clk))
> >                 return -ENODEV;
> >

This part is fine with me:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
