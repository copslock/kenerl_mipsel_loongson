Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jun 2017 00:19:19 +0200 (CEST)
Received: from hauke-m.de ([5.39.93.123]:45374 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992155AbdFTWTLyvJZe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Jun 2017 00:19:11 +0200
Received: from [IPv6:2003:86:281e:2600:3d84:650:c911:2ee8] (p20030086281E26003D840650C9112EE8.dip0.t-ipconnect.de [IPv6:2003:86:281e:2600:3d84:650:c911:2ee8])
        by mail.hauke-m.de (Postfix) with ESMTPSA id D15341001DD;
        Wed, 21 Jun 2017 00:19:10 +0200 (CEST)
Subject: Re: [PATCH v4 12/16] MIPS: lantiq: Add a GPHY driver which uses the
 RCU syscon-mfd
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20170619222608.13344-1-hauke@hauke-m.de>
 <20170619222608.13344-13-hauke@hauke-m.de>
 <CAHp75VcDgC7n3FVig0r0RBg=B655sv_jWQt7RWXU9uPx9QGvqA@mail.gmail.com>
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
Message-ID: <c3fae486-6ded-0bb2-d7e4-89ada96986d0@hauke-m.de>
Date:   Wed, 21 Jun 2017 00:19:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcDgC7n3FVig0r0RBg=B655sv_jWQt7RWXU9uPx9QGvqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58712
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

On 06/20/2017 01:36 AM, Andy Shevchenko wrote:
> On Tue, Jun 20, 2017 at 1:26 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>
>> Compared to the old xrx200_phy_fw driver the new version has multiple
>> enhancements. The name of the firmware files does not have to be added
>> to all .dts files anymore - one now configures the GPHY mode (FE or GE)
>> instead. Each GPHY can now also boot separate firmware (thus mixing of
>> GE and FE GPHYs is now possible).
>> The new implementation is based on the RCU syscon-mfd and uses the
>> reeset_controller framework instead of raw RCU register reads/writes.
>>
> 
> Couple of comments, otherwise FWIW,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
>>  .../devicetree/bindings/mips/lantiq/rcu-gphy.txt   |  36 +++
>>  arch/mips/lantiq/xway/sysctrl.c                    |   6 +-
>>  drivers/soc/lantiq/Makefile                        |   1 +
>>  drivers/soc/lantiq/gphy.c                          | 261 +++++++++++++++++++++
>>  include/dt-bindings/mips/lantiq_rcu_gphy.h         |  15 ++
>>  5 files changed, 317 insertions(+), 2 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu-gphy.txt
>>  create mode 100644 drivers/soc/lantiq/gphy.c
>>  create mode 100644 include/dt-bindings/mips/lantiq_rcu_gphy.h

......

>> +
>> +       /*
>> +        * GPHY cores need the firmware code in a persistent and contiguous
>> +        * memory area with a 16 kB boundary aligned start address.
>> +        */
>> +       priv->size = fw->size + XRX200_GPHY_FW_ALIGN;
>> +
>> +       priv->fw_addr = dma_alloc_coherent(dev, priv->size,
>> +                                          &priv->dma_addr, GFP_KERNEL);
> 
> dmam_ ?

Thanks, didn't know this functions was looking for something with devm_
prefix, but dmam_ makes the code simpler.

....

>> +
>> +       ret = xway_gphy_load(dev, priv, &fw_addr);
>> +       if (ret)
> 
> You need to disable and unprepare a clock.

Done

>> +               return ret;
>> +

....
> 
>> +       dma_free_coherent(dev, priv->size, priv->fw_addr, priv->dma_addr);
> 
> It will go away if dmam_ variant is in use.

Done

>> +
>> +       ret = unregister_reboot_notifier(&priv->gphy_reboot_nb);
>> +       if (ret)
>> +               dev_warn(dev, "Failed to unregister reboot notifier\n");
...

Hauke
