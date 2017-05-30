Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 May 2017 22:21:31 +0200 (CEST)
Received: from hauke-m.de ([5.39.93.123]:33622 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994624AbdE3UVV5qIgE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 30 May 2017 22:21:21 +0200
Received: from [IPv6:2003:86:2804:f00:9fba:1081:5146:7628] (p2003008628040F009FBA108151467628.dip0.t-ipconnect.de [IPv6:2003:86:2804:f00:9fba:1081:5146:7628])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 17A371001D5;
        Tue, 30 May 2017 22:21:20 +0200 (CEST)
Subject: Re: [PATCH v3 14/16] phy: Add an USB PHY driver for the Lantiq SoCs
 using the RCU module
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20170528184006.31668-1-hauke@hauke-m.de>
 <20170528184006.31668-15-hauke@hauke-m.de>
 <CAHp75Ve9bV99=WCzmXU-Rth-gar5gqvy4taZ7NMQQHGKcVbHHw@mail.gmail.com>
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
Message-ID: <6180daf0-2eaf-cd68-3eb5-e119dfd4aa2a@hauke-m.de>
Date:   Tue, 30 May 2017 22:21:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Ve9bV99=WCzmXU-Rth-gar5gqvy4taZ7NMQQHGKcVbHHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58078
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

On 05/30/2017 08:31 PM, Andy Shevchenko wrote:
> On Sun, May 28, 2017 at 9:40 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>> This driver starts the DWC2 core(s) built into the XWAY SoCs and provides
>> the PHY interfaces for each core. The phy instances can be passed to the
>> dwc2 driver, which already supports the generic phy interface.
> 
>> +static void ltq_rcu_usb2_start_cores(struct platform_device *pdev)
> 
> It should return int. See below.
> 
>> +{
> 
>> +       /* Power on the USB core. */
>> +       if (clk_prepare_enable(priv->ctrl_gate_clk)) {
> 
> You basically shadow the error, why?

Thanks for the hint I changed it.

>> +               dev_err(dev, "failed to enable CTRL gate\n");
>> +               return;
>> +       }
> 
>> +       if (clk_prepare_enable(priv->phy_gate_clk)) {
>> +               dev_err(dev, "failed to enable PHY gate\n");
>> +               return;
>> +       }
> 
> Ditto.

same here.

>> +static int ltq_rcu_usb2_of_probe(struct device_node *phynode,
>> +                                   struct ltq_rcu_usb2_priv *priv)
>> +{
>> +       struct device *dev = priv->dev;
>> +       const struct of_device_id *match =
>> +               of_match_node(ltq_rcu_usb2_phy_of_match, phynode);
>> +       int ret;
>> +
> 
>> +       if (!match) {
>> +               dev_err(dev, "Not a compatible Lantiq RCU USB PHY\n");
>> +               return -EINVAL;
>> +       }
> 
> Can it ever happen?

As long as this device gets probed by device tree this can not happen,
so I will remove it.

>> +
>> +       priv->reg_bits = match->data;
> 
> I think there is a helper to get driver data directly from node.

Thanks for the hint, there is of_device_get_match_data() which does this.

>> +       if (priv->reg_bits->have_ana_cfg) {
>> +               ret = device_property_read_u32(dev, "offset-ana",
>> +                                              &priv->ana_cfg1_reg_offset);
>> +               if (ret) {
>> +                       dev_dbg(dev, "Failed to get RCU ANA CFG1 reg offset\n");
>> +                       return ret;
>> +               }
>> +       }
> 
> ret = device_property_...(...);
> if (ret && priv->reg_bits->have_ana_cfg) {
>  ...
>  return ret;
> }
> 
> ?

Yes, that should look better, I will change it.

> 
> 
>> +       priv->dev = &pdev->dev;
> 
>> +       dev_set_drvdata(priv->dev, priv);
> 
> Move this to the end of function. Ideally it should be run if and only
> if the function returns 0.

Done

>> +       provider = devm_of_phy_provider_register(&pdev->dev,
>> +                                                of_phy_simple_xlate);
>> +
>> +       return PTR_ERR_OR_ZERO(provider);
> 
> I would do explicitly, though it's up to you and maintainer.
> 
> if (IS_ERR(provider))
>  return PTR_ERR();
> 
> return 0;

I do not care, but this was I can call dev_set_drvdata() when this is
really returning 0.

Hauke
