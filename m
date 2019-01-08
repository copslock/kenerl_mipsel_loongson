Return-Path: <SRS0=z0u9=PQ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67BAC43387
	for <linux-mips@archiver.kernel.org>; Tue,  8 Jan 2019 07:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730E021855
	for <linux-mips@archiver.kernel.org>; Tue,  8 Jan 2019 07:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfAHHly convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 8 Jan 2019 02:41:54 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42927 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfAHHly (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 8 Jan 2019 02:41:54 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so1345068pga.9
        for <linux-mips@vger.kernel.org>; Mon, 07 Jan 2019 23:41:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=weY2G5aQBDhO3jIm3NUJpJY/rBrVKgGngTvEhg1rawg=;
        b=V9/Yz5QvTN5KDBB59ocKPtZLAKZTuaAwuBu264SVyk9xBFNkVJHj3mFeKgAzrLxAN8
         dIqNTe6E95bwYN/iQwbRD9+zEiJwLMXvEP0gB1E4TUTHm3Tpj1z57FA4Db/6ufgwHtyc
         S/530klR40FRUCVfI8SdfUj2qb0zCUuSO3eLXF0BOoi5RefxXKpwbmvw6sWM492LGfST
         KPoMEcIZ85VkrENA2bXObvTA5ebftMtCSUfmoZjQMwxkrT1PRuZDFzdc09MG9f3hmqDV
         c7TH4twS8mIA9ki7NrsLQm4L1rESHvYEQg7n1gr4dzIYdDCGOHSjpbSiSmk0cV8O/RgD
         NOCQ==
X-Gm-Message-State: AJcUukdOfUA04PRrDTeFwgmWR0pJyENKLCqi+B8lA7Xq8TO1AcfEdjOY
        k15fc8DdgfzuEL0CimpFloIyxZj+fnRojTKB8+I=
X-Google-Smtp-Source: ALg8bN4fRjPxGWmKqGv0RrjSRGODs+j7xR79c2ApzSajdBYrTY7JCY/WkfAX9gEXr1dOUzSRTVuaH6p3VqpIHdecz3w=
X-Received: by 2002:a62:4c5:: with SMTP id 188mr721092pfe.130.1546933313415;
 Mon, 07 Jan 2019 23:41:53 -0800 (PST)
MIME-Version: 1.0
References: <20190108054510.7393-1-syq@debian.org>
In-Reply-To: <20190108054510.7393-1-syq@debian.org>
From:   YunQiang Su <syq@debian.org>
Date:   Tue, 8 Jan 2019 15:41:42 +0800
Message-ID: <CAKcpw6V3MfFZsr8f2kMSHO7do4jWVEpUVgUxivKRD3qNoce2sQ@mail.gmail.com>
Subject: Re: [PATCH v2] Disable MSI also when pcie-octeon.pcie_disable on
To:     Paul Burton <pburton@wavecomp.com>,
        linux-mips <linux-mips@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     YunQiang Su <ysu@wavecomp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

YunQiang Su <syq@debian.org> 于2019年1月8日周二 下午1:45写道：
>
> From: YunQiang Su <ysu@wavecomp.com>
>
> Octeon has an boot-time option to disable pcie.
>
> Since MSI depends on PCI-E, we should also disable MSI also with
> this options is on.
>
> Signed-off-by: YunQiang Su <ysu@wavecomp.com>
> ---
>  arch/mips/pci/msi-octeon.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/pci/msi-octeon.c b/arch/mips/pci/msi-octeon.c
> index 2a5bb849b..288b58b00 100644
> --- a/arch/mips/pci/msi-octeon.c
> +++ b/arch/mips/pci/msi-octeon.c
> @@ -369,7 +369,9 @@ int __init octeon_msi_initialize(void)
>         int irq;
>         struct irq_chip *msi;
>
> -       if (octeon_dma_bar_type == OCTEON_DMA_BAR_TYPE_PCIE) {
> +       if (octeon_dma_bar_type == OCTEON_DMA_BAR_TYPE_INVALID) {
> +               return 0;
> +       } else if (octeon_dma_bar_type == OCTEON_DMA_BAR_TYPE_PCIE) {

This code snip appears when 2.6.36, and this boot time option first
appears when 3.3.
So, when backport, it make sense for 3.3+.

>                 msi_rcv_reg[0] = CVMX_PEXP_NPEI_MSI_RCV0;
>                 msi_rcv_reg[1] = CVMX_PEXP_NPEI_MSI_RCV1;
>                 msi_rcv_reg[2] = CVMX_PEXP_NPEI_MSI_RCV2;
> --
> 2.20.1
>
