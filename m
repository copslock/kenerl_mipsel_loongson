Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Mar 2014 21:46:14 +0100 (CET)
Received: from mail-lb0-f172.google.com ([209.85.217.172]:53463 "EHLO
        mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822136AbaCVUp5xHnE5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 22 Mar 2014 21:45:57 +0100
Received: by mail-lb0-f172.google.com with SMTP id c11so2613533lbj.17
        for <linux-mips@linux-mips.org>; Sat, 22 Mar 2014 13:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=lC88Tzxyq0VNg/+Lb8oXacdpec44XhkSC8cSf38TanI=;
        b=Zv9ezeWOZzapFM5jsJc4NqUxRtIwF/NM7Ui/Ja/WKHPg41gpiLpUeoguQRAwQMAN18
         8nB5x6RrDMqDcT5AY90L0goBTK1W0HGa/t2dSHjjMGG2vTGhcUDcVsh2Jm8nI7iKu1tp
         ptIXGDj5+CmywTvWP3OiODE1r9csDUyBCnVrHVDjCdNVBK4g/kejvvwMQEU8WZwMZyQJ
         rAHu81aS1iyaiLJtKzY48ozx1Qt9AtaV7qIMLEXZuvefGvsChA1f6+MzeBxhzdfyFdeZ
         JyOf4r5md9Y6QkKh/3DJ+tpqQrfw3mMh6i947+nTmBM2+gzwO6rILOMRhSW5cQpDfYYa
         +dkA==
X-Gm-Message-State: ALoCoQnvYDTpOslVryb1/Z5OiAPMG8szFoin8I53W2Qm9ymfbWMMbMy14IEgYh/q51v8Hp9Acw3X
X-Received: by 10.153.7.69 with SMTP id da5mr121330lad.38.1395521151037;
        Sat, 22 Mar 2014 13:45:51 -0700 (PDT)
Received: from wasted.cogentembedded.com (ppp83-237-60-105.pppoe.mtu-net.ru. [83.237.60.105])
        by mx.google.com with ESMTPSA id d9sm8598964laa.17.2014.03.22.13.45.49
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 22 Mar 2014 13:45:50 -0700 (PDT)
Message-ID: <532E0486.3010702@cogentembedded.com>
Date:   Sun, 23 Mar 2014 00:45:42 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
MIME-Version: 1.0
To:     Kees Cook <keescook@chromium.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Sanjay Lal <sanjayl@kymasys.com>,
        John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: export icache_flush_range
References: <20140322154720.GA23863@www.outflux.net>
In-Reply-To: <20140322154720.GA23863@www.outflux.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39549
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

On 03/22/2014 06:47 PM, Kees Cook wrote:

> The lkdtm module performs tests against executable memory ranges, so
> it needs to flush the icache for proper behaviors. Other architectures
> already export this, so do the same for MIPS.

> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> This is currently untested! I'm building a MIPS cross-compiler now...
> If someone can validate this fixes the build when lkdtm is a module,
> that would be appreciated. :)
> ---
>   arch/mips/mm/cache.c |    1 +
>   1 file changed, 1 insertion(+)

> diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
> index fde7e56d13fe..b3f1df13d9f6 100644
> --- a/arch/mips/mm/cache.c
> +++ b/arch/mips/mm/cache.c
> @@ -38,6 +38,7 @@ void (*__flush_kernel_vmap_range)(unsigned long vaddr, int size);
>   void (*__invalidate_kernel_vmap_range)(unsigned long vaddr, int size);
>
>   EXPORT_SYMBOL_GPL(__flush_kernel_vmap_range);
> +EXPORT_SYMBOL_GPL(flush_icache_range);

    Have you run this thru scripts/checkpatch.pl? It would have told you that 
an export should immediately follow the corresponding function body, AFAIK.

WBR, Sergei
