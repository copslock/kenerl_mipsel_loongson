Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2009 17:36:28 +0100 (BST)
Received: from smtp-out.google.com ([216.239.45.13]:56638 "EHLO
	smtp-out.google.com") by ftp.linux-mips.org with ESMTP
	id S20024241AbZCaQgV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2009 17:36:21 +0100
Received: from wpaz29.hot.corp.google.com (wpaz29.hot.corp.google.com [172.24.198.93])
	by smtp-out.google.com with ESMTP id n2VGaHFw018291
	for <linux-mips@linux-mips.org>; Tue, 31 Mar 2009 09:36:18 -0700
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1238517378; bh=57vL9RXOM2zmshfEFQaoJc6qhrc=;
	h=DomainKey-Signature:MIME-Version:In-Reply-To:References:Date:
	 Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-System-Of-Record; b=AcSjZHqrf0793UD44u
	+nJ4GUV/8QvIN5zNGesqBK8J5+qnIlax5OcCIuIAjUnzRo7cLHvVkTDKGOH8jW9VyXH
	A==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to:
	cc:content-type:content-transfer-encoding:x-system-of-record;
	b=xyZVkMJrRcx49SOtdW3KP5nrOKQbfFM7wStLis4aVN29IkkCZtwbWafD7IY1kTnjh
	9Bk0iWmuFveupWMyEhMMA==
Received: from gxk8 (gxk8.prod.google.com [10.202.11.8])
	by wpaz29.hot.corp.google.com with ESMTP id n2VGZFM1002459
	for <linux-mips@linux-mips.org>; Tue, 31 Mar 2009 09:36:16 -0700
Received: by gxk8 with SMTP id 8so5601433gxk.5
        for <linux-mips@linux-mips.org>; Tue, 31 Mar 2009 09:36:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.231.20.2 with SMTP id d2mr1406971ibb.37.1238517375660; Tue, 31 
	Mar 2009 09:36:15 -0700 (PDT)
In-Reply-To: <1238516136-15852-1-git-send-email-anemo@mba.ocn.ne.jp>
References: <1238516136-15852-1-git-send-email-anemo@mba.ocn.ne.jp>
Date:	Tue, 31 Mar 2009 09:36:15 -0700
Message-ID: <da824cf30903310936p75469518j9bb28421b1ee81b8@mail.gmail.com>
Subject: Re: [PATCH] tx4939ide: remove wmb()
From:	Grant Grundler <grundler@google.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	linux-ide@vger.kernel.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-System-Of-Record: true
Return-Path: <grundler@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grundler@google.com
Precedence: bulk
X-list: linux-mips

On Tue, Mar 31, 2009 at 9:15 AM, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> * define CHECK_DMA_MASK
> * remove use of wmb()
>
> Suggested-by: Grant Grundler <grundler@google.com>

Thank you for the attribution!

But I think proper header would be:
    Reported-by: Grant Grundler <grundler@google.com>

But in this case, since i've looked at the code and am under the
illusion I understand it, I'm comfortable with:
    Reviewed-by: Grant Grundler <grundler@google.com>

thanks!
grant

> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
> This patch is against linux-next 20090331.
>
>  drivers/ide/tx4939ide.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/ide/tx4939ide.c b/drivers/ide/tx4939ide.c
> index cc269c0..48186ae 100644
> --- a/drivers/ide/tx4939ide.c
> +++ b/drivers/ide/tx4939ide.c
> @@ -327,15 +327,15 @@ static int tx4939ide_dma_end(ide_drive_t *drive)
>        /* read and clear the INTR & ERROR bits */
>        dma_stat = tx4939ide_clear_dma_status(base);
>
> -       wmb();
> +#define CHECK_DMA_MASK (ATA_DMA_ACTIVE | ATA_DMA_ERR | ATA_DMA_INTR)
>
>        /* verify good DMA status */
> -       if ((dma_stat & (ATA_DMA_INTR | ATA_DMA_ERR | ATA_DMA_ACTIVE)) == 0 &&
> +       if ((dma_stat & CHECK_DMA_MASK) == 0 &&
>            (ctl & (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST)) ==
>            (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST))
>                /* INT_IDE lost... bug? */
>                return 0;
> -       return ((dma_stat & (ATA_DMA_INTR | ATA_DMA_ERR | ATA_DMA_ACTIVE)) !=
> +       return ((dma_stat & CHECK_DMA_MASK) !=
>                ATA_DMA_INTR) ? 0x10 | dma_stat : 0;
>  }
>
> --
> 1.5.6.3
>
>
