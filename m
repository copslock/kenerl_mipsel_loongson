Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Dec 2015 02:22:27 +0100 (CET)
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33025 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008760AbbLMBWZFnD4E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Dec 2015 02:22:25 +0100
Received: by qkck189 with SMTP id k189so56029555qkc.0
        for <linux-mips@linux-mips.org>; Sat, 12 Dec 2015 17:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PzgLJ//8SRtLByYe4damo8ObBwll+7hvlU1vgMsvxMc=;
        b=LWpikqrpAtrKgWT6zhmNu30+pdl0gqxkm25UopbyjJDwp8wEHoOthnng3/oIQy5W8o
         kkbwy81844ciLZ3RY89IlVTVziREFUHruYw7dKUEL9HorbxHwUKvgXfcV1VqKZ3Tc8T1
         LH8OpvK3WT3b3wmjHWrkuVqSCgcye4FlzwxE1/vg3Ys6taqEt5ZihHjvMYoqOCMaEYAN
         lz7gAJ5vhEnfm0873Mkxqqi/xltfs2t/kBFIlT/ZWPzywWMq7XlrwXFyXQd2WvQt9o9g
         pImasLav2oIw3MIOTuRNwNUDm/429ub66/H+zWhJe3RO1DTY9Mi08s0L1ZooSte5YTo6
         vinw==
MIME-Version: 1.0
X-Received: by 10.13.208.66 with SMTP id s63mr11213109ywd.20.1449969739227;
 Sat, 12 Dec 2015 17:22:19 -0800 (PST)
Received: by 10.37.224.143 with HTTP; Sat, 12 Dec 2015 17:22:19 -0800 (PST)
In-Reply-To: <1448900513-20856-25-git-send-email-paul.burton@imgtec.com>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
        <1448900513-20856-25-git-send-email-paul.burton@imgtec.com>
Date:   Sun, 13 Dec 2015 03:22:19 +0200
Message-ID: <CAHp75VdezHXFcV9T=bd8k5JHoogC39Hew5GCdd02rk=PEM6ajw@mail.gmail.com>
Subject: Re: [PATCH 24/28] net: pch_gbe: add device tree support
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <andy.shevchenko@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50565
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

On Mon, Nov 30, 2015 at 6:21 PM, Paul Burton <paul.burton@imgtec.com> wrote:
> Introduce support for retrieving the PHY reset GPIO from device tree,
> which will be used on the MIPS Boston development board. This requires
> support for probe deferral in order to work correctly, since the order
> of device probe is not guaranteed & typically the EG20T GPIO controller
> device will be probed after the ethernet MAC.
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
>
>  .../net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c   | 33 +++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
> index 824ff9e..f2a9a38 100644
> --- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
> +++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
> @@ -23,6 +23,8 @@
>  #include <linux/net_tstamp.h>
>  #include <linux/ptp_classify.h>
>  #include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/of_gpio.h>
>
>  #define DRV_VERSION     "1.01"
>  const char pch_driver_version[] = DRV_VERSION;
> @@ -2594,13 +2596,41 @@ static void pch_gbe_remove(struct pci_dev *pdev)
>         free_netdev(netdev);
>  }
>
> +static int pch_gbe_parse_dt(struct pci_dev *pdev,
> +                           struct pch_gbe_privdata **pdata)

Why not to return pdata as it done in many other drivers?
You have ERR_PTR() macro to pass errors.

> +{
> +       struct device_node *np = pdev->dev.of_node;
> +       struct gpio_desc *gpio;
> +
> +       if (!config_enabled(CONFIG_OF) || !np)

Before I saw IS_ENABLED(). Is this one a preferable new API?

> +               return 0;
> +
> +       if (!*pdata)
> +               *pdata = devm_kzalloc(&pdev->dev, sizeof(**pdata), GFP_KERNEL);
> +       if (!*pdata)
> +               return -ENOMEM;
> +
> +       gpio = devm_gpiod_get(&pdev->dev, "phy-reset", GPIOD_ASIS);
> +       if (IS_ERR(gpio))
> +               return PTR_ERR(gpio);
> +
> +       (*pdata)->phy_reset_gpio = gpio;
> +       return 0;
> +}
> +
>  static int pch_gbe_probe(struct pci_dev *pdev,
>                           const struct pci_device_id *pci_id)
>  {
>         struct net_device *netdev;
>         struct pch_gbe_adapter *adapter;
> +       struct pch_gbe_privdata *pdata;
>         int ret;
>
> +       pdata = (struct pch_gbe_privdata *)pci_id->driver_data;
> +       ret = pch_gbe_parse_dt(pdev, &pdata);

So, I didn;t see anything related to dt in that function.
Maybe you just call it always? In that case remove check for np.

> +       if (ret)
> +               goto err_out;
> +
>         ret = pcim_enable_device(pdev);
>         if (ret)
>                 return ret;
> @@ -2638,7 +2668,7 @@ static int pch_gbe_probe(struct pci_dev *pdev,
>         adapter->pdev = pdev;
>         adapter->hw.back = adapter;
>         adapter->hw.reg = pcim_iomap_table(pdev)[PCH_GBE_PCI_BAR];
> -       adapter->pdata = (struct pch_gbe_privdata *)pci_id->driver_data;
> +       adapter->pdata = pdata;
>         if (adapter->pdata && adapter->pdata->platform_init)
>                 adapter->pdata->platform_init(pdev, pdata);
>
> @@ -2729,6 +2759,7 @@ err_free_adapter:
>         pch_gbe_hal_phy_hw_reset(&adapter->hw);
>  err_free_netdev:
>         free_netdev(netdev);
> +err_out:

Redundant.

>         return ret;
>  }

For now it's a common practice to mix styles in probe due to usage of
devres API.

-- 
With Best Regards,
Andy Shevchenko
