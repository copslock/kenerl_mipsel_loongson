Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Jan 2016 00:53:18 +0100 (CET)
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34136 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014379AbcAAXxPqRGgG convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 2 Jan 2016 00:53:15 +0100
Received: by mail-pf0-f177.google.com with SMTP id e65so119378565pfe.1
        for <linux-mips@linux-mips.org>; Fri, 01 Jan 2016 15:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=content-type:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=jrM+mJ4aWnsVbRr7Jm4ZDUv3oNjMrMW64RmQBR92jbE=;
        b=WkYkeAlNnriwzfhAb55WiLd+xecY5RMkizoVzi9viHhO9w21vsiGGdk0x4tU0Z6OGz
         p4y7wWvABcCLcDa6k7QJynDQ68TG3u4w2eJhf9Yv8crFnzNcoMn0rCbyXRArXeUV8ble
         3aUx7d0Q5GSHqE8zroJqWORGplVDW3q8pxNK0n+CN4oGLTFeLy2RqszCZq0hgTwlbHx2
         1X/Pbx8CquyNObb7Q3BtYoz8gVTlTbI4X3cjxgkKuYmI3mRNBlGkdgvLz8UwYvWieX9y
         Zv2Qr6gDg3x++nxgIhDAnML6dSsFxlY6QSSvXQ9zpwyFv7LwhwNjepmiHPrhYj+UvoIn
         wm0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version
         :content-transfer-encoding:to:from:in-reply-to:cc:references
         :message-id:user-agent:subject:date;
        bh=jrM+mJ4aWnsVbRr7Jm4ZDUv3oNjMrMW64RmQBR92jbE=;
        b=Pvv2WSLaUbHaegk7GGBSi1umxcwqGI4RUq8aAtXLtxdVh2lNatA+5++jmy7rfG+sZT
         6XTtyOcoOIwNSqaIzXaXVXSVNBDcdgQFJHXR7lomjPv0zWoQ3IIrcFNApXquKufvpFkf
         w8gmugQeEUH3E0WhH6zyhXdgAmsllLbUVayRyhBBOUlw7HwwFz8VgHaer9CfpPXxFYmT
         id958rCvcNapxmFP4J29uj7rjs9w7diCtQK0n19aampD6Xir5aSdg/rvdezjDQQrhLvP
         mFVla0TA6apWqQ5B6pDxpXK9Wxt+PfJP2qpBFeOi4y/SJPE0TRTBfBk/bFQhbi96btHr
         tQeA==
X-Gm-Message-State: ALoCoQlcxv3pedsVbjs+dtq7B+vd4x0e9+t1CieW9AQAaAAhOXFYoEd1+DldzOfti7TdHeCe0u2++AkFTg+5LZxQRcdYVwPSIg==
X-Received: by 10.98.42.149 with SMTP id q143mr110921267pfq.75.1451692389681;
        Fri, 01 Jan 2016 15:53:09 -0800 (PST)
Received: from localhost (cpe-172-248-200-249.socal.res.rr.com. [172.248.200.249])
        by smtp.gmail.com with ESMTPSA id b66sm14091494pfd.6.2016.01.01.15.53.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jan 2016 15:53:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Simon Arlott <simon@fire.lp0.eu>,
        "Stephen Boyd" <sboyd@codeaurora.org>,
        "Kevin Cernekee" <cernekee@gmail.com>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
From:   Michael Turquette <mturquette@baylibre.com>
In-Reply-To: <5669F3C3.3090207@simon.arlott.org.uk>
Cc:     "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, linux-mips@linux-mips.org,
        "Rob Herring" <robh+dt@kernel.org>,
        "Pawel Moll" <pawel.moll@arm.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Ian Campbell" <ijc+devicetree@hellion.org.uk>,
        "Kumar Gala" <galak@codeaurora.org>,
        "Jonas Gorski" <jogo@openwrt.org>
References: <5669F361.60405@simon.arlott.org.uk> <5669F3C3.3090207@simon.arlott.org.uk>
Message-ID: <20160101234031.7140.66812@quark.deferred.io>
User-Agent: alot/0.3.6
Subject: Re: [PATCH linux-next (v2) 2/2] clk: bcm6345: Add BCM6345 gated clock support
Date:   Fri, 01 Jan 2016 15:40:31 -0800
Return-Path: <mturquette@baylibre.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50815
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mturquette@baylibre.com
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

Hi Simon,

Quoting Simon Arlott (2015-12-10 13:50:59)
> +#define to_clk_bcm6345(_hw) container_of(_hw, struct clk_bcm6345, hw)
> +
> +static int clk_bcm6345_enable(struct clk_hw *hw)
> +{
> +       struct clk_bcm6345 *gate = to_clk_bcm6345(hw);
> +
> +       return regmap_write_bits(gate->map, gate->offset,
> +                                       gate->mask, gate->mask);

Does your regmap hold a spinlock or mutex? If a mutex then this should
be a .prepare callback instead of .enable. If it's a spinlock then
nothing to see here, move along.

> +}
> +
> +static void clk_bcm6345_disable(struct clk_hw *hw)
> +{
> +       struct clk_bcm6345 *gate = to_clk_bcm6345(hw);
> +
> +       regmap_write_bits(gate->map, gate->offset,
> +                                       gate->mask, 0);
> +}
> +
> +static int clk_bcm6345_is_enabled(struct clk_hw *hw)
> +{
> +       struct clk_bcm6345 *gate = to_clk_bcm6345(hw);
> +       unsigned int val;
> +       int ret;
> +
> +       ret = regmap_read(gate->map, gate->offset, &val);
> +       if (ret)
> +               return ret;
> +
> +       val &= gate->mask;
> +
> +       return val ? 1 : 0;
> +}
> +
> +const struct clk_ops clk_bcm6345_ops = {
> +       .enable = clk_bcm6345_enable,
> +       .disable = clk_bcm6345_disable,
> +       .is_enabled = clk_bcm6345_is_enabled,
> +};
> +
> +static struct clk * __init of_bcm6345_clk_register(const char *parent_name,
> +       const char *clk_name, struct regmap *map, u32 offset, u32 mask)
> +{
> +       struct clk_bcm6345 *gate;
> +       struct clk_init_data init;
> +       struct clk *ret;
> +
> +       gate = kzalloc(sizeof(*gate), GFP_KERNEL);
> +       if (!gate)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name = clk_name;
> +       init.ops = &clk_bcm6345_ops;
> +       init.flags = CLK_IS_BASIC;

Why is CLK_IS_BASIC set?

> +       init.parent_names = (parent_name ? &parent_name : NULL);
> +       init.num_parents = (parent_name ? 1 : 0);
> +       gate->hw.init = &init;
> +       gate->map = map;
> +       gate->offset = offset;
> +       gate->mask = mask;
> +
> +       ret = clk_register(NULL, &gate->hw);
> +       if (IS_ERR(ret))
> +               kfree(gate);
> +
> +       return ret;
> +}
> +
> +static void __init of_bcm6345_clk_setup(struct device_node *node)
> +{
> +       struct clk_onecell_data *clk_data;
> +       const char *parent_name = NULL;
> +       struct regmap *map;
> +       u32 offset;
> +       unsigned int clocks = 0;
> +       int i;
> +
> +       clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
> +       if (!clk_data)
> +               return;
> +
> +       clk_data->clk_num = 32;
> +       clk_data->clks = kmalloc_array(clk_data->clk_num,
> +               sizeof(*clk_data->clks), GFP_KERNEL);
> +
> +       for (i = 0; i < clk_data->clk_num; i++)
> +               clk_data->clks[i] = ERR_PTR(-ENODEV);
> +
> +       if (of_clk_get_parent_count(node) > 0)
> +               parent_name = of_clk_get_parent_name(node, 0);
> +
> +       map = syscon_regmap_lookup_by_phandle(node, "regmap");
> +       if (IS_ERR(map)) {
> +               pr_err("%s: regmap lookup error %ld\n",
> +                       node->full_name, PTR_ERR(map));
> +               goto out;
> +       }
> +
> +       if (of_property_read_u32(node, "offset", &offset)) {
> +               pr_err("%s: offset not specified\n", node->full_name);
> +               goto out;
> +       }
> +
> +       /* clks[] is sparse, indexed by bit, maximum clocks checked using i */
> +       for (i = 0; i < clk_data->clk_num; i++) {
> +               u32 bit;
> +               const char *clk_name;
> +
> +               if (of_property_read_u32_index(node, "clock-indices",
> +                               i, &bit))
> +                       goto out;
> +
> +               if (of_property_read_string_index(node, "clock-output-names",
> +                               i, &clk_name))
> +                       goto out;
> +
> +               if (bit >= clk_data->clk_num) {
> +                       pr_err("%s: clock bit %u out of range\n",
> +                               node->full_name, bit);
> +                       continue;
> +               }
> +
> +               if (!IS_ERR(clk_data->clks[bit])) {
> +                       pr_err("%s: clock bit %u already exists\n",
> +                               node->full_name, bit);
> +                       continue;
> +               }
> +
> +               clk_data->clks[bit] = of_bcm6345_clk_register(parent_name,
> +                                       clk_name, map, offset, BIT(bit));
> +               if (!IS_ERR(clk_data->clks[bit]))
> +                       clocks++;
> +       }
> +
> +out:
> +       if (clocks) {
> +               of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> +               pr_info("%s: registered %u clocks\n", node->name, clocks);
> +       } else {
> +               kfree(clk_data->clks);
> +               kfree(clk_data);
> +       }
> +}
> +
> +CLK_OF_DECLARE(bcm6345_clk, "brcm,bcm6345-gate-clk", of_bcm6345_clk_setup);

Please do not use CLK_OF_DECLARE unless there is a good reason. Ideally
this should be a platform_driver.

Regards,
Mike

> -- 
> 2.1.4
> 
> -- 
> Simon Arlott
