Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Mar 2012 23:00:00 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:38050 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901163Ab2CKV7p convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 11 Mar 2012 22:59:45 +0100
Received: by iaky10 with SMTP id y10so7126118iak.36
        for <multiple recipients>; Sun, 11 Mar 2012 14:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=OQHb3MNBb4Q8EbluyT6wBsi3kZDex1UyDKeu3c5X4IA=;
        b=jKmbXeqjHVxc7hbJ9v+Z3KJcx6kbJtiY/5cbmvwt1mXUiFG+9Z8y0HuWXu77NOmpHA
         gP7EysyKEVsDg3/Q/PhtS4Sdvgk6XtY0t+NZO2xofg/XA0QKgy4HfguEuSmbGFv9rkpe
         cGuzwDxLZrjFvv1elqEZVT/AhXVOlLO4PMB1tbJVnZs5Gvli6M1DGq/JZSAlULeqciud
         zpDftmfyB06XZ2xDlxjB53AI0mDflWVV/uwkZ71Y8u74GKYEWwDik4fkBin9jPw8Gk/s
         wElWmHrZ/J9u73U5aFm/UvpAfpY8i20v/WU+qRkzBbBF+Oph8O0DbdoEChLOtjxIi+VI
         tXTA==
Received: by 10.43.48.65 with SMTP id uv1mr12835034icb.57.1331503178208; Sun,
 11 Mar 2012 14:59:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.42.239.197 with HTTP; Sun, 11 Mar 2012 14:59:18 -0700 (PDT)
In-Reply-To: <1331496505-18697-4-git-send-email-hauke@hauke-m.de>
References: <1331496505-18697-1-git-send-email-hauke@hauke-m.de> <1331496505-18697-4-git-send-email-hauke@hauke-m.de>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Mon, 12 Mar 2012 08:59:18 +1100
Message-ID: <CAGRGNgX116dRB03NTL_DFZ4b_PYcdY+Un_cVwt6ZUGR1bwZzHA@mail.gmail.com>
Subject: Re: [PATCH 3/7] bcma: scan for extra address space
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        linux-mips@linux-mips.org, ralf@linux-mips.org, m@bues.ch,
        linux-usb@vger.kernel.org,
        =?ISO-8859-2?Q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 32650
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julian.calaby@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Hauke,

On Mon, Mar 12, 2012 at 07:08, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> Some cores like the USB core have two address spaces. In the USB host
> controller one address space is used for the OHCI and the other for the
> EHCI controller interface. The USB controller is the only core I found
> with two address spaces. This code is based on the AI scan function
> ai_scan() in shared/aiutils.c i the Broadcom SDK.
>
> CC: Rafał Miłecki <zajec5@gmail.com>
> CC: linux-wireless@vger.kernel.org
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  drivers/bcma/scan.c       |   18 +++++++++++++++++-
>  include/linux/bcma/bcma.h |    1 +
>  2 files changed, 18 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/bcma/scan.c b/drivers/bcma/scan.c
> index 3a2f672..3c2eeed 100644
> --- a/drivers/bcma/scan.c
> +++ b/drivers/bcma/scan.c
> @@ -286,6 +286,22 @@ static int bcma_get_next_core(struct bcma_bus *bus, u32 __iomem **eromptr,
>                        return -EILSEQ;
>        }
>
> +
> +       /* First Slave Address Descriptor should be port 0:
> +        * the main register space for the core
> +        */
> +       tmp = bcma_erom_get_addr_desc(bus, eromptr, SCAN_ADDR_TYPE_SLAVE, 0);
> +       if (tmp <= 0) {
> +               /* Try again to see if it is a bridge */
> +               tmp = bcma_erom_get_addr_desc(bus, eromptr,
> +                                             SCAN_ADDR_TYPE_BRIDGE, 0);
> +               if (tmp > 0) {
> +                       pr_info("found bridge");
> +                       return -ENXIO;
> +               }

Should this do something if the second bcma_erom_get_addr_desc() call
returns an error? We seem to be putting any errors from that call into
the addr member of the core structure below.

> +       }
> +       core->addr = tmp;
> +
>        /* get & parse slave ports */
>        for (i = 0; i < ports[1]; i++) {
>                for (j = 0; ; j++) {
> @@ -298,7 +314,7 @@ static int bcma_get_next_core(struct bcma_bus *bus, u32 __iomem **eromptr,
>                                break;
>                        } else {
>                                if (i == 0 && j == 0)
> -                                       core->addr = tmp;
> +                                       core->addr1 = tmp;
>                        }
>                }
>        }
> diff --git a/include/linux/bcma/bcma.h b/include/linux/bcma/bcma.h
> index 83c209f..7fe41e1 100644
> --- a/include/linux/bcma/bcma.h
> +++ b/include/linux/bcma/bcma.h
> @@ -138,6 +138,7 @@ struct bcma_device {
>        u8 core_index;
>
>        u32 addr;
> +       u32 addr1;
>        u32 wrap;
>
>        void __iomem *io_addr;
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
