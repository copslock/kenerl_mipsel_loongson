Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2017 22:11:56 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:53818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993949AbdGGULsEpnyc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Jul 2017 22:11:48 +0200
Received: from mail-yb0-f178.google.com (mail-yb0-f178.google.com [209.85.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FDDF22C88;
        Fri,  7 Jul 2017 20:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FDDF22C88
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
Received: by mail-yb0-f178.google.com with SMTP id p207so14035874yba.2;
        Fri, 07 Jul 2017 13:11:46 -0700 (PDT)
X-Gm-Message-State: AIVw1124UCaj0Z3e/NzSvqCkgN0PCY0XFlPLUkwwRKe1FNzEkWJeYtU4
        tFQlx8pX5MvELlaemIc+AD8wDCrbvg==
X-Received: by 10.37.98.141 with SMTP id w135mr1104236ybb.192.1499458305242;
 Fri, 07 Jul 2017 13:11:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.82.66 with HTTP; Fri, 7 Jul 2017 13:11:24 -0700 (PDT)
In-Reply-To: <534b3592-2803-ac95-ad60-3cf5d1252413@hauke-m.de>
References: <20170702224051.15109-1-hauke@hauke-m.de> <20170702224051.15109-15-hauke@hauke-m.de>
 <20170707142312.5pwily3gbntvesbm@rob-hp-laptop> <534b3592-2803-ac95-ad60-3cf5d1252413@hauke-m.de>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 7 Jul 2017 15:11:24 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKSixi3v8qmEFXQpYWi8C2USx5znahmCH14-8sBe+W3ig@mail.gmail.com>
Message-ID: <CAL_JsqKSixi3v8qmEFXQpYWi8C2USx5znahmCH14-8sBe+W3ig@mail.gmail.com>
Subject: Re: [PATCH v7 14/16] phy: Add an USB PHY driver for the Lantiq SoCs
 using the RCU module
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        John Crispin <john@phrozen.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "hauke.mehrtens" <hauke.mehrtens@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59065
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

On Fri, Jul 7, 2017 at 1:49 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>
>
> On 07/07/2017 04:23 PM, Rob Herring wrote:
>> On Mon, Jul 03, 2017 at 12:40:49AM +0200, Hauke Mehrtens wrote:
>>> This driver starts the DWC2 core(s) built into the XWAY SoCs and provides
>>> the PHY interfaces for each core. The phy instances can be passed to the
>>> dwc2 driver, which already supports the generic phy interface.
>>>
>>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>>> Cc: Kishon Vijay Abraham I <kishon@ti.com>
>>> ---
>>>  .../bindings/phy/phy-lantiq-rcu-usb2.txt           |  42 ++++
>>>  arch/mips/lantiq/xway/sysctrl.c                    |  24 +-
>>>  drivers/phy/Kconfig                                |   8 +
>>>  drivers/phy/Makefile                               |   1 +
>>>  drivers/phy/phy-lantiq-rcu-usb2.c                  | 275 +++++++++++++++++++++
>>>  5 files changed, 338 insertions(+), 12 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
>>>  create mode 100644 drivers/phy/phy-lantiq-rcu-usb2.c
>>>
>>> diff --git a/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt b/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
>>> new file mode 100644
>>> index 000000000000..c538baa2ba54
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
>>> @@ -0,0 +1,42 @@
>>> +Lantiq XWAY SoC RCU USB 1.1/2.0 PHY binding
>>> +===========================================
>>> +
>>> +This binding describes the USB PHY hardware provided by the RCU module on the
>>> +Lantiq XWAY SoCs.
>>> +
>>> +This driver has to be a sub node of the Lantiq RCU block.
>>> +
>>> +-------------------------------------------------------------------------------
>>> +Required properties (controller (parent) node):
>>> +- compatible        : Should be one of
>>> +                    "lantiq,ase-usb2-phy"
>>> +                    "lantiq,danube-usb2-phy"
>>> +                    "lantiq,xrx100-usb2-phy"
>>> +                    "lantiq,xrx200-usb2-phy"
>>> +                    "lantiq,xrx300-usb2-phy"
>>> +- offset-phy        : Offset of the USB PHY configuration register
>>> +- offset-ana        : Offset of the USB Analog configuration register
>>
>> These are not needed with the reg property used instead.
>
> Hi Rob,
>
> These register are also used by completely different drivers, the
> hardware engineers used some bits of these registers for completely
> different purposes, some bits are used for DSL instead of USB PHY. When
> I io map them, they can only be access through this driver.
>
> Should I get the register from the reg property and access them though
> regmap or how should I make sure also other drivers can access the other
> bits.

Yes, just read the reg property like you would for the offset properties.

Rob
