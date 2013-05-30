Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 May 2013 19:24:28 +0200 (CEST)
Received: from mail-la0-f49.google.com ([209.85.215.49]:59230 "EHLO
        mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825726Ab3E3RYXWSc1A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 May 2013 19:24:23 +0200
Received: by mail-la0-f49.google.com with SMTP id fp13so513576lab.22
        for <linux-mips@linux-mips.org>; Thu, 30 May 2013 10:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=CdoPEMUV7ftPJDM4Ka6/ICcCiHS/q4o5+LGzS9tHb0s=;
        b=HFw58HFbGRxNVRJq8oqY0HObpNpwV2q5QbUD4vv0PH9KZkXf59jxsoIwCygnX65jpF
         ZrdnFzHhuDPkLqW1ddFKh/DULyE2AlvCPdKXbNc91walC1r2j4ZrI3PFU+KsFwrUaVMI
         TCvCfxatqyk103Akxx8eiojdEj80MypSZD6N7CfTL/Xm9PsYZ+A8fTBdWFOPAsuM8wBn
         Jmso5OaPG0yy7KWjw/kQjX8hIlUVMq0jfJIlARCUbVhlZxEzGR4N6Dn3yJtCmLOh75/A
         aYvzX2jvke+TUcv2xOQEMrjZfOKfwdJhftQBAR4MIBv4Bs/Nf4uTREhSNe7a7dMsTPFz
         vLqw==
X-Received: by 10.152.121.73 with SMTP id li9mr4031743lab.18.1369934657474;
        Thu, 30 May 2013 10:24:17 -0700 (PDT)
Received: from wasted.dev.rtsoft.ru (ppp91-76-91-192.pppoe.mtu-net.ru. [91.76.91.192])
        by mx.google.com with ESMTPSA id e9sm16374884lbj.3.2013.05.30.10.24.15
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 30 May 2013 10:24:16 -0700 (PDT)
Message-ID: <51A78B45.1060604@cogentembedded.com>
Date:   Thu, 30 May 2013 21:24:21 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Lars-Peter Clausen <lars@metafoo.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Vinod Koul <vinod.koul@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 4/6] MIPS: jz4740: Register jz4740 DMA device
References: <1369931105-28065-1-git-send-email-lars@metafoo.de> <1369931105-28065-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1369931105-28065-5-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQkfgastGnhYkGn+3b/7ZNqzSP1Pu2obpviUIICNRmbNKZipx+MxSUa9yXgndYYFrPkAw3Fl
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36646
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

On 05/30/2013 08:25 PM, Lars-Peter Clausen wrote:

> Register a device for the newly added jz4740 dmaengine driver.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Acked-by: Ralf Baechle <ralf@linux-mips.org>
[...]
>   3 files changed, 23 insertions(+)
> diff --git a/arch/mips/jz4740/platform.c b/arch/mips/jz4740/platform.c
> index e9348fd..35a9d8c 100644
> --- a/arch/mips/jz4740/platform.c
> +++ b/arch/mips/jz4740/platform.c
> @@ -329,3 +329,24 @@ struct platform_device jz4740_pwm_device = {
[...]
> +struct platform_device jz4740_dma_device = {
> +	.name	= "jz4740-dma",
> +	.id	= -1,

    Why not align all = in this structure?

> +	.num_resources = ARRAY_SIZE(jz4740_dma_resources),
> +	.resource      = jz4740_dma_resources,
> +};
