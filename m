Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2012 15:39:06 +0200 (CEST)
Received: from mail-lpp01m010-f49.google.com ([209.85.215.49]:60573 "EHLO
        mail-lpp01m010-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903550Ab2CZNiw convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 26 Mar 2012 15:38:52 +0200
Received: by lagy4 with SMTP id y4so4654305lag.36
        for <linux-mips@linux-mips.org>; Mon, 26 Mar 2012 06:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=2vo6ID75yTv2iWhyG1YOEJInIzNHU9mtirOBkkGoiKU=;
        b=c9vRmMiV9O2iXqJ53D466mK7vxa0OlVjrWr//0axv9VJp5Htvn5tCn42Gq461l5wdu
         p8pU/XDcxG80LsstA8ceCbOn6XCiN06ZQk4lmgLbGzyTt2MWw/LZfOXFWB9ZJu+tqs3d
         XxYzpUy8zuWtg8OUg5QAj4pEYzsbP+O3bl8XhBaiHO0WpylYhj68o/qvn6R881tF73DD
         bDo65Ftr2bXBH5d8YqG2UeJm1dO5fLXDJvRJ8xW67Az7LocEuXxJ1YCiQ6O0HUQ1Srvr
         Vw91/Au+EOdOItBjjWaztdchr20UAwdRHRnIHRM6P7K6FZLG0kNmBY81OQSteaQ9K/E/
         gUkA==
MIME-Version: 1.0
Received: by 10.112.37.65 with SMTP id w1mr8297028lbj.27.1332769126469; Mon,
 26 Mar 2012 06:38:46 -0700 (PDT)
Received: by 10.112.80.8 with HTTP; Mon, 26 Mar 2012 06:38:46 -0700 (PDT)
In-Reply-To: <1332724306-8799-1-git-send-email-paul.gortmaker@windriver.com>
References: <1332724306-8799-1-git-send-email-paul.gortmaker@windriver.com>
Date:   Mon, 26 Mar 2012 09:38:46 -0400
Message-ID: <CAP=VYLpOJOueFfzxFGCu5cKQ9--F8CqC5JWjBxej7u=8z3K0xQ@mail.gmail.com>
Subject: Re: [PATCH] netdev: fix compile issues for !CONFIG_PCI in 3c59x
From:   Paul Gortmaker <paul.gortmaker@gmail.com>
To:     klassert@mathematik.tu-chemnitz.de
Cc:     netdev@vger.kernel.org, linux-mips@linux-mips.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 32751
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sun, Mar 25, 2012 at 9:11 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> I hate to add in more #ifdef CONFIG_PCI but there are already
> quite a few in this driver, and it seems like it hasn't been
> built with CONFIG_PCI set to off in quite some time.

Actually, please scrap this patch.  The uglyness of more ifdefs
made me look at it again.  It should be do-able in a cleaner way
with stubs, and it appears this may even be similar to an old fail
from the past:

http://lkml.indiana.edu/hypermail/linux/kernel/1107.3/00109.html

I'll dig into it some more and follow up.

Thanks,
Paul.

> The
> MIPS allmodconfig (ISA/EISA based) doesn't set CONFIG_PCI
> and that is why we are here looking at this, even though any
> modern platform has had PCI since 1995 or so.
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>
> diff --git a/drivers/net/ethernet/3com/3c59x.c b/drivers/net/ethernet/3com/3c59x.c
> index e463d10..36ad150 100644
> --- a/drivers/net/ethernet/3com/3c59x.c
> +++ b/drivers/net/ethernet/3com/3c59x.c
> @@ -999,6 +999,7 @@ static int __init vortex_eisa_init(void)
>        return vortex_cards_found - orig_cards_found + eisa_found;
>  }
>
> +#ifdef CONFIG_PCI
>  /* returns count (>= 0), or negative on error */
>  static int __devinit vortex_init_one(struct pci_dev *pdev,
>                                      const struct pci_device_id *ent)
> @@ -1045,6 +1046,7 @@ static int __devinit vortex_init_one(struct pci_dev *pdev,
>  out:
>        return rc;
>  }
> +#endif
>
>  static const struct net_device_ops boomrang_netdev_ops = {
>        .ndo_open               = vortex_open,
> @@ -1177,6 +1179,7 @@ static int __devinit vortex_probe1(struct device *gendev,
>                compaq_net_device = dev;
>        }
>
> +#ifdef CONFIG_PCI
>        /* PCI-only startup logic */
>        if (pdev) {
>                /* EISA resources already marked, so only PCI needs to do this here */
> @@ -1204,6 +1207,7 @@ static int __devinit vortex_probe1(struct device *gendev,
>                        }
>                }
>        }
> +#endif
>
>        spin_lock_init(&vp->lock);
>        spin_lock_init(&vp->mii_lock);
> @@ -1321,7 +1325,7 @@ static int __devinit vortex_probe1(struct device *gendev,
>                        step, (eeprom[4]>>5) & 15, eeprom[4] & 31, eeprom[4]>>9);
>        }
>
> -
> +#ifdef CONFIG_PCI
>        if (pdev && vci->drv_flags & HAS_CB_FNS) {
>                unsigned short n;
>
> @@ -1348,6 +1352,7 @@ static int __devinit vortex_probe1(struct device *gendev,
>                        window_write16(vp, 0x0800, 0, 0);
>                }
>        }
> +#endif
>
>        /* Extract our information from the EEPROM data. */
>        vp->info1 = eeprom[13];
> @@ -3222,6 +3227,7 @@ static void acpi_set_WOL(struct net_device *dev)
>  }
>
>
> +#ifdef CONFIG_PCI
>  static void __devexit vortex_remove_one(struct pci_dev *pdev)
>  {
>        struct net_device *dev = pci_get_drvdata(pdev);
> @@ -3269,6 +3275,7 @@ static struct pci_driver vortex_driver = {
>        .id_table       = vortex_pci_tbl,
>        .driver.pm      = VORTEX_PM_OPS,
>  };
> +#endif
>
>
>  static int vortex_have_pci;
> @@ -3277,9 +3284,13 @@ static int vortex_have_eisa;
>
>  static int __init vortex_init(void)
>  {
> -       int pci_rc, eisa_rc;
> +       int eisa_rc;
> +#ifdef CONFIG_PCI
> +       int pci_rc = pci_register_driver(&vortex_driver);
> +#else
> +       int pci_rc = -ENODEV;
> +#endif
>
> -       pci_rc = pci_register_driver(&vortex_driver);
>        eisa_rc = vortex_eisa_init();
>
>        if (pci_rc == 0)
> @@ -3318,8 +3329,10 @@ static void __exit vortex_eisa_cleanup(void)
>
>  static void __exit vortex_cleanup(void)
>  {
> +#ifdef CONFIG_PCI
>        if (vortex_have_pci)
>                pci_unregister_driver(&vortex_driver);
> +#endif
>        if (vortex_have_eisa)
>                vortex_eisa_cleanup();
>  }
> --
> 1.7.9.4
>
>
