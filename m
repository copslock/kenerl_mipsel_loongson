Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 May 2016 19:49:03 +0200 (CEST)
Received: from mail-lb0-f178.google.com ([209.85.217.178]:32984 "EHLO
        mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27029336AbcEPRs5nmap0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 May 2016 19:48:57 +0200
Received: by mail-lb0-f178.google.com with SMTP id jj5so52759164lbc.0
        for <linux-mips@linux-mips.org>; Mon, 16 May 2016 10:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=my55+r4j4lfhEwc5azPtqetNzLpWLQtQ6RR+is96hnw=;
        b=YgcC/hr8iAa4w0cZCEb659AAckFcMwDsVYOXwtFiydyOdUQvtuUnaCsmCv6g0+Ek/+
         1lRJ9WJL40EUcRS78QWFuz5V+BgLi7vTPiaoBBTx38syhWTxoqvgtv9BW3tiHEtqmIA9
         V16cVcvYm7MYL1wr2f81lXFVqRyHrgqQU/hhXAGNPhDGGKbZPUs8wG06dGT/riyWPKYa
         83WFofIaML44uZWzhj4nQKf8QBuGcb2/cKBKTNgXwJ67T7MPY8HdvgAe5cM8QrmxRgxX
         8MB84RZioCAUr31wFkesCIO2trmJOEtwpBI+sj0iIErRaJg0PqLrBk7LIzsJt0A5HgR0
         im9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=my55+r4j4lfhEwc5azPtqetNzLpWLQtQ6RR+is96hnw=;
        b=l/A1Dh8tud4tGQu6cOPMyR7+6qWzIwJGFsURLlvbloynz92ligrwJY0ubFHclQCIBd
         w/IBd/KtUC2YXNNbNOma7KtPhyWrEzc8mT7sKHDUs7cZ9tuy7lFwMCM0PBp/2ajrhM7A
         pRXjDzwYT3w81ANCZelnRsJAWWRrU+FJxje9In0sqyGrSSsl+TajBod1oPtDi1HTYhan
         OylDubvX391N5q+9wwRMLIL+NsuspRBd3OUSsE875fHor9hDLhkNjmtxvRlpsHxcVIZA
         asrTHLQBBE8A8SSpV2nAeMtiYy3a/GuUhjCeRHgBCGIOJZi9w+6N8tOSptXc++fscTho
         yjQg==
X-Gm-Message-State: AOPr4FUzKIQQX/kd9rcP4gzzD/dzqjyu3zQIMQz2XBFH8csX1HEztf5rQor8oE3WB1F8qQ==
X-Received: by 10.112.141.135 with SMTP id ro7mr12054319lbb.0.1463420931509;
        Mon, 16 May 2016 10:48:51 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.86.208])
        by smtp.gmail.com with ESMTPSA id sg8sm5343339lbb.28.2016.05.16.10.48.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 May 2016 10:48:50 -0700 (PDT)
Subject: Re: [PATCH 2/2] MIPS: ath79: fix regression in PCI window
 initialization
To:     Felix Fietkau <nbd@nbd.name>, linux-mips@linux-mips.org
References: <1463311930-40536-1-git-send-email-nbd@nbd.name>
 <1463311930-40536-2-git-send-email-nbd@nbd.name>
Cc:     albeu@free.fr
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <bc4766ff-1d7d-05fb-75d1-7cf605a9dbc3@cogentembedded.com>
Date:   Mon, 16 May 2016 20:48:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.0
MIME-Version: 1.0
In-Reply-To: <1463311930-40536-2-git-send-email-nbd@nbd.name>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 05/15/2016 02:32 PM, Felix Fietkau wrote:

> ath79_ddr_pci_win_base has the type void __iomem *, so register offsets
> need to be a multiple of 4.
>
> Cc: Alban Bedel <albeu@free.fr>
> Fixes: 24b0e3e84fbf ("MIPS: ath79: Improve the DDR controller interface")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  arch/mips/ath79/common.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/mips/ath79/common.c b/arch/mips/ath79/common.c
> index 84d4502..5e26fd8 100644
> --- a/arch/mips/ath79/common.c
> +++ b/arch/mips/ath79/common.c
> @@ -76,14 +76,14 @@ void ath79_ddr_set_pci_windows(void)
>  {
>  	BUG_ON(!ath79_ddr_pci_win_base);
>
> -	__raw_writel(AR71XX_PCI_WIN0_OFFS, ath79_ddr_pci_win_base + 0);
> -	__raw_writel(AR71XX_PCI_WIN1_OFFS, ath79_ddr_pci_win_base + 1);
> -	__raw_writel(AR71XX_PCI_WIN2_OFFS, ath79_ddr_pci_win_base + 2);
> -	__raw_writel(AR71XX_PCI_WIN3_OFFS, ath79_ddr_pci_win_base + 3);
> -	__raw_writel(AR71XX_PCI_WIN4_OFFS, ath79_ddr_pci_win_base + 4);
> -	__raw_writel(AR71XX_PCI_WIN5_OFFS, ath79_ddr_pci_win_base + 5);
> -	__raw_writel(AR71XX_PCI_WIN6_OFFS, ath79_ddr_pci_win_base + 6);
> -	__raw_writel(AR71XX_PCI_WIN7_OFFS, ath79_ddr_pci_win_base + 7);
> +	__raw_writel(AR71XX_PCI_WIN0_OFFS, ath79_ddr_pci_win_base + 0x0);
> +	__raw_writel(AR71XX_PCI_WIN1_OFFS, ath79_ddr_pci_win_base + 0x4);
> +	__raw_writel(AR71XX_PCI_WIN2_OFFS, ath79_ddr_pci_win_base + 0x8);
> +	__raw_writel(AR71XX_PCI_WIN3_OFFS, ath79_ddr_pci_win_base + 0xc);
> +	__raw_writel(AR71XX_PCI_WIN4_OFFS, ath79_ddr_pci_win_base + 0x10);
> +	__raw_writel(AR71XX_PCI_WIN5_OFFS, ath79_ddr_pci_win_base + 0x14);
> +	__raw_writel(AR71XX_PCI_WIN6_OFFS, ath79_ddr_pci_win_base + 0x18);
> +	__raw_writel(AR71XX_PCI_WIN7_OFFS, ath79_ddr_pci_win_base + 0x20);

    Maybe 0x1c?

[...]

MBR, Sergei
