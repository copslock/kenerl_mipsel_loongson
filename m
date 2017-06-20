Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jun 2017 00:21:01 +0200 (CEST)
Received: from hauke-m.de ([5.39.93.123]:45384 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992160AbdFTWUyRyCNe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Jun 2017 00:20:54 +0200
Received: from [IPv6:2003:86:281e:2600:3d84:650:c911:2ee8] (p20030086281E26003D840650C9112EE8.dip0.t-ipconnect.de [IPv6:2003:86:281e:2600:3d84:650:c911:2ee8])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 30E0F1001DD;
        Wed, 21 Jun 2017 00:20:53 +0200 (CEST)
Subject: Re: [PATCH v4 14/16] phy: Add an USB PHY driver for the Lantiq SoCs
 using the RCU module
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20170619222608.13344-1-hauke@hauke-m.de>
 <20170619222608.13344-15-hauke@hauke-m.de>
 <CAHp75VcYoPBd651s7a=y5yB3mjRG4W+=gWbeKFzwyw04qcg-MQ@mail.gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        linux-watchdog@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        "martin.blumenstingl" <martin.blumenstingl@googlemail.com>,
        john <john@phrozen.org>, linux-spi <linux-spi@vger.kernel.org>,
        "hauke.mehrtens" <hauke.mehrtens@intel.com>,
        Rob Herring <robh@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <a35bc5b3-fe52-8a06-6bc3-7f974c8b2740@hauke-m.de>
Date:   Wed, 21 Jun 2017 00:20:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcYoPBd651s7a=y5yB3mjRG4W+=gWbeKFzwyw04qcg-MQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58713
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

On 06/20/2017 01:39 AM, Andy Shevchenko wrote:
> On Tue, Jun 20, 2017 at 1:26 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>> This driver starts the DWC2 core(s) built into the XWAY SoCs and provides
>> the PHY interfaces for each core. The phy instances can be passed to the
>> dwc2 driver, which already supports the generic phy interface.
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> Cc: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  .../bindings/phy/phy-lantiq-rcu-usb2.txt           |  41 ++++
>>  arch/mips/lantiq/xway/sysctrl.c                    |  24 +-
>>  drivers/phy/Kconfig                                |   8 +
>>  drivers/phy/Makefile                               |   1 +
>>  drivers/phy/phy-lantiq-rcu-usb2.c                  | 272 +++++++++++++++++++++
>>  5 files changed, 334 insertions(+), 12 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
>>  create mode 100644 drivers/phy/phy-lantiq-rcu-usb2.c
>>

....

>> +       /*
>> +        * Power on the USB PHY. We have to do it early because
>> +        * otherwise the second core won't turn on properly.
>> +        */
>> +       ret = clk_prepare_enable(priv->phy_gate_clk);
>> +       if (ret) {
>> +               dev_err(dev, "failed to enable PHY gate\n");
> 
> Disable and unprepare control clock.

Done, is there no devm_ version of this?

>> +               return ret;
>> +       }

...

>> +       ret = ltq_rcu_usb2_start_cores(priv);
>> +       if (ret)
>> +               return ret;
>> +
> 
>> +       provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
>> +
>> +       if (IS_ERR(provider))
> 
> Remove line in between.

Done

>> +               return PTR_ERR(provider);
>> +
>> +       dev_set_drvdata(priv->dev, priv);
>> +       return 0;
> 
> You need to carefully check error path that you disabled clocks.

Done

>> +}
>> +

.....

Hauke
