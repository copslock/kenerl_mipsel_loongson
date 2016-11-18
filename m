Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2016 12:27:41 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25058 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991129AbcKRL1eNWC69 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Nov 2016 12:27:34 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 9912AEBE6EED5;
        Fri, 18 Nov 2016 11:27:25 +0000 (GMT)
Received: from HHMAIL-X.hh.imgtec.org (10.100.10.113) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 18 Nov 2016 11:27:27 +0000
Received: from HHMAIL01.hh.imgtec.org ([fe80::710b:f219:72bc:e0b3]) by
 HHMAIL-X.hh.imgtec.org ([fe80::3509:b0ce:371:2b%18]) with mapi id
 14.03.0294.000; Fri, 18 Nov 2016 11:27:27 +0000
From:   James Hartley <James.Hartley@imgtec.com>
To:     Rahul Bedarkar <Rahul.Bedarkar@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] MIPS: DTS: add base device tree for Pistachio SoC
Thread-Topic: [PATCH v2 1/2] MIPS: DTS: add base device tree for Pistachio
 SoC
Thread-Index: AQHSJd++Ak9WYoQk8kCbMHY/RULGZqDez6XA
Date:   Fri, 18 Nov 2016 11:27:26 +0000
Message-ID: <72BC0C8BD7BB6F45988A99382E5FBAE5889FEB5E@HHMAIL01.hh.imgtec.org>
References: <1476424555-22629-1-git-send-email-rahul.bedarkar@imgtec.com>
In-Reply-To: <1476424555-22629-1-git-send-email-rahul.bedarkar@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.40.7.55]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <James.Hartley@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55831
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Hartley@imgtec.com
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

Hi Rahul, 

> -----Original Message-----
> From: Rahul Bedarkar
> Sent: 14 October 2016 06:56
> To: Ralf Baechle; Rob Herring; Mark Rutland; James Hartley
> Cc: linux-mips@linux-mips.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Rahul Bedarkar
> Subject: [PATCH v2 1/2] MIPS: DTS: add base device tree for Pistachio SoC
> 
> Add support for the base Device Tree for Imagination Technologies'
> Pistachio SoC.
> 
> This commit supports the following peripherals:
> 
>  * Clocks
>  * Pinctrl and GPIO
>  * UART
>  * SPI
>  * I2C
>  * PWM
>  * ADC
>  * Watchdog
>  * Ethernet
>  * MMC
>  * DMA engine
>  * Crypto
>  * I2S
>  * SPDIF
>  * Internal DAC
>  * Timer
>  * USB
>  * IR
>  * Interrupt Controller
> 
> Signed-off-by: Rahul Bedarkar <rahul.bedarkar@imgtec.com>
> ---
> Changes in v2:
>   - No change
> ---
>  MAINTAINERS                           |   2 +-
>  arch/mips/boot/dts/img/pistachio.dtsi | 924
> ++++++++++++++++++++++++++++++++++
>  2 files changed, 925 insertions(+), 1 deletion(-)  create mode 100644
> arch/mips/boot/dts/img/pistachio.dtsi

Thanks for putting this together Rahul.

Acked-by: James Hartley <james.hartley@imgtec.com>
