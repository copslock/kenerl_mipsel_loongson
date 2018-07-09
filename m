Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jul 2018 22:36:11 +0200 (CEST)
Received: from mail-lj1-x242.google.com ([IPv6:2a00:1450:4864:20::242]:35416
        "EHLO mail-lj1-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993928AbeGIUgDPeqRO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Jul 2018 22:36:03 +0200
Received: by mail-lj1-x242.google.com with SMTP id p10-v6so9657301ljg.2;
        Mon, 09 Jul 2018 13:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=5Xll39+9VB7y/Ym4pxlOA5PZXitlr5bVmjsy7PHOOuY=;
        b=V0R0QMCWADQjuX09Xx+LleJZNLOt7yQKuo5OAX6/K7OQWllZvLYGDQZR5eztEk+6+r
         SyryGIQyBEl54n4kXK+RM9j5rWRs0aCBY4BSVbMTTxmhJgOUSrO3wvtT8rnFYx0AyH+j
         YYtaamCXgjKXHSTD5kd+gDmaxin3cndNj2i1myOwDVUGd/PEv2mjAV+m7IvrhBNXbsvH
         Uu14B/INEwZAS2nD+qu1sI3w5yWdBJv/5PPOpmI0vkJQMecxgI5qZIWtOkERYxZbcns7
         Ujy6qExum6UnW5NgZ+LOHR4kczdrh9zlVYSgLESndL2Hdq1M0FfvNVIhOr+8+6NRaO61
         pBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=5Xll39+9VB7y/Ym4pxlOA5PZXitlr5bVmjsy7PHOOuY=;
        b=aZWVJiafCjh/2D53APrmlkxK2JLUYM9czltkOKlIVdbdUOt3cx5ITVqCRDuJM/esED
         tqZ4x/l2joY3MhG+bZcNYZH5gLchN2oLH/sfqkO9KqNKd0xYiQf+KX1gYcCOjS8IpGs6
         WqiU5wPr+Jdy1+49z5c2sSdodbAL28Eb+rY79VkrhW4ny/OV0CFY4u3EWY9W91cO50mv
         Mx1H2Xj3Qi1tF3EDgPuNQrfntARGyho872KcLISm+5zPLhNToQ6mCFHdrMsKacRxBxId
         WqjhdtQYh6CgULOPChztrshL1m1PXDMzA4OLBnEFRV5Dz2/kbgcVu0kjVYzPDeJO4zXs
         pEsw==
X-Gm-Message-State: APt69E0DRES8glzqcdz7JbVtf7vSMBG5pz3NaXxswvXl2TOquX2kPZHE
        rI4VInsVmkeDF/1jtowRAVdQkgmbnfBJmQHBdyA=
X-Google-Smtp-Source: AAOMgpeWUvZKWg+Ku9CbyOvpCg5jW+esgNNKLmPrGMVbQY8FKdj0flnBgeaenv9JdzfNw1lk3FGcFwHcBck4S+BSkMg=
X-Received: by 2002:a2e:1bcc:: with SMTP id c73-v6mr13267355ljf.0.1531168557594;
 Mon, 09 Jul 2018 13:35:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 13:35:56 -0700 (PDT)
In-Reply-To: <20180709200945.30116-12-boris.brezillon@bootlin.com>
References: <20180709200945.30116-1-boris.brezillon@bootlin.com> <20180709200945.30116-12-boris.brezillon@bootlin.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 9 Jul 2018 22:35:56 +0200
X-Google-Sender-Auth: U1hqZo7VhBsHxYnC1mr6MQAJfZE
Message-ID: <CAK8P3a1Ndys3MMxLqL-hTFVDSZGm5ASEnQ7K+8dScvFrp=RTdA@mail.gmail.com>
Subject: Re: [PATCH v2 11/24] mtd: rawnand: sunxi: Make sure ret is
 initialized in sunxi_nfc_read_byte()
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64747
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Mon, Jul 9, 2018 at 10:09 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> Fixes the following smatch warning:
>
> drivers/mtd/nand/raw/sunxi_nand.c:551 sunxi_nfc_read_byte() error: uninitialized symbol 'ret'.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> ---
>  drivers/mtd/nand/raw/sunxi_nand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
> index 99043c3a4fa7..4b11cd4a79be 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
> @@ -544,7 +544,7 @@ static void sunxi_nfc_write_buf(struct mtd_info *mtd, const uint8_t *buf,
>
>  static uint8_t sunxi_nfc_read_byte(struct mtd_info *mtd)
>  {
> -       uint8_t ret;
> +       uint8_t ret = 0;
>
>         sunxi_nfc_read_buf(mtd, &ret, 1);
>

Should there perhaps be a warning when no data was returned after a timeout?

      Arnd
