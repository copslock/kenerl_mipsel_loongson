Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2015 01:00:20 +0100 (CET)
Received: from mail-io0-f178.google.com ([209.85.223.178]:35326 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007910AbbLHAAS3fEAl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2015 01:00:18 +0100
Received: by ioc74 with SMTP id 74so7666087ioc.2;
        Mon, 07 Dec 2015 16:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=RzaRxnh/yHJzWY08pCL/Mqq5Z1Fb9um74gFJWqXOXBY=;
        b=llVFDyNwhfGrmVFapxcarAdb1yFAzrzju+Pg0MELwRm6OZ5XRU4Z9satoI+qeeRNYr
         re9PytDu/pkbMD+OM/mnoRgUBz9Q0dCt64VHai8NlOJVWZXcsvs9Zn5nv7wupsOZp18r
         fFxXpepP3CtPK1Ws9oc4wKNu8r48wbswsklb2Oa20dVwcnguWYO/VJEccW5TDuuDlQeG
         aHjT/sx2CQY1h9+N4Rb31J8vEve9caiyqm4oySbPkA7MVLSY2QXAbLAo1AQKUXp7c5/I
         RYWopYB76l44/vLZg5J+3WLYh5dS+z0Ip9AZP4S7tXmO8+VpGbfNNK4MjpQmKs4dsGP7
         uomQ==
X-Received: by 10.107.153.11 with SMTP id b11mr1124422ioe.95.1449532812589;
 Mon, 07 Dec 2015 16:00:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.111.1 with HTTP; Mon, 7 Dec 2015 15:59:53 -0800 (PST)
In-Reply-To: <1449527178-5930-22-git-send-email-boris.brezillon@free-electrons.com>
References: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
 <1449527178-5930-22-git-send-email-boris.brezillon@free-electrons.com>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Tue, 8 Dec 2015 10:59:53 +1100
Message-ID: <CAGRGNgV09JJ7+hDVJwZcp89nEsgNS6r2Mo1_R+EEAT9=aR-Z_g@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 21/23] staging: mt29f_spinand: switch to mtd_ooblayout_ops
To:     boris.brezillon@free-electrons.com
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-mtd@lists.infradead.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Josh Wu <josh.wu@atmel.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Stefan Agner <stefan@agner.ch>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        punnaiah choudary kalluri <punnaia@xilinx.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <julian.calaby@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50407
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julian.calaby@gmail.com
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

Hi Boris,

On Tue, Dec 8, 2015 at 9:26 AM, Boris Brezillon
<boris.brezillon@free-electrons.com> wrote:
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/staging/mt29f_spinand/mt29f_spinand.c | 44 ++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.c b/drivers/staging/mt29f_spinand/mt29f_spinand.c
> index cb9d5ab..967d50a 100644
> --- a/drivers/staging/mt29f_spinand/mt29f_spinand.c
> +++ b/drivers/staging/mt29f_spinand/mt29f_spinand.c
> @@ -42,23 +42,29 @@ static inline struct spinand_state *mtd_to_state(struct mtd_info *mtd)
>  static int enable_hw_ecc;
>  static int enable_read_hw_ecc;
>
> -static struct nand_ecclayout spinand_oob_64 = {
> -       .eccbytes = 24,
> -       .eccpos = {
> -               1, 2, 3, 4, 5, 6,
> -               17, 18, 19, 20, 21, 22,
> -               33, 34, 35, 36, 37, 38,
> -               49, 50, 51, 52, 53, 54, },
> -       .oobfree = {
> -               {.offset = 8,
> -                       .length = 8},
> -               {.offset = 24,
> -                       .length = 8},
> -               {.offset = 40,
> -                       .length = 8},
> -               {.offset = 56,
> -                       .length = 8},
> -       }
> +static int spinand_oob_64_eccpos(struct mtd_info *mtd, int eccbyte)
> +{
> +       if (eccbyte > 23)
> +               return -ERANGE;
> +
> +       return ((eccbyte / 6) * 16) + 1;

Are you sure this is correct? My reading of this is that we'd get 1
for eccbytes 0 through 5.

Would

((eccbyte / 6) * 16) + (eccbyte % 6) + 1

be more correct?

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
