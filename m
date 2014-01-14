Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jan 2014 07:58:08 +0100 (CET)
Received: from mail-la0-f43.google.com ([209.85.215.43]:48617 "EHLO
        mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826363AbaANG51SWG-1 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Jan 2014 07:57:27 +0100
Received: by mail-la0-f43.google.com with SMTP id er20so1666495lab.30
        for <multiple recipients>; Mon, 13 Jan 2014 22:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=+LYz0Q47XuF3YkUyFRofMC+gZzg1b/tRe1I8VTfZZXA=;
        b=H/qP4hPt2USg3RETHDW46gTg1VIILo/uHPN6aGtUlH7YUWEVfSfdJOPmFrMRme+pSZ
         2o+4FSXVZGruh6LbenYTNTEJfE+DnCmcxD3sA7HMl2WCNFbFHv5xqHG/mv6pU7255Ufi
         KY6qQm/AJifDEA7q6tBXp6nAePGGr58JaXLL/krUxmH1XD1DMBl+uFhr5RbUK8Y3egfF
         Kc5zHifjYJksgqSGkqMQCAFPrtNsPR98Yzg2iINoJ208l4ej9+BV2uNVxYJsZxkaLA/u
         hHuLnabE3LAflOKzKV0n5Qcx/DbZz8q2g9iFtBi5r5/v2TNbSIk4XPN97F7Zx6sBB+Al
         F6LA==
X-Received: by 10.112.143.163 with SMTP id sf3mr11874697lbb.20.1389682638939;
        Mon, 13 Jan 2014 22:57:18 -0800 (PST)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by mx.google.com with ESMTPSA id wp3sm2022993lbb.8.2014.01.13.22.57.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jan 2014 22:57:17 -0800 (PST)
Date:   Tue, 14 Jan 2014 11:05:25 +0400
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v3] MIPS: ZBOOT: gather string functions into string.c
Message-Id: <20140114110525.cd37b131de060259404bd4c8@gmail.com>
In-Reply-To: <1389648656-25709-1-git-send-email-antonynpavlov@gmail.com>
References: <1389648656-25709-1-git-send-email-antonynpavlov@gmail.com>
X-Mailer: Sylpheed 3.4.0beta7 (GTK+ 2.24.22; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38970
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

On Tue, 14 Jan 2014 01:30:56 +0400
Antony Pavlov <antonynpavlov@gmail.com> wrote:

> In the worst case this adds less then 128 bytes of code

Sorry! I see a typo here.
Please change "then" to "than" before applying.

> but on the other hand this makes code organization more clear.
> 
> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Cc: linux-mips@linux-mips.org
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: John Crispin <blogic@openwrt.org>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/mips/boot/compressed/Makefile     |  4 ++--
>  arch/mips/boot/compressed/decompress.c | 22 ----------------------
>  arch/mips/boot/compressed/string.c     | 28 ++++++++++++++++++++++++++++
>  3 files changed, 30 insertions(+), 24 deletions(-)
>  create mode 100644 arch/mips/boot/compressed/string.c
> 
> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
> index ca0c343..61af6b6 100644
> --- a/arch/mips/boot/compressed/Makefile
> +++ b/arch/mips/boot/compressed/Makefile
> @@ -27,10 +27,10 @@ KBUILD_AFLAGS := $(LINUXINCLUDE) $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
>  	-DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE) \
>  	-DKERNEL_ENTRY=$(VMLINUX_ENTRY_ADDRESS)
>  
> -targets := head.o decompress.o dbg.o uart-16550.o uart-alchemy.o
> +targets := head.o decompress.o string.o dbg.o uart-16550.o uart-alchemy.o
>  
>  # decompressor objects (linked with vmlinuz)
> -vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o $(obj)/dbg.o
> +vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o $(obj)/string.o $(obj)/dbg.o
>  
>  ifdef CONFIG_DEBUG_ZBOOT
>  vmlinuzobjs-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
> diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
> index a8c6fd6..c00c4dd 100644
> --- a/arch/mips/boot/compressed/decompress.c
> +++ b/arch/mips/boot/compressed/decompress.c
> @@ -43,33 +43,11 @@ void error(char *x)
>  /* activate the code for pre-boot environment */
>  #define STATIC static
>  
> -#if defined(CONFIG_KERNEL_GZIP) || defined(CONFIG_KERNEL_XZ) || \
> -	defined(CONFIG_KERNEL_LZ4)
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
> -#endif
>  #ifdef CONFIG_KERNEL_GZIP
>  #include "../../../../lib/decompress_inflate.c"
>  #endif
>  
>  #ifdef CONFIG_KERNEL_BZIP2
> -void *memset(void *s, int c, size_t n)
> -{
> -	int i;
> -	char *ss = s;
> -
> -	for (i = 0; i < n; i++)
> -		ss[i] = c;
> -	return s;
> -}
>  #include "../../../../lib/decompress_bunzip2.c"
>  #endif
>  
> diff --git a/arch/mips/boot/compressed/string.c b/arch/mips/boot/compressed/string.c
> new file mode 100644
> index 0000000..9de9885
> --- /dev/null
> +++ b/arch/mips/boot/compressed/string.c
> @@ -0,0 +1,28 @@
> +/*
> + * arch/mips/boot/compressed/string.c
> + *
> + * Very small subset of simple string routines
> + */
> +
> +#include <linux/types.h>
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
> -- 
> 1.8.5.2
> 


-- 
-- 
Best regards,
  Antony Pavlov
