Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2012 11:09:52 +0200 (CEST)
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59623 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903596Ab2FSJJr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jun 2012 11:09:47 +0200
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
        by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 2A0DB20F50;
        Tue, 19 Jun 2012 05:09:43 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 19 Jun 2012 05:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=message-id:date:from:mime-version:to:cc
        :subject:references:in-reply-to:content-type
        :content-transfer-encoding; s=smtpout; bh=7D6TUZIjk6VFaBgB2uCyqi
        W6zsY=; b=R+kcbaEuT81rTReyWFaucy10Zh1bQOHpdtOYcHDV7WHPcM0IDkoD3+
        YclgzToxBIS21phOKN9K0/pvKjiKyM0Zocofod2SKGbTwT01dvNcY2fTUY0C3AKj
        wO8TXX8byKlri3FllN6ZIAYiffHAyVuno5KesxVjdd0CjrstladEw=
X-Sasl-enc: 9AAvXJ/XSUp1nT1g2WiOLIxwVjzb/C3sQ7akAf3xA3pR 1340096982
Received: from [10.1.2.65] (unknown [94.101.37.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id DDCD88E01D9;
        Tue, 19 Jun 2012 05:09:41 -0400 (EDT)
Message-ID: <4FE041D5.8030002@ladisch.de>
Date:   Tue, 19 Jun 2012 11:09:41 +0200
From:   Clemens Ladisch <clemens@ladisch.de>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
MIME-Version: 1.0
To:     Huacai Chen <chenhuacai@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        alsa-devel@alsa-project.org, Zhangjin Wu <wuzhangjin@gmail.com>,
        Hua Yan <yanh@lemote.com>, Fuxin Zhang <zhangfx@lemote.com>,
        Hongliang Tao <taohl@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: Re: [alsa-devel] [PATCH V2 13/16] ALSA: HDA: Make hda sound card
 usable for Loongson.
References: <1340088624-25550-1-git-send-email-chenhc@lemote.com> <1340088624-25550-14-git-send-email-chenhc@lemote.com>
In-Reply-To: <1340088624-25550-14-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-archive-position: 33709
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clemens@ladisch.de
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

Huacai Chen wrote:
> 1, Use 32-bit DMA as a workaround (Loongson has a hardware bug that it
>    doesn't support DMA address above 4GB).
> 2, Modify patch_conexant.c to add Lemote specific code.

Please create separate patches for these two changes.

> +++ b/include/linux/pci_ids.h
> @@ -2906,3 +2906,5 @@
>  #define PCI_DEVICE_ID_XEN_PLATFORM	0x0001
>
>  #define PCI_VENDOR_ID_OCZ		0x1b85
> +
> +#define PCI_VENDOR_ID_LEMOTE		0x1c06

AFAICS this symbol is not used in this patch.

> +#ifdef CONFIG_CPU_LOONGSON3
> +	/* Workaround: Loongson 3 doesn't support 64-bit DMA */
> +	gcap &= ~ICH6_GCAP_64OK;
> +#endif

	/* Workaround: Loongson 3 doesn't actually support 64-bit DMA */


Regards,
Clemens
