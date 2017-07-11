Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jul 2017 23:16:48 +0200 (CEST)
Received: from hauke-m.de ([5.39.93.123]:39099 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993977AbdGKVQlIDBaY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Jul 2017 23:16:41 +0200
Received: from [IPv6:2003:c2:bbca:9600:41a7:91fe:aabd:b7be] (p200300C2BBCA960041A791FEAABDB7BE.dip0.t-ipconnect.de [IPv6:2003:c2:bbca:9600:41a7:91fe:aabd:b7be])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 1C91F10005E;
        Tue, 11 Jul 2017 23:16:39 +0200 (CEST)
Subject: Re: [PATCH v7 14/16] phy: Add an USB PHY driver for the Lantiq SoCs
 using the RCU module
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh@kernel.org>
References: <20170702224051.15109-1-hauke@hauke-m.de>
 <20170702224051.15109-15-hauke@hauke-m.de>
 <20170707142312.5pwily3gbntvesbm@rob-hp-laptop>
 <30adb3f5-50b5-35e3-685f-9fe0fa8c31f8@ti.com>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, andy.shevchenko@gmail.com,
        p.zabel@pengutronix.de
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <231fc92f-5e3e-bff0-9a59-081e291f83e8@hauke-m.de>
Date:   Tue, 11 Jul 2017 23:16:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <30adb3f5-50b5-35e3-685f-9fe0fa8c31f8@ti.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59099
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 07/11/2017 08:38 AM, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Friday 07 July 2017 07:53 PM, Rob Herring wrote:
>> On Mon, Jul 03, 2017 at 12:40:49AM +0200, Hauke Mehrtens wrote:
>>> This driver starts the DWC2 core(s) built into the XWAY SoCs and provides
>>> the PHY interfaces for each core. The phy instances can be passed to the
>>> dwc2 driver, which already supports the generic phy interface.
>>>
>>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>>> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> 
> I see you have added my name in cc but for some reason I don't have the patch
> in my mailbox. Can you resend it please?

I send it to you and I did not receive any error message from the mail
servers involved, I will check my mail server log files the next time.

I assume that your mail server just silently drops my mails.

>>> ---
>>>  .../bindings/phy/phy-lantiq-rcu-usb2.txt           |  42 ++++
>>>  arch/mips/lantiq/xway/sysctrl.c                    |  24 +-
>>>  drivers/phy/Kconfig                                |   8 +
>>>  drivers/phy/Makefile                               |   1 +
>>>  drivers/phy/phy-lantiq-rcu-usb2.c                  | 275 +++++++++++++++++++++
> 
> Please create a new directory withing phy for adding a phy driver.

Should I use lantiq or intel as folder name? Lantiq was bought by Intel
and the Lantiq brand will be replaced by the Intel brand in the future.

Hauke
