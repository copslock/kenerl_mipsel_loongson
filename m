Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2015 14:31:43 +0200 (CEST)
Received: from mail-ie0-f178.google.com ([209.85.223.178]:33699 "EHLO
        mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013157AbbETMblbAt33 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 May 2015 14:31:41 +0200
Received: by iebgx4 with SMTP id gx4so37590360ieb.0;
        Wed, 20 May 2015 05:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=qP8frRwHHdjMcHN2xzcPoSQTAcKtJf3z/+MZv3wOdUs=;
        b=MEJ1kevGLBKWi66o/W5xRGFFTuscFqHLQXZYZzQ2c/Jit5aUl5/+EJXHHFNGXoP6U5
         Ux7yVcZhygV/korLD58hy11z6BT5utBC0VLVsde1Y+9k53pqFcuoetsMatDyGqQsdktk
         n+bsrkJ9Z+GKolE/ybZxj0qi282hOEztFim+fLoCeQPoMzosMe9jqFQx8qwhC8Rd5OSq
         /09MOcFnwbSORlxgNFwB+4QJ6z7U8rAHzYEYm06h0IN/nIFR9eQgAD6iLbsGQoGj9A69
         QXNRmIMBeBLaTuPOexPaFQ/Bd916LqyCWgnOX4F64v41HgUAULRMq55XOR9uQp2eH3iw
         P1iw==
MIME-Version: 1.0
X-Received: by 10.42.85.147 with SMTP id q19mr5110465icl.96.1432125097973;
 Wed, 20 May 2015 05:31:37 -0700 (PDT)
Received: by 10.107.36.73 with HTTP; Wed, 20 May 2015 05:31:37 -0700 (PDT)
In-Reply-To: <1432122655-3224-1-git-send-email-arend@broadcom.com>
References: <1432122655-3224-1-git-send-email-arend@broadcom.com>
Date:   Wed, 20 May 2015 14:31:37 +0200
Message-ID: <CACna6rxeU0FUiTRNXFgK-xxSDY8WA82h7MLmcPc=7eM5sqMdBw@mail.gmail.com>
Subject: Re: [PATCH RESEND] mips: bcm47xx: allow retrieval of complete nvram contents
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Arend van Spriel <arend@broadcom.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Hante Meuleman <meuleman@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47492
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

On 20 May 2015 at 13:50, Arend van Spriel <arend@broadcom.com> wrote:
> From: Hante Meuleman <meuleman@broadcom.com>
>
> Host platforms such as routers supported by OpenWRT can
> support NVRAM reading directly from internal NVRAM store.
> The brcmfmac for one requires the complete nvram contents
> to select what needs to be sent to wireless device.

First of all, I have to ask you to rebase this patch on top of
upstream-sfr. Mostly because of
MIPS: BCM47XX: Make sure NVRAM buffer ends with \0


> @@ -146,20 +147,21 @@ static int nvram_init(void)
>                 return -ENODEV;
>
>         err = mtd_read(mtd, 0, sizeof(header), &bytes_read, (uint8_t *)&header);
> -       if (!err && header.magic == NVRAM_MAGIC) {
> -               u8 *dst = (uint8_t *)nvram_buf;
> -               size_t len = header.len;
> -
> -               if (header.len > NVRAM_SPACE) {
> +       if (!err && header.magic == NVRAM_MAGIC &&
> +           header.len > sizeof(header)) {
> +               if (header.len > NVRAM_SPACE - 2) {
>                         pr_err("nvram on flash (%i bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
>                                 header.len, NVRAM_SPACE);
> -                       len = NVRAM_SPACE;
> +                       header.len = NVRAM_SPACE - 2;
>                 }

I guess I preferred having "len" helper, but it's a minor thing.
What's the trick with this NVRAM_SPACE - 2? Requiring string I to be
ended with double \0 sounds like a wrong design in some driver. I
don't think it's anything common/any standard to mark the buffer end
with an extra \0. I'm pretty sure bcm47xx_nvram_getenv doesn't need it
and bcm47xx_nvram_get_contents you implemented provides buffer length
anyway.
Moreover this trick isn't compatible with what nvram_find_and_copy does.


> -               err = mtd_read(mtd, 0, len, &bytes_read, dst);
> +               err = mtd_read(mtd, 0, header.len, &bytes_read,
> +                              (u8 *)nvram_buf);
>                 if (err)
>                         return err;
>
> +               pheader = (struct nvram_header *)nvram_buf;
> +               pheader->len = header.len;

I preferred your OpenWrt patch version with just keeping a buffer
content length in separated variable. It won't kill us to have one
more static size_t and we'll at least keep a real header copy without
hacking it for implementation needs.
Again, what you did here doesn't match nvram_find_and_copy, so please
make sure you'll e.g. set content length variable in
nvram_find_and_copy as well.

-- 
Rafał
