Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Dec 2015 22:04:41 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:52394 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007703AbbLDVEjWSy1S (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Dec 2015 22:04:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:To:From:Subject:Date:References:In-Reply-To:Message-ID; bh=dsQo1VWvYUpSLFtIn9dLnxkWykZSj69B5eoB6OeCQOE=;
        b=DDbyn5R/L9d1vGf/As6KjDAb+wKm4IG86LTm90eWwiQ0E3XtmMGMupeQtiqo6Byaul5uFyWE4FIN0ic9yA0ciPgmU3B4VnR7ebkspKu8Z1/8dNniWEh1t26QZlx8OoN7J9fTDAKwkSTPQlIWA+Z7W5ZVbEKNrkZazuethxELKCiubX3EzRhH2uIuFrXemswwE7zP3Q3j4S4vKoD+VwliY3V/M6XDb0ngFbIuYKfIACOIrx/aaI1zCCbVk3P/h6Zcy8d4gfv6vZN9Kc13hpl/otXyzMlry0ujAkYAgH7tIpDm2nhji8/r1FToIVk8bPgOPJJ8BnhC+eSivDxzfZI9cQ==;
Received: from lp0_webmail by proxima.lp0.eu with local 
        id 1a4xWj-0005n1-GD (Exim); Fri, 04 Dec 2015 21:04:26 +0000
Received: from simon by proxima.lp0.eu with https;
        Fri, 4 Dec 2015 21:04:25 -0000
Message-ID: <74d29bf38adc88b27811a70ed409e9182ddeb5b5@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
In-Reply-To: <20151204143037.GA3667@rob-hp-laptop>
References: <565CB727.7030209@simon.arlott.org.uk>
    <20151204143037.GA3667@rob-hp-laptop>
Date:   Fri, 4 Dec 2015 21:04:25 -0000
Subject: Re: [PATCH 1/2] clk: Add brcm,bcm63xx-gate-clk device tree binding
From:   "Simon Arlott" <simon@fire.lp0.eu>
To:     "Rob Herring" <robh@kernel.org>
Cc:     "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@codeaurora.org>,
        "Kevin Cernekee" <cernekee@gmail.com>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, linux-mips@linux-mips.org,
        "Pawel Moll" <pawel.moll@arm.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Ian Campbell" <ijc+devicetree@hellion.org.uk>,
        "Kumar Gala" <galak@codeaurora.org>
User-Agent: SquirrelMail/1.4.22
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: simon@fire.lp0.eu
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

On Fri, December 4, 2015 14:30, Rob Herring wrote:
> On Mon, Nov 30, 2015 at 08:52:55PM +0000, Simon Arlott wrote:
>> +periph_clk: periph_clk {
>> +	compatible = "brcm,bcm63168-gate-clk", "brcm,bcm63xx-gate-clk";
>> +	regmap = <&periph_cntl>;
>
> What else is in periph_cntrl? Could this all just be part of that node?

     uint32        RevID;             /* (00) word 0 */
     uint32        blkEnables;        /* (04) word 1 */ <-- gated clocks
     uint32        pll_control;       /* (08) word 2 */ <-- system reset controller bit
     uint32        deviceTimeoutEn;   /* (0c) word 3 */ <-- unknown
     uint32        softResetB;        /* (10) word 4 */ <-- device reset controller bits
    uint32        diagControl;        /* (14) word 5 */ <-- unknown
    uint32        ExtIrqCfg;          /* (18) word 6*/ <-- external interrupt controller
    uint32        unused1;            /* (1c) word 7 */ <-- (external interrupt controller?)
         IrqControl_t     IrqControl[3];    /* (20) (40) (60) */ <-- normal interrupt controller

So it has these clocks, two types of reset controller, and the interrupt
controllers, but I've left the interrupt controllers registers out of the
syscon device.

For the registers in the "timer" peripheral at the end of the timer/watchdog
registers:
    uint32        EnSwPLL; <-- unknown
    uint32        ClkRstCtl;
#define POR_RESET_STATUS            (1 << 31) <-- unknown
#define HW_RESET_STATUS             (1 << 30) <-- unknown
#define SW_RESET_STATUS             (1 << 29) <-- unknown
#define USB_REF_CLKEN               (1 << 18) <-- gated clock
#define UTO_EXTIN_CLKEN             (1 << 17) <-- gated clock
#define UTO_CLK50_SEL               (1 << 16) <-- looks like a clock frequency selection bit
#define FAP2_PLL_CLKEN              (1 << 15) <-- gated clock
#define FAP2_PLL_FREQ_SHIFT         12        <-- bits for controlling the frequency
#define FAP1_PLL_CLKEN              (1 << 11) <-- gated clock
#define FAP1_PLL_FREQ_SHIFT         8         <-- bits for controlling the frequency
#define WAKEON_DSL                  (1 << 7)  <-- wake on network bit
#define WAKEON_EPHY                 (1 << 6)  <-- wake on network bit
#define DSL_ENERGY_DETECT_ENABLE    (1 << 4)  <-- energy saving control for network
#define GPHY_1_ENERGY_DETECT_ENABLE (1 << 3)  <-- energy saving control for network
#define EPHY_3_ENERGY_DETECT_ENABLE (1 << 2)  <-- energy saving control for network
#define EPHY_2_ENERGY_DETECT_ENABLE (1 << 1)  <-- energy saving control for network
#define EPHY_1_ENERGY_DETECT_ENABLE (1 << 0)  <-- energy saving control for network

I need the usb_ref clock for USB, and I want to be able to disable
uto_extin, fap1 and fap2 as they're unused by anything in the device tree.

The full list of registers is here:
https://github.com/lp0/bcm963xx_4.12L.06B_consumer/blob/master/shared/opensource/include/bcm963xx/63268_map_part.h

-- 
Simon Arlott
