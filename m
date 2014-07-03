Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jul 2014 15:50:33 +0200 (CEST)
Received: from mail-la0-f47.google.com ([209.85.215.47]:57025 "EHLO
        mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6856084AbaGCNuaSnpMD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Jul 2014 15:50:30 +0200
Received: by mail-la0-f47.google.com with SMTP id s18so184872lam.6
        for <linux-mips@linux-mips.org>; Thu, 03 Jul 2014 06:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=QvkfwMNgdg2ItNCHute4jwIHro3FMLZIk0Uj9u1XE1Y=;
        b=fYiD0DhSXjhFbjd1HKjjALdfTt83fzyAXz3UHOoa4td1BvdjME5qoKnir/iSuwz8kB
         lZjGbznUqJCwVCVz1YAcmQcs1YV9hjQmaRms1qFpdgpY35J+ZjA9fF9xbQdPkXm2bnrt
         T5mOyY9GFrVo+LdL4o4rhxbZ+1VwIUzZezMLgcQSqkl4aVJ8vtuecxEp6ydjxg0/sTst
         1QzjkPtsfHG2CeGwQP52q4XEznnQDqd7bKgxymftHH4+uP3yFicZorN7jMQp2pRAxhWv
         e18uo7bdcLdjwlJx7L/b67/lTtwvdleYBDhbyG8qrsgTKg7tbyy/XXtas11iabvHQQj+
         neSA==
X-Gm-Message-State: ALoCoQmO/JM2InYKMdNvIZgE1F2Ejddt3vbT39t1EA+hkmXRdhAEYSiWh96S60Jrl34UFZikPFki
X-Received: by 10.152.3.9 with SMTP id 9mr971256lay.86.1404395424773;
        Thu, 03 Jul 2014 06:50:24 -0700 (PDT)
Received: from wasted.cogentembedded.com (ppp27-184.pppoe.mtu-net.ru. [81.195.27.184])
        by mx.google.com with ESMTPSA id qe3sm36064319lbb.20.2014.07.03.06.50.23
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 03 Jul 2014 06:50:23 -0700 (PDT)
Message-ID: <53B55FA6.5080801@cogentembedded.com>
Date:   Thu, 03 Jul 2014 17:50:30 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Mike Turquette <mturquette@linaro.org>
CC:     linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 05/11] MIPS: Alchemy: pci: use clk framework to
 enable PCI clock
References: <1404393762-858019-1-git-send-email-manuel.lauss@gmail.com> <1404393762-858019-6-git-send-email-manuel.lauss@gmail.com>
In-Reply-To: <1404393762-858019-6-git-send-email-manuel.lauss@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41007
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

On 07/03/2014 05:22 PM, Manuel Lauss wrote:

> Use the clock framework to get at the PCI clock source and enable
> it on driver initialization.

> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
>   arch/mips/pci/pci-alchemy.c | 23 ++++++++++++++++++++++-
>   1 file changed, 22 insertions(+), 1 deletion(-)

> diff --git a/arch/mips/pci/pci-alchemy.c b/arch/mips/pci/pci-alchemy.c
> index 912c5f2..adc810f 100644
> --- a/arch/mips/pci/pci-alchemy.c
> +++ b/arch/mips/pci/pci-alchemy.c
[...]
> @@ -394,11 +396,24 @@ static int alchemy_pci_probe(struct platform_device *pdev)
>   		goto out1;
>   	}
>
> +	c = clk_get(&pdev->dev, "pci_clko");
> +	if (IS_ERR(c)) {
> +		dev_err(&pdev->dev, "unable to find PCI clock\n");
> +		ret = PTR_ERR(c);
> +		goto out2;
> +	}
> +	ret = clk_prepare_enable(c);
> +	if (ret) {
> +		dev_err(&pdev->dev, "cannot enable PCI clock\n");
> +		clk_put(c);
> +		goto out2;

    Isn't it simpler to add one more label before clk_put() at end of function?

> +	}
> +
[...]
> @@ -466,12 +481,18 @@ static int alchemy_pci_probe(struct platform_device *pdev)
>   	register_syscore_ops(&alchemy_pci_pmops);
>   	register_pci_controller(&ctx->alchemy_pci_ctrl);
>
> +	dev_info(&pdev->dev, "PCI controller at %ld MHz\n",
> +		 clk_get_rate(c) / 1000000);
> +
>   	return 0;
>
>   out4:
>   	iounmap(virt_io);
>   out3:
>   	iounmap(ctx->regs);
> +out5:
> +	clk_disable_unprepare(c);
> +	clk_put(c);
>   out2:
>   	release_mem_region(r->start, resource_size(r));
>   out1:
>

WBR, Sergei
