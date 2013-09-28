Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Sep 2013 19:32:30 +0200 (CEST)
Received: from mail-we0-f171.google.com ([74.125.82.171]:54258 "EHLO
        mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817088Ab3I1Rc1o07BY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Sep 2013 19:32:27 +0200
Received: by mail-we0-f171.google.com with SMTP id t61so3987085wes.30
        for <multiple recipients>; Sat, 28 Sep 2013 10:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=GuDIYcCEo/pAxVuf88hAPl2IzabPdwgdgMK8OTQHkQs=;
        b=i+ICko2qt+p8W5Zt/8sB7S3iJ1NDbT5eIPQpZy7w0UtFEnSoZjlcki7fDBYR70t4XX
         RmqKIt02+ZkekDAz70y/TDChIxXpCZI9jfIJLgpcebZDYyILBuFO2r8t4eAM6SRR4fJw
         CGp0ory/bt8587KoKlDOTI2CUu9xAsDMcRbPdh7GrfxbgNLOdTq+G8MnB2kN68EsWdcx
         HZRBj/VrMqcvcf0+bCZ+4cu04hpVyX5CkZ5mkMaeAgm85PF9/DF4K185VM/1pyl6y7qX
         FigauujKA1CxJQ5VY02wZgjSIz84acmQRaW6BZqJ1SePMbSgEvm5JaaKqLE5BZW4EhlN
         huUg==
X-Received: by 10.180.9.203 with SMTP id c11mr7207783wib.64.1380389542347;
        Sat, 28 Sep 2013 10:32:22 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2f70:4010:b1c1:a6f5:7c1f:7561? ([2a01:e35:2f70:4010:b1c1:a6f5:7c1f:7561])
        by mx.google.com with ESMTPSA id c13sm3474907wib.5.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 10:32:21 -0700 (PDT)
Message-ID: <524712A7.7060402@gmail.com>
Date:   Sat, 28 Sep 2013 19:32:23 +0200
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.0
MIME-Version: 1.0
To:     Antony Pavlov <antonynpavlov@gmail.com>, linux-mips@linux-mips.org
CC:     Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: vmlinuz: gather some string functions into string.c
References: <1380382974-27884-1-git-send-email-antonynpavlov@gmail.com>
In-Reply-To: <1380382974-27884-1-git-send-email-antonynpavlov@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38050
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Hello,

Le 28/09/2013 17:42, Antony Pavlov a écrit :
> This patch fixes linker error:
>
>      LD    vmlinuz
>    arch/mips/boot/compressed/decompress.o: In function `decompress_kernel':
>    decompress.c:(.text+0x754): undefined reference to `memcpy'
>    make[1]: *** [vmlinuz] Error 1
>
> Which appears when compiling vmlinuz image with CONFIG_KERNEL_LZO=y.

You would have to rebase this on top of mips-for-linux-next which 
contains a bit more ifdef for supporting LZ4 and XZ otherwise the first 
hunk of the patch does not apply.

Regarding the contents of the patch, you are somehow changing the 
existing compressor code by unconditionnaly providing a memset and 
memcpy implementation, which is fine per se but should be mentioned at 
least.

>
> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> ---
>   arch/mips/boot/compressed/Makefile     |  4 ++--
>   arch/mips/boot/compressed/decompress.c | 19 -------------------
>   arch/mips/boot/compressed/string.c     | 28 ++++++++++++++++++++++++++++
>   3 files changed, 30 insertions(+), 21 deletions(-)
>   create mode 100644 arch/mips/boot/compressed/string.c
>
> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
> index 0048c08..30e30d4 100644
> --- a/arch/mips/boot/compressed/Makefile
> +++ b/arch/mips/boot/compressed/Makefile
> @@ -27,10 +27,10 @@ KBUILD_AFLAGS := $(LINUXINCLUDE) $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
>   	-DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE) \
>   	-DKERNEL_ENTRY=$(VMLINUX_ENTRY_ADDRESS)
>
> -targets := head.o decompress.o dbg.o uart-16550.o uart-alchemy.o
> +targets := head.o decompress.o string.o dbg.o uart-16550.o uart-alchemy.o
>
>   # decompressor objects (linked with vmlinuz)
> -vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o $(obj)/dbg.o
> +vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o $(obj)/string.o $(obj)/dbg.o
>
>   ifdef CONFIG_DEBUG_ZBOOT
>   vmlinuzobjs-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
> diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
> index 2c95730..fc1f294 100644
> --- a/arch/mips/boot/compressed/decompress.c
> +++ b/arch/mips/boot/compressed/decompress.c
> @@ -44,29 +44,10 @@ void error(char *x)
>   #define STATIC static
>
>   #ifdef CONFIG_KERNEL_GZIP
> -void *memcpy(void *dest, const void *src, size_t n)
> -{
> -	int i;
> -	const char *s = src;
> -	char *d = dest;
> -
> -	for (i = 0; i < n; i++)
> -		d[i] = s[i];
> -	return dest;
> -}
>   #include "../../../../lib/decompress_inflate.c"
>   #endif
>
>   #ifdef CONFIG_KERNEL_BZIP2
> -void *memset(void *s, int c, size_t n)
> -{
> -	int i;
> -	char *ss = s;
> -
> -	for (i = 0; i < n; i++)
> -		ss[i] = c;
> -	return s;
> -}
>   #include "../../../../lib/decompress_bunzip2.c"
>   #endif
>
> diff --git a/arch/mips/boot/compressed/string.c b/arch/mips/boot/compressed/string.c
> new file mode 100644
> index 0000000..49e6db0
> --- /dev/null
> +++ b/arch/mips/boot/compressed/string.c
> @@ -0,0 +1,28 @@
> +/*
> + * arch/mips/boot/compressed/string.c
> + *
> + * Very small subset of simple string routines
> + */
> +
> +#include <linux/string.h>
> +
> +void *memcpy(void *dest, const void *src, size_t n)
> +{
> +	int i;
> +	const char *s = src;
> +	char *d = dest;
> +
> +	for (i = 0; i < n; i++)
> +		d[i] = s[i];
> +	return dest;
> +}
> +
> +void *memset(void *s, int c, size_t n)
> +{
> +	int i;
> +	char *ss = s;
> +
> +	for (i = 0; i < n; i++)
> +		ss[i] = c;
> +	return s;
> +}
>
