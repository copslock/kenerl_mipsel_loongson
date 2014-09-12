Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Sep 2014 20:35:47 +0200 (CEST)
Received: from mail-wg0-f41.google.com ([74.125.82.41]:60373 "EHLO
        mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008338AbaILSfphBdun (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Sep 2014 20:35:45 +0200
Received: by mail-wg0-f41.google.com with SMTP id k14so1153937wgh.12
        for <linux-mips@linux-mips.org>; Fri, 12 Sep 2014 11:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=zU9vQpTPFrjWgcN9W21ujjKFtzaTEtTKEwzh8tJftZs=;
        b=VXIqhre66KL0Ja1vH/ZEdNKcWw/E+8XfBN0idjSQjQudSmhkvnZt/8xfKB4P+r2FnV
         ozGzUC60OEYLtDa8ejeXkiHiyBLse2TDsHjKHxTDHGYTVYIASTpziVCnrJltY8hoyoxT
         p8V+YVPmI/lLt6gquCWDDC+qb2bgXvPHeCMOkrNroj3Wv1RACwS7F5/Uu03ZvxdyuYXp
         yZBTVxvG/gPGC9c3MXQgcVMcaddDeNq+woOofC9dewvcSAVsTSpl3fKaOL+RDBpZQSxp
         36oQw561Dv/Zf5OqySJyWL7MXn6r9uRJAlkAORIxndUaBMBe44JfvKDawPEgGxd1bH1H
         5kcg==
X-Gm-Message-State: ALoCoQleqHQ9enfzoF0AcxKonL95hD4E7HGFWqT8J+7wP2gfNT6j3TqOJ3v0rWa8IupAMYb1NzrQ
X-Received: by 10.180.94.161 with SMTP id dd1mr4729488wib.22.1410546937709;
        Fri, 12 Sep 2014 11:35:37 -0700 (PDT)
Received: from [192.168.122.210] (smart113.bb.netvision.net.il. [212.143.76.46])
        by mx.google.com with ESMTPSA id q13sm1646199wik.8.2014.09.12.11.35.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Sep 2014 11:35:36 -0700 (PDT)
Message-ID: <54133CF1.4040306@cogentembedded.com>
Date:   Fri, 12 Sep 2014 21:35:29 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
MIME-Version: 1.0
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, nbd@openwrt.org, james.hogan@imgtec.com,
        jchandra@broadcom.com, paul.burton@imgtec.com,
        david.daney@cavium.com, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org, markos.chandras@imgtec.com,
        macro@linux-mips.org, manuel.lauss@gmail.com,
        jerinjacobk@gmail.com, chenhc@lemote.com, blogic@openwrt.org
Subject: Re: [PATCH V2] MIPS: bugfix of coherentio variable default setup
References: <20140908191002.13852.47842.stgit@linux-yegoshin>
In-Reply-To: <20140908191002.13852.47842.stgit@linux-yegoshin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42524
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

On 9/8/2014 10:10 PM, Leonid Yegoshin wrote:

> Patch commit b6d92b4a6bdb880b39789c677b952c53a437028d

    Just commit.

>      MIPS: Add option to disable software I/O coherency.

    It's enough to just cite the summary in parens after SHA1 ID.

>      Some MIPS controllers have hardware I/O coherency. This patch
>      detects those and turns off software coherency. A new kernel
>      command line option also allows the user to manually turn
>      software coherency on or off.

> in fact enforces L2 cache flushes even on systems with IOCU.
> The default value of coherentio is 0 and is not changed even with IOCU.
> It is a serious performance problem because it destroys all IOCU performance
> advantages.

> It is fixed by setting coherentio to tri-state with default value as (-1) and
> setup a final value during platform coherency setup.

> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> ---
> V2: Missed signature added
> ---
>   arch/mips/include/asm/mach-generic/dma-coherence.h |    7 ++++++-
>   arch/mips/mm/c-r4k.c                               |    2 +-
>   arch/mips/mm/dma-default.c                         |    2 +-
>   arch/mips/mti-malta/malta-setup.c                  |    8 ++++++--
>   arch/mips/pci/pci-alchemy.c                        |    2 +-
>   5 files changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/arch/mips/include/asm/mach-generic/dma-coherence.h b/arch/mips/include/asm/mach-generic/dma-coherence.h
> index 7629c35..b4563df 100644
> --- a/arch/mips/include/asm/mach-generic/dma-coherence.h
> +++ b/arch/mips/include/asm/mach-generic/dma-coherence.h
> @@ -49,7 +49,12 @@ static inline int plat_dma_supported(struct device *dev, u64 mask)
>
>   static inline int plat_device_is_coherent(struct device *dev)
>   {
> -	return coherentio;
> +#ifdef CONFIG_DMA_COHERENT
> +	return 1;
> +#else
> +	return (coherentio > 0);

    *return* never needs parens around the value.

> +#endif
> +
>   }
>
>   #ifdef CONFIG_SWIOTLB
> diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
> index db7c9e5..48039fd 100644
> --- a/arch/mips/mti-malta/malta-setup.c
> +++ b/arch/mips/mti-malta/malta-setup.c
> @@ -147,13 +147,17 @@ static void __init plat_setup_iocoherency(void)
>   	if (plat_enable_iocoherency()) {
>   		if (coherentio == 0)
>   			pr_info("Hardware DMA cache coherency disabled\n");
> -		else
> +		else {
> +			coherentio = 1;

    You now need the parens around another arm of the *if* statement too. Such 
is the kernel style. :-)

>   			pr_info("Hardware DMA cache coherency enabled\n");
> +		}
>   	} else {
>   		if (coherentio == 1)
>   			pr_info("Hardware DMA cache coherency unsupported, but enabled from command line!\n");
> -		else
> +		else {
> +			coherentio = 0;

    Likewise.

>   			pr_info("Software DMA cache coherency enabled\n");
> +		}
>   	}
>   #else
>   	if (!plat_enable_iocoherency())

WBR, Sergei
