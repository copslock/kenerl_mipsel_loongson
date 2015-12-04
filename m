Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Dec 2015 22:12:21 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:52560 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007703AbbLDVMT5ZpQS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Dec 2015 22:12:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:To:From:Subject:Date:References:In-Reply-To:Message-ID; bh=kTtlnVIotr4leB85Na2V3XYocdGHmKKiN9RSvft7k10=;
        b=oCVX+JvkezBB3aloClK9mvymtsIDX/v1sT5VTMOrhYNC57SOgiUlgrHJ1p4ClplQRyo+6SqfpJMjKRmNFyygoZ1B750ERMl8JVEWeoXbxYVBLep5a4kuILOr2HJMZsBpaJ2qctfHfndZ6op1UWI67HLr9xVqB11qwz340TbxqqF4u1bOdkyit5KOhNdRw6NBk9La5e9qO8cQE7wDPuAfycmsU9RZQyUzOINHJrjvBisIoviTwkJTdJPgS9lKSVBXxkIfy1v178BvqECi/SpMyh5f/gZjHo93Pv+OLy2ODqWdvADkRtZEsPaaXXZ1chXqVl0xd2JpTS4M+OmMhw4NYQ==;
Received: from lp0_webmail by proxima.lp0.eu with local 
        id 1a4xeD-0006c9-Rv (Exim); Fri, 04 Dec 2015 21:12:10 +0000
Received: from simon by proxima.lp0.eu with https;
        Fri, 4 Dec 2015 21:12:10 -0000
Message-ID: <6a3790afc811ac4ed732371f2eb33a7c194b996d@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
In-Reply-To: <1449131943.3339.8.camel@pengutronix.de>
References: <565F5C96.5090700@simon.arlott.org.uk>
    <1449131943.3339.8.camel@pengutronix.de>
Date:   Fri, 4 Dec 2015 21:12:10 -0000
Subject: Re: [PATCH (v2) 1/2] reset: Add brcm,bcm6345-reset device tree
 binding
From:   "Simon Arlott" <simon@fire.lp0.eu>
To:     "Rob Herring" <robh+dt@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>
Cc:     "Kevin Cernekee" <cernekee@gmail.com>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "MIPS Mailing List" <linux-mips@linux-mips.org>,
        "Pawel Moll" <pawel.moll@arm.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Ian Campbell" <ijc+devicetree@hellion.org.uk>,
        "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>
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
X-archive-position: 50347
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

On Thu, December 3, 2015 08:39, Philipp Zabel wrote:
> Am Mittwoch, den 02.12.2015, 21:03 +0000 schrieb Simon Arlott:
>> +periph_soft_rst: reset-controller {
>> +	compatible = "brcm,bcm63168-reset", "brcm,bcm6345-reset";
>> +	regmap = <&periph_cntl>;
>> +	offset = <0x10>;
>> +
>> +	#reset-cells = <1>;
>> +};
>
> I would have written it something like this:
>
> periph_cntl: ... {
> 	compatible = "syscon", "simple-mfd";
> 	#address-cells = <1>;
> 	#size-cells = <1>;
>
> 	periph_soft_rst: reset-controller {
> 		compatible = "brcm,bcm6345-reset";
> 		reg = <0x10 0x4>;
> 		#reset-cells = <1>;
> 	};
> };
>
> for a device that is only controlled through a syscon.

Rob, do you want me to change this or is my version ok?

> The driver itself looks good to me.
>
> best regards
> Philipp
>
>

-- 
Simon Arlott
