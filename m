Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 May 2017 08:06:07 +0200 (CEST)
Received: from mail-qt0-x242.google.com ([IPv6:2607:f8b0:400d:c0d::242]:35646
        "EHLO mail-qt0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991957AbdEVGGAMRqgg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 May 2017 08:06:00 +0200
Received: by mail-qt0-x242.google.com with SMTP id r58so16955230qtb.2;
        Sun, 21 May 2017 23:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ba0Z33uWQ61fP5w5kkNtQZbeDPfZZ1mBj7I9KHTfKXE=;
        b=bT9XCSEj3AfoqmnyKNSF7h5Q0pnM606jlx+J1C8XZcnzUxnKl8uOtqKgoctj/wxfw3
         IasQ3UV3irQHswlFVcRwCoZiILOCFJJivoYg6xBE3jzxVwwV/EgcCRK0tC+y9ewtp5Cm
         hPoH9vSDVIm9hMcqObjc9zW759gN/mx/kc/rVH2X5v1dIkIm688WaG5NwwTooI5iEfYF
         sv6hgaFzQrG159XGBHc9s+/8M3ezIQeaYee2kL6G1maMFEgda1vtdgq5gnpcItJODK+O
         s41Drgorg81cg4m64A15c/R1brlCfZdIQ7Kouz+gPyNQJFrKmAlZyZZD+h6M57pL31gW
         8Czw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ba0Z33uWQ61fP5w5kkNtQZbeDPfZZ1mBj7I9KHTfKXE=;
        b=M8KR3OWocmYBJtoiJHnu4VcP3h0V+w1xf8hkai8uXr8Nfs+D95f4mrXp6maGej/rRk
         vad4HbaC+dtZVZEVKyAjchFJgnkllNoGis4dkEVW5qbr1EYm/s0hQwft6VEvP2O1NNak
         zLZ4+CqXhmXBcxAMpORkoiCn4eIGDTLxJnGKiUFsCwSkn6ma4zI+TF8vLSsLCl62LFCK
         iPxX3i7PDD8/evwCxRUnVLWr8cfiQP/1j2sx79Ho3v5IdsJSCkhR+6slwK3G40eKHhM2
         eKZDZI3hS/ySkFk6qQwbpOwBqljxEL5XAUh/cxgDH4Rs9d8enDyeElqw2x98/XXYfcRP
         HLsw==
X-Gm-Message-State: AODbwcBEpN9EOz6kHICFAKzCH9s0cRlRm7QhnCnqNV3zdl41kHvL/MC9
        Qs0min12+xcQqhrSv5NRAygnyEqIYw==
X-Received: by 10.200.38.76 with SMTP id v12mr22490779qtv.257.1495433154391;
 Sun, 21 May 2017 23:05:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.152.71 with HTTP; Sun, 21 May 2017 23:05:53 -0700 (PDT)
In-Reply-To: <20170521130918.27446-8-hauke@hauke-m.de>
References: <20170521130918.27446-1-hauke@hauke-m.de> <20170521130918.27446-8-hauke@hauke-m.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 22 May 2017 09:05:53 +0300
Message-ID: <CAHp75VeQgekiWc+YxP5sDFBB4fvmRs1=heFcdYS6mAgqPACW7g@mail.gmail.com>
Subject: Re: [PATCH v2 07/15] MIPS: lantiq: Convert the xbar driver to a platform_driver
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        linux-watchdog@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi <linux-spi@vger.kernel.org>, hauke.mehrtens@intel.com,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <andy.shevchenko@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57927
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.shevchenko@gmail.com
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

On Sun, May 21, 2017 at 4:09 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> This allows using the xbar driver on ARX300 based SoCs which require the
> same xbar setup as the xRX200 chipsets because the xbar driver
> initialization is not guarded by an xRX200 specific
> of_machine_is_compatible condition anymore. Additionally the new driver
> takes a syscon phandle to configure the XBAR endianness bits in RCU
> (before this was done in arch/mips/lantiq/xway/reset.c and also
> guarded by an VRX200 specific if-statement).

> +#include <linux/ioport.h>

I'm not sure you need this.

> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>

> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_address.h>

And these lines are under question, see below.

> +#include <linux/regmap.h>
> +

> +#include <lantiq_soc.h>

This rather should be "lantiq_soc.h"

> +static int ltq_xbar_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct device_node *np = dev->of_node;
> +       struct resource res_xbar;
> +       struct regmap *rcu_regmap;
> +       void __iomem *xbar_membase;
> +       u32 rcu_ahb_endianness_reg_offset;
> +       u32 rcu_ahb_endianness_val;
> +       int ret;
> +

> +       ret = of_address_to_resource(np, 0, &res_xbar);
> +       if (ret) {
> +               dev_err(dev, "Failed to get xbar resources");
> +               return ret;
> +       }
> +
> +       if (!devm_request_mem_region(dev, res_xbar.start,
> +                                    resource_size(&res_xbar),
> +               res_xbar.name)) {
> +               dev_err(dev, "Failed to get xbar resources");
> +               return -ENODEV;
> +       }
> +
> +       xbar_membase = devm_ioremap_nocache(dev, res_xbar.start,
> +                                               resource_size(&res_xbar));
> +       if (!xbar_membase) {
> +               dev_err(dev, "Failed to remap xbar resources");
> +               return -ENODEV;
> +       }

And what's wrong with traditional pattern

y = platform_get_resource(IOMEM);
x = devm_ioremap_resource(y);
if (IS_ERR(x))
 return PTR_ERR(x);

?

> +
> +       /* RCU configuration is optional */
> +       rcu_regmap = syscon_regmap_lookup_by_phandle(np, "lantiq,rcu-syscon");
> +       if (!IS_ERR_OR_NULL(rcu_regmap)) {

> +               if (of_property_read_u32_index(np, "lantiq,rcu-syscon", 1,
> +                       &rcu_ahb_endianness_reg_offset)) {

device_property_*() ?

> +                       dev_err(&pdev->dev, "Failed to get RCU reg offset\n");
> +                       return -EINVAL;
> +               }
> +
> +               if (of_device_is_big_endian(np))

Do we have common helper for this (I mean resource provider agnostic one)?

> +                       rcu_ahb_endianness_val = RCU_VR9_BE_AHB1S;
> +               else
> +                       rcu_ahb_endianness_val = 0;
> +
> +               if (regmap_update_bits(rcu_regmap,
> +                                       rcu_ahb_endianness_reg_offset,
> +                                       RCU_VR9_BE_AHB1S,
> +                                       rcu_ahb_endianness_val))
> +                       dev_warn(&pdev->dev,
> +                               "Failed to configure RCU AHB endianness\n");
> +       }
> +
> +       /* disable fpi burst */
> +       ltq_w32_mask(XBAR_FPI_BURST_EN, 0,
> +                    xbar_membase + XBAR_ALWAYS_LAST);
> +
> +       return 0;
> +}

> +builtin_platform_driver(xbar_driver);

Why it can't be module?

-- 
With Best Regards,
Andy Shevchenko
