Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2016 12:28:03 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61339 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991172AbcKRL1li0XY9 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Nov 2016 12:27:41 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 86F84A21728E2;
        Fri, 18 Nov 2016 11:27:32 +0000 (GMT)
Received: from HHMAIL01.hh.imgtec.org ([fe80::710b:f219:72bc:e0b3]) by
 hhmail02.hh.imgtec.org ([fe80::5400:d33e:81a4:f775%25]) with mapi id
 14.03.0294.000; Fri, 18 Nov 2016 11:27:34 +0000
From:   James Hartley <James.Hartley@imgtec.com>
To:     Rob Herring <robh@kernel.org>,
        Rahul Bedarkar <Rahul.Bedarkar@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] MIPS: DTS: img: add device tree for Marduk board
Thread-Topic: [PATCH v2 2/2] MIPS: DTS: img: add device tree for Marduk board
Thread-Index: AQHSJd/J+w38N++hbEGRPlvpZKoSOaCuNx+AgDCaE1A=
Date:   Fri, 18 Nov 2016 11:27:33 +0000
Message-ID: <72BC0C8BD7BB6F45988A99382E5FBAE5889FEB65@HHMAIL01.hh.imgtec.org>
References: <1476424555-22629-1-git-send-email-rahul.bedarkar@imgtec.com>
 <1476424555-22629-2-git-send-email-rahul.bedarkar@imgtec.com>
 <20161018141337.3lardgah2qprqtdx@rob-hp-laptop>
In-Reply-To: <20161018141337.3lardgah2qprqtdx@rob-hp-laptop>
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
X-archive-position: 55832
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
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: 18 October 2016 15:14
> To: Rahul Bedarkar
> Cc: Ralf Baechle; Mark Rutland; James Hartley; linux-mips@linux-mips.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 2/2] MIPS: DTS: img: add device tree for Marduk
> board
> 
> On Fri, Oct 14, 2016 at 11:25:55AM +0530, Rahul Bedarkar wrote:
> > Add support for Imagination Technologies' Marduk board which is based
> > on Pistachio SoC. It is also known as Creator Ci40. Marduk is legacy
> > name and will be there for decades.
> >
> > Documentation for this board can be found on
> > https://docs.creatordev.io/ci40/
> >
> > This patch adds initial support for board with following peripherals:
> >
> > * PWM based heartbeat LED
> > * GPIO based buttons
> > * SPI NOR flash on SPI1
> > * UART0 and UART1
> > * SD card
> > * Ethernet
> > * USB
> > * PWM
> > * ADC
> > * I2C
> >
> > Signed-off-by: Rahul Bedarkar <rahul.bedarkar@imgtec.com>
> > ---
> > Changes in v2:
> >   - Correct RAM size. It is 256MB instead of 128MB.
> >   - Rename nodes pwm_leds -> leds and gpio_keys -> keys (Suggested by
> Rob Herring)
> >   - Don't use '_' in node name for internal_dac_supply (Suggested by Rob
> Herring)
> >   - Add part name in compatible string for spi-nor (Suggested by Rob
> > Herring)
> > ---
> >  .../bindings/mips/img/pistachio-marduk.txt         |  10 ++
> >  MAINTAINERS                                        |   6 +
> >  arch/mips/boot/dts/img/Makefile                    |   9 ++
> >  arch/mips/boot/dts/img/pistachio_marduk.dts        | 163
> +++++++++++++++++++++
> >  4 files changed, 188 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/mips/img/pistachio-marduk.txt
> >  create mode 100644 arch/mips/boot/dts/img/Makefile  create mode
> > 100644 arch/mips/boot/dts/img/pistachio_marduk.dts
> 
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: James Hartley <james.hartley@imgtec.com>
