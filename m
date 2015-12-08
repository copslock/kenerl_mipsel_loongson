Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2015 13:24:25 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:59505 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006859AbbLHMYW5tNIb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Dec 2015 13:24:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:To:From:Subject:Date:References:In-Reply-To:Message-ID; bh=lQONCrf/5R+BsfYDFK6dTH5KTAKhp8ZUQtH9hfJV6DM=;
        b=hF5AZ4j9zBn8c433oYe122nolQgp9xZU9DAdcz0jTxcH6ld5r0wjK/qTo/zexvK0qbeSey6n8UcVo9WhCnykDQ53wABPyFB1tb19gFq7QD0DRkwahDYss/rRc+IsfR+ViM6lNJZdeWndZx8kZ2KmDAjZCu7w6vLxQkwbIMbQVoaA0lwGv1PNFOtuC0f8eWPSwO6GBBdBO/P40wCkAYPUojHpdFIPZ9ZdYkIdpMkJ7QXer0VhWrX4dYerZ5dtheomqlC0WF6vYiBhU3AVkuSp49sZRwglMTTmAsr62A6iwaL398vOpdDvxXjxczUfG1N12hel5N5pgnZMyNIEtbEeLg==;
Received: from lp0_webmail by proxima.lp0.eu with local 
        id 1a6HJS-0002ab-PH (Exim); Tue, 08 Dec 2015 12:24:11 +0000
Received: from simon by proxima.lp0.eu with https;
        Tue, 8 Dec 2015 12:24:10 -0000
Message-ID: <5efe63830cae4e3e5d1b3be5c489da0bfee8dfff@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
In-Reply-To: <74d29bf38adc88b27811a70ed409e9182ddeb5b5@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
References: <565CB727.7030209@simon.arlott.org.uk>
    <20151204143037.GA3667@rob-hp-laptop>
    <74d29bf38adc88b27811a70ed409e9182ddeb5b5@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
Date:   Tue, 8 Dec 2015 12:24:10 -0000
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
X-archive-position: 50422
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

On Fri, December 4, 2015 21:04, Simon Arlott wrote:
> On Fri, December 4, 2015 14:30, Rob Herring wrote:
>> On Mon, Nov 30, 2015 at 08:52:55PM +0000, Simon Arlott wrote:
>>> +periph_clk: periph_clk {
>>> +	compatible = "brcm,bcm63168-gate-clk", "brcm,bcm63xx-gate-clk";
>>> +	regmap = <&periph_cntl>;
>>
>> What else is in periph_cntrl? Could this all just be part of that node?
>
>      uint32        RevID;             /* (00) word 0 */
>      uint32        blkEnables;        /* (04) word 1 */ <-- gated clocks
>      uint32        pll_control;       /* (08) word 2 */ <-- system reset controller bit
>      uint32        deviceTimeoutEn;   /* (0c) word 3 */ <-- unknown
>      uint32        softResetB;        /* (10) word 4 */ <-- device reset controller bits
>     uint32        diagControl;        /* (14) word 5 */ <-- unknown
>     uint32        ExtIrqCfg;          /* (18) word 6*/ <-- external interrupt controller
>     uint32        unused1;            /* (1c) word 7 */ <-- (external interrupt controller?)
>          IrqControl_t     IrqControl[3];    /* (20) (40) (60) */ <-- normal interrupt controller

On the BCM6368 [1], blkEnables also conatains a power domain bit:
     uint32        blkEnables;        /* (04) word 1 */
#define USBH_IDDQ_EN     (1 << 19)
#define IPSEC_CLK_EN     (1 << 18)
#define NAND_CLK_EN      (1 << 17)
#define DISABLE_GLESS    (1 << 16)
#define USBH_CLK_EN      (1 << 15)
#define PCM_CLK_EN       (1 << 14)
#define UTOPIA_CLK_EN    (1 << 13)
#define ROBOSW_CLK_EN    (1 << 12)
#define SAR_CLK_EN       (1 << 11)
#define USBD_CLK_EN      (1 << 10)
#define SPI_CLK_EN       (1 << 9)
#define SWPKT_SAR_CLK_EN (1 << 8)
#define SWPKT_USB_CLK_EN (1 << 7)
#define PHYMIPS_CLK_EN   (1 << 6)
#define VDSL_CLK_EN      (1 << 5)
#define VDSL_BONDING_EN  (1 << 4)
#define VDSL_AFE_EN      (1 << 3)
#define VDSL_QPROC_EN    (1 << 2)

In order to be able to map these to devices for the BCM63xx SoCs I'm going
to define the power controller binding with "power-domain-indices" and
"power-domain-names" to mirror the clock binding. The separate clk and
generic_pm_domain devices will then handle set/clear of the relevant bits
using the regmap.


[1]
https://code.google.com/p/gfiber-gflt100/source/browse/shared/opensource/include/bcm963xx/6368_map_part.h?r=b292e8c271addbda62104bece90e3c8018714194

-- 
Simon Arlott
