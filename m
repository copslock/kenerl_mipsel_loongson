Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2015 12:39:17 +0200 (CEST)
Received: from mail-la0-f46.google.com ([209.85.215.46]:35382 "EHLO
        mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009768AbbEOKjPgkffV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2015 12:39:15 +0200
Received: by labbd9 with SMTP id bd9so113131175lab.2
        for <linux-mips@linux-mips.org>; Fri, 15 May 2015 03:39:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=/14EnQRGE3PYZzgGWaiK1LncyM3dqioOlhWO9qExAnU=;
        b=M1qnkvNmnJejZV+DGCNemamwJniNYHT+1ht2bsDn/iR/Ea21YOp2v/ds3WnYx3F2uh
         Y6rsgRSKa0T4Ip53f23zzRjvIdqURzKee1xEAjiZSpZoksm5En+ENterqksx4kVffLOy
         Pgi86Nh4bukOrpb2Tcv7XbEi7q5zt3YazsozR56cwjH5f9Rv1toBa7aYA+uFQSlZviY4
         iL/YHt+4yUzOzZQMO0oQ7QRIP9A2/xxC6kn4xmn8EzuzZP64Y2tawTMg2sUQ9r1NRwvL
         iIlsUUY+TxjNzQs2dPAd7QwMizedi+kl5gEr0qhmBWccKLcxwUQCgJGQjhU24KI9XXOm
         mS6g==
X-Gm-Message-State: ALoCoQlk6IVd5nF8dGCq0AT/uYB0+xqCyjBOfC1ZbKNM33TZfhMtKlj6ZCTDGOEKoW9yJqeNlVt9
X-Received: by 10.112.155.169 with SMTP id vx9mr6675224lbb.121.1431686352309;
        Fri, 15 May 2015 03:39:12 -0700 (PDT)
Received: from [192.168.3.154] (ppp31-157.pppoe.mtu-net.ru. [81.195.31.157])
        by mx.google.com with ESMTPSA id ba4sm365074lab.31.2015.05.15.03.39.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 May 2015 03:39:11 -0700 (PDT)
Message-ID: <5555CCCE.6010006@cogentembedded.com>
Date:   Fri, 15 May 2015 13:39:10 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        aleksey.makarov@auriga.com, james.hogan@imgtec.com,
        paul.burton@imgtec.com, david.daney@cavium.com,
        peterz@infradead.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, ralf@linux-mips.org,
        davidlohr@hp.com, kirill@shutemov.name, akpm@linux-foundation.org,
        mingo@kernel.org
Subject: Re: [PATCH v2] MIPS64: Support of at least 48 bits of SEGBITS
References: <20150515013351.7450.12130.stgit@ubuntu-yegoshin>
In-Reply-To: <20150515013351.7450.12130.stgit@ubuntu-yegoshin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47403
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

On 5/15/2015 4:34 AM, Leonid Yegoshin wrote:

> SEGBITS default is 40 bits or less, depending from CPU type.
> This patch introduces 48bits of application virtual address (SEGBITS) support.
> It is defined only for 16K and 64K pages and is optional (configurable).

> Penalty - a small number of additional pages for generic (small) applications.
> But for 64K pages it adds 3rd level of PTE structure, which has a little
> impact during software TLB refill.

> This patch is needed because MIPS I6XXX and P6XXX cores have 48 bit of
> virtual address in each segment (SEGBITS).

> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> ---
> V2: Added correction for defintion of TASK_SIZE64
> ---
>   arch/mips/Kconfig                  |   11 +++++++++++
>   arch/mips/include/asm/pgtable-64.h |   18 +++++++++++-------
>   arch/mips/include/asm/processor.h  |    6 +++++-
>   3 files changed, 27 insertions(+), 8 deletions(-)

> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 76efb02ae99f..3acff2f065e9 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2032,6 +2032,17 @@ config PAGE_SIZE_64KB
>
>   endchoice
>
> +config 48VMBITS
> +	bool "48 bits virtual memory"
> +	depends on PAGE_SIZE_16KB || PAGE_SIZE_64KB
> +	depends on 64BIT
> +	help
> +	  Define a maximum at least 48 bits of application virtual memory.
> +	  Default is 40 bits or less, depending from CPU.

    s/from/on/.

> +	  In generic (small) application it is a small set of pages increase
> +	  in page tables.

    Can't parse that...

[...]
> diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
> index cf661a2fb141..c6b5473440e6 100644
> --- a/arch/mips/include/asm/pgtable-64.h
> +++ b/arch/mips/include/asm/pgtable-64.h
[...]
> @@ -114,11 +122,7 @@
>   #endif
>   #define PTRS_PER_PTE	((PAGE_SIZE << PTE_ORDER) / sizeof(pte_t))
>
> -#if PGDIR_SIZE >= TASK_SIZE64
> -#define USER_PTRS_PER_PGD	(1)
> -#else
> -#define USER_PTRS_PER_PGD	(TASK_SIZE64 / PGDIR_SIZE)
> -#endif
> +#define USER_PTRS_PER_PGD       ((TASK_SIZE64 / PGDIR_SIZE)?(TASK_SIZE64 / PGDIR_SIZE):1)

    Could write this as '(TASK_SIZE64 / PGDIR_SIZE ?: 1)'.

[...]
> diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
> index 9b3b48e21c22..bd2030f32ea4 100644
> --- a/arch/mips/include/asm/processor.h
> +++ b/arch/mips/include/asm/processor.h
> @@ -69,7 +69,11 @@ extern unsigned int vced_count, vcei_count;
>    * 8192EB ...
>    */
>   #define TASK_SIZE32	0x7fff8000UL
> -#define TASK_SIZE64	0x10000000000UL
> +#ifdef CONFIG_48VMBITS
> +#define TASK_SIZE64     (0x1UL << ((cpu_data[0].vmbits>48)?48:cpu_data[0].vmbits))

    Perhaps '(0x1UL << (min(cpu_data[0].vmbits, 48))'?

> +#else
> +#define TASK_SIZE64     (0x10000000000UL)

    Parens not needed.

[...]

WBR, Sergei
