Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2015 04:05:58 +0100 (CET)
Received: from mail-ob0-f176.google.com ([209.85.214.176]:33368 "EHLO
        mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007444AbbKYDF41NjYM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Nov 2015 04:05:56 +0100
Received: by obbww6 with SMTP id ww6so29478464obb.0;
        Tue, 24 Nov 2015 19:05:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xVP0wtZa0Dehlc63vq5zRUA+CoDE2V0SNMthVxHbKzM=;
        b=b2nRX+M+pHlKzyGqVVzPWgB199PPwNnFGb3sDpmJP5gaQ+4dAOMWuFxUUGltE8M21O
         mXCA1Sm3GMxXHoFn0mh5QhSBzPku979eb9iay1q7fecFkoxK/yYgS/2fI8qrUHbLTJAP
         O6IJ5Tp/enj/shkmZ4rmSFqq1sYUyl5/Fn0vSYn3i/EEH3H5uA3qGNWFK7yJEXR7hBdg
         cKyIqx7iew5cp3Jom5fkc/Q1FgcpOKEpITjQOZ9ZnQx2w7+fUMRmumKs9EdhNZuZxUE3
         aQRhE7yMFiIZ/qrd4G3D+S6uwtngCbrxvO5Z5eO8DJ3C1CIBuFYQ/t5VBY2ZDpHYDcaZ
         Yprw==
X-Received: by 10.60.246.102 with SMTP id xv6mr23996139oec.55.1448420750716;
        Tue, 24 Nov 2015 19:05:50 -0800 (PST)
Received: from rob-hp-laptop (72-48-98-129.dyn.grandenetworks.net. [72.48.98.129])
        by smtp.gmail.com with ESMTPSA id x2sm9678781oer.3.2015.11.24.19.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2015 19:05:50 -0800 (PST)
Date:   Tue, 24 Nov 2015 21:05:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Simon Arlott <simon@fire.lp0.eu>
Cc:     Jonas Gorski <jogo@openwrt.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Miguel Gaio <miguel.gaio@efixo.com>,
        Maxime Bizon <mbizon@freebox.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-watchdog@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH (v2) 1/10] clocksource: Add brcm,bcm6345-timer device
 tree binding
Message-ID: <20151125030544.GA9933@rob-hp-laptop>
References: <5650BFD6.5030700@simon.arlott.org.uk>
 <CAOiHx=k0Aa+qrBT1J7_cQaQRxndBmwsgSgi3x0eJOYTAy6Zq7Q@mail.gmail.com>
 <5653612A.4050309@simon.arlott.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5653612A.4050309@simon.arlott.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Mon, Nov 23, 2015 at 06:55:38PM +0000, Simon Arlott wrote:
> Add device tree bindings for the BCM6345/BCM6318 timers. This is required
> for the BCM6345 watchdog which needs to respond to one of the timer
> interrupts.
> 
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>

Acked-by: Rob Herring <robh@kernel.org>

> ---
> On 23/11/15 15:33, Jonas Gorski wrote:
> > On Sat, Nov 21, 2015 at 8:02 PM, Simon Arlott <simon@fire.lp0.eu> wrote:
> >> +- compatible: should be "brcm,bcm<soc>-timer", "brcm,bcm6345-timer"
> > 
> > Since bcm6318 uses a slightly different register layout than the
> > earlier SoCs, I'd argue that using bcm6345-timer as a compatible for
> > bcm6318 is wrong.
> 
> I've split them out into two very similar bindings.
> 
> Patches 1/4 and 2/4 are replaced with (v2) 1/10 and (v2) 2/10.
> 
>  .../bindings/timer/brcm,bcm6318-timer.txt          | 44 ++++++++++++++++++++
>  .../bindings/timer/brcm,bcm6345-timer.txt          | 47 ++++++++++++++++++++++
>  2 files changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/brcm,bcm6318-timer.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/brcm,bcm6345-timer.txt
> 
> diff --git a/Documentation/devicetree/bindings/timer/brcm,bcm6318-timer.txt b/Documentation/devicetree/bindings/timer/brcm,bcm6318-timer.txt
> new file mode 100644
> index 0000000..cf4be7e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/brcm,bcm6318-timer.txt
> @@ -0,0 +1,44 @@
> +Broadcom BCM6318 Timer
> +
> +This block is a timer that is connected to multiple interrupts on the main
> +interrupt controller and functions as a programmable interrupt controller for
> +timer events. There is a main timer interrupt for all timers.
> +
> +- 4 independent timers with their own interrupt, and own maskable level
> +  interrupt bit in the main timer interrupt
> +
> +- 1 watchdog timer with an unmaskable level interrupt bit in the main timer
> +  interrupt
> +
> +- Contains one enable/status word pair
> +
> +- No atomic set/clear operations
> +
> +Required properties:
> +
> +- compatible: should be "brcm,bcm<soc>-timer", "brcm,bcm6318-timer"
> +- reg: specifies the base physical address and size of the registers, excluding
> +  the watchdog registers
> +- interrupt-controller: identifies the node as an interrupt controller
> +- #interrupt-cells: specifies the number of cells needed to encode an interrupt
> +  source, should be 1.
> +- interrupt-parent: specifies the phandle to the parent interrupt controller(s)
> +  this one is cascaded from
> +- interrupts: specifies the interrupt line(s) in the interrupt-parent controller
> +  node for the main timer interrupt, followed by the individual timer
> +  interrupts; valid values depend on the type of parent interrupt controller
> +- clocks: phandle of timer reference clock (periph)
> +
> +Example:
> +
> +timer: timer@10000040 {
> +	compatible = "brcm,bcm63148-timer", "brcm,bcm6318-timer";
> +	reg = <0x10000040 0x28>;
> +
> +	interrupt-controller;
> +	#interrupt-cells = <1>;
> +
> +	interrupt-parent = <&periph_intc>;
> +	interrupts = <31>, <0>, <1>, <2>, <3>;
> +	clock = <&periph_osc>;
> +};
> diff --git a/Documentation/devicetree/bindings/timer/brcm,bcm6345-timer.txt b/Documentation/devicetree/bindings/timer/brcm,bcm6345-timer.txt
> new file mode 100644
> index 0000000..03250dd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/brcm,bcm6345-timer.txt
> @@ -0,0 +1,47 @@
> +Broadcom BCM6345 Timer
> +
> +This block is a timer that is connected to one interrupt on the main interrupt
> +controller and functions as a programmable interrupt controller for timer
> +events.
> +
> +- 3 independent timers with their own maskable level interrupt bit (but not
> +  per CPU because there is only one parent interrupt and the timers share it)
> +
> +- 1 watchdog timer with an unmaskable level interrupt
> +
> +- Contains one enable/status word pair
> +
> +- No atomic set/clear operations
> +
> +The lack of per CPU ability of timers makes them unusable as a set of
> +clockevent devices, otherwise they could be attached to the remaining
> +interrupts.
> +
> +Required properties:
> +
> +- compatible: should be "brcm,bcm<soc>-timer", "brcm,bcm6345-timer"
> +- reg: specifies the base physical address and size of the registers, excluding
> +  the watchdog registers
> +- interrupt-controller: identifies the node as an interrupt controller
> +- #interrupt-cells: specifies the number of cells needed to encode an interrupt
> +  source, should be 1.
> +- interrupt-parent: specifies the phandle to the parent interrupt controller(s)
> +  this one is cascaded from
> +- interrupts: specifies the interrupt line(s) in the interrupt-parent controller
> +  node for the timer interrupt; valid values depend on the type of parent
> +  interrupt controller
> +- clocks: phandle of timer reference clock (periph)
> +
> +Example:
> +
> +timer: timer@10000080 {
> +	compatible = "brcm,bcm63168-timer", "brcm,bcm6345-timer";
> +	reg = <0x10000080 0x1c>;
> +
> +	interrupt-controller;
> +	#interrupt-cells = <1>;
> +
> +	interrupt-parent = <&periph_intc>;
> +	interrupts = <0>;
> +	clock�=�<&periph_osc>;
> +};
> -- 
> 2.1.4
> 
> -- 
> Simon Arlott
