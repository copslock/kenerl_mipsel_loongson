Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Sep 2017 14:38:01 +0200 (CEST)
Received: from mail-ua0-x242.google.com ([IPv6:2607:f8b0:400c:c08::242]:34982
        "EHLO mail-ua0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992974AbdIFMhxpJVXU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Sep 2017 14:37:53 +0200
Received: by mail-ua0-x242.google.com with SMTP id g47so2154640uad.2;
        Wed, 06 Sep 2017 05:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sLYlUeZtpI3iV1Qjj6bpzXgp+lrcbg4gZQQjXkq9ukA=;
        b=I7nkvYa1luqmkc0KxrToLWYIXOT0mTTL9aGRNFSTfirLnnpp/YH/P9iwgdpjl33LrW
         ZVGb4Wrz3deNgyNt8G2SBBmgaax7reSuu+YHlmuL9aqSxxxBVSs3+ufNkUnw8WMG7zHS
         JgEhwQep6w0mkDjCZuJye6AcN20U85CXrsQkvwvU9wwQPfwpsFl4MTroNjmJrlmYLN8Z
         tAl3oAKsJRBYWPzMhquVrj4K1fcrXLSwQMyReyRqpGdk0N7NIzsDR8A+fM7E+EkEXOvZ
         DMs1K6SSj7rmfuzGvwEfr9XgIiNBQG1w5l8N5z47g+M1cQtzigaMQ9I/uKEueHXxwPsv
         ti8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sLYlUeZtpI3iV1Qjj6bpzXgp+lrcbg4gZQQjXkq9ukA=;
        b=PBxQfzEZ39JHx/hXex2/rPyybX6GQoNBW9AgXyH6fbOQjaJlMER2zovWIV5ma+fFV+
         A7N3WtuvdZK2CFjQ4K5Lc+WqLZ/0P3ReVo2aRTXX+gGnB8JZaLgmhfqASgA4AHI7Mhwl
         j1CUz9AQeU42C7RIkoS6LVXTfVaC86cXfRWoo7aE/iq8Ay+7aUa3v/zEfRn/nPECMpQR
         AUITlyHrxzF6umiwVItbeuuV+Z69L6vSwQYNBsG07AuMtLzhZu2XDuuB/TuQlywZ0EWn
         rhu1XBHsgGJwjlroU6mbe2Qx2GXLk34VUD4ZGUW+rYXQlJnmBQYajXDXMSASIQ0iH3r1
         Vn4Q==
X-Gm-Message-State: AHPjjUja75kCp/6kj4ue0smQlPVe4yCGUWh8DX3mKuDdO4xXtiTx7iqE
        V75d/7MIGx1MUAAK3HYlkC7kz/CavQ==
X-Google-Smtp-Source: ADKCNb6klIhy32z1Uj0AMbWv1y1OZIvHN3wAsdZxoRcPdgTU0rsnRX2/HtjOqhw3AnmMp2sVwjWeV93AI1l9f+usrao=
X-Received: by 10.176.82.103 with SMTP id j36mr1714712uaa.156.1504701467663;
 Wed, 06 Sep 2017 05:37:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.28.81 with HTTP; Wed, 6 Sep 2017 05:37:27 -0700 (PDT)
In-Reply-To: <20170906121715.GA27869@kroah.com>
References: <20170802093429.12572-1-jonas.gorski@gmail.com>
 <20170802093429.12572-5-jonas.gorski@gmail.com> <CAOiHx=mC=GfX0VvuRWR-AmXYfVOEkuruwGHooS08WrL_z-60UA@mail.gmail.com>
 <20170906121715.GA27869@kroah.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Wed, 6 Sep 2017 14:37:27 +0200
Message-ID: <CAOiHx==oPYiALNL-cHNWCH+YMFswJt4uz-ob++5z+hMauWuRqQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] tty/bcm63xx_uart: allow naming clock in device tree
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Content-Type: text/plain; charset="UTF-8"
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59949
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

On 6 September 2017 at 14:17, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Wed, Sep 06, 2017 at 01:01:32PM +0200, Jonas Gorski wrote:
>> Hi Greg,
>>
>> On 2 August 2017 at 11:34, Jonas Gorski <jonas.gorski@gmail.com> wrote:
>> > Codify using a named clock for the refclk of the uart. This makes it
>> > easier if we might need to add a gating clock (like present on the
>> > BCM6345).
>> >
>> > Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
>>
>> Could I please get a (N)Ack so Ralf can add this patch to his tree?
>>
>>
>> Regards
>> Jonas
>>
>>
>> > ---
>> >  Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt | 6 ++++++
>> >  drivers/tty/serial/bcm63xx_uart.c                              | 6 ++++--
>> >  2 files changed, 10 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt b/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt
>> > index 5c52e5eef16d..8b2b0460259a 100644
>> > --- a/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt
>> > +++ b/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt
>> > @@ -11,6 +11,11 @@ Required properties:
>> >  - clocks: Clock driving the hardware; used to figure out the baud rate
>> >    divisor.
>> >
>> > +
>> > +Optional properties:
>> > +
>> > +- clock-names: Should be "refclk".
>> > +
>> >  Example:
>> >
>> >         uart0: serial@14e00520 {
>> > @@ -19,6 +24,7 @@ Example:
>> >                 interrupt-parent = <&periph_intc>;
>> >                 interrupts = <2>;
>> >                 clocks = <&periph_clk>;
>> > +               clock-names = "refclk";
>> >         };
>> >
>> >         clocks {
>
> I don't ack devtree changes :)
>
>> > diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
>> > index a2b9376ec861..f227eff28d3a 100644
>> > --- a/drivers/tty/serial/bcm63xx_uart.c
>> > +++ b/drivers/tty/serial/bcm63xx_uart.c
>> > @@ -841,8 +841,10 @@ static int bcm_uart_probe(struct platform_device *pdev)
>> >         if (!res_irq)
>> >                 return -ENODEV;
>> >
>> > -       clk = pdev->dev.of_node ? of_clk_get(pdev->dev.of_node, 0) :
>> > -                                 clk_get(&pdev->dev, "refclk");
>> > +       clk = clk_get(&pdev->dev, "refclk");
>> > +       if (IS_ERR(clk) && pdev->dev.of_node)
>> > +               clk = of_clk_get(pdev->dev.of_node, 0);
>> > +
>> >         if (IS_ERR(clk))
>> >                 return -ENODEV;
>> >
>
> This part is fine with me:

That's all I wanted :)
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thank you!


Jonas
