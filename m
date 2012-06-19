Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2012 14:33:19 +0200 (CEST)
Received: from mail-gh0-f177.google.com ([209.85.160.177]:56802 "EHLO
        mail-gh0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903519Ab2FSMdM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jun 2012 14:33:12 +0200
Received: by ghbf11 with SMTP id f11so4908403ghb.36
        for <multiple recipients>; Tue, 19 Jun 2012 05:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=yYOsUDd8L4+KTbsIAshRDiX2aXQmEfKaRB2bBx2f3b4=;
        b=p2iI57Mks81UYpPD/y/sjr6yesRLxq3Xh7Beu316zyTHwfJGKkG3PSRXxvyy88BwKM
         FpkqTCAo60Ic2VswMo81k2Di9I8Bbv9xHgFxIOksbDJAUNa1VNy+gX/b/i3oEVok7d9a
         yRfGJJ2zZl9mNSEEXdFrDoEizkqUigmkJabBzOQxRfMqeIUWdiakeD5T7wisXJr6j9Nv
         pnkEly+x33ZG8NEtr3Wcgwlc5tcc288+8K3IitC7EQR8GoecYbbgLqMfs/dZ4jDHWUdp
         A8nJjogFX2lZsG1bYGs52FFIaBWkBz2IfylTwCgMRCCH/CRTYjJ5DktklVwDccs6xODG
         HKvQ==
Received: by 10.236.78.36 with SMTP id f24mr23035719yhe.20.1340109182882;
        Tue, 19 Jun 2012 05:33:02 -0700 (PDT)
Received: from bd.yyz.us ([2001:4830:1603:2:21c:c0ff:fe79:c8c2])
        by mx.google.com with ESMTPS id z9sm78648008yhl.6.2012.06.19.05.33.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Jun 2012 05:33:01 -0700 (PDT)
Message-ID: <4FE0717A.7070109@garzik.org>
Date:   Tue, 19 Jun 2012 08:32:58 -0400
From:   Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Huacai Chen <chenhuacai@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH V2 11/16] ata: Use 32-bit DMA in AHCI for Loongson-3.
References: <1340088624-25550-1-git-send-email-chenhc@lemote.com> <1340088624-25550-12-git-send-email-chenhc@lemote.com>
In-Reply-To: <1340088624-25550-12-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 33722
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@garzik.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 06/19/2012 02:50 AM, Huacai Chen wrote:
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index ebaf67e..3e3cfd8 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -183,7 +183,12 @@ static const struct ata_port_info ahci_port_info[] = {
>   	},
>   	[board_ahci_sb700] =	/* for SB700 and SB800 */
>   	{
> +#ifndef CONFIG_CPU_LOONGSON3
>   		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL),
> +#else
> +		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL |
> +						AHCI_HFLAG_32BIT_ONLY),
> +#endif
>   		.flags		= AHCI_FLAG_COMMON,


NAK -- the place to fix this up is ahci_init_one()
