Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Jul 2017 23:31:01 +0200 (CEST)
Received: from hauke-m.de ([5.39.93.123]:57116 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993904AbdGCVaygtakF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 3 Jul 2017 23:30:54 +0200
Received: from [192.168.10.172] (p57978149.dip0.t-ipconnect.de [87.151.129.73])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 7C95810005E;
        Mon,  3 Jul 2017 23:30:52 +0200 (CEST)
Subject: Re: [PATCH v7 10/16] reset: Add a reset controller driver for the
 Lantiq XWAY based SoCs
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20170702224051.15109-1-hauke@hauke-m.de>
 <20170702224051.15109-11-hauke@hauke-m.de>
 <CAHp75VexwnVsb-ojXaZDN7QPVRKUeP-R=5C+j5ZSkE37Dtyp1Q@mail.gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        linux-watchdog@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        "martin.blumenstingl" <martin.blumenstingl@googlemail.com>,
        john <john@phrozen.org>, linux-spi <linux-spi@vger.kernel.org>,
        "hauke.mehrtens" <hauke.mehrtens@intel.com>,
        Rob Herring <robh@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <e1160f30-eeff-3db2-884c-9cd4af35a37d@hauke-m.de>
Date:   Mon, 3 Jul 2017 23:30:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VexwnVsb-ojXaZDN7QPVRKUeP-R=5C+j5ZSkE37Dtyp1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59011
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

On 07/03/2017 09:51 AM, Andy Shevchenko wrote:
> On Mon, Jul 3, 2017 at 1:40 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>
>> The reset controllers (on xRX200 and newer SoCs have two of them) are
>> provided by the RCU module. This was initially implemented as a simple
>> reset controller. However, the RCU module provides more functionality
>> (ethernet GPHYs, USB PHY, etc.), which makes it a MFD device.
>> The old reset controller driver implementation from
>> arch/mips/lantiq/xway/reset.c did not honor this fact.
>>
>> For some devices the request and the status bits are different.
> 
>> +Required properties:
>> +- compatible           : Should be one of
>> +                               "lantiq,danube-reset"
>> +                               "lantiq,xrx200-reset"
>> +- offset-set           : Offset of the reset set register
>> +- offset-status                : Offset of the reset status register
> 
> Just one side comment (I'm fine with either choice, just for your
> information). Recently I have reviewed at24 patch which adds a
> property for getting MAC offset and my reseach ends up with the naming
> pattern mac-offset (as many others are doing this way). So, perhaps in
> your case it might make sense to do that way? Anyway, it's a matter of
> a (bit of a) chaos in DT bindings, whatever you decide users will live
> with.
> 
I put the offset first to group them better together, but I have no
problem in reversing the order, then it is in a more natural speaking form.

Hauke
