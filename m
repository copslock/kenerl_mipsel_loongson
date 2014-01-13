Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jan 2014 23:20:33 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:52172 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823067AbaAMWUa3cybt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Jan 2014 23:20:30 +0100
Message-ID: <52D466A5.70704@phrozen.org>
Date:   Mon, 13 Jan 2014 23:20:21 +0100
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH v3] MIPS: ZBOOT: gather string functions into string.c
References: <1389648656-25709-1-git-send-email-antonynpavlov@gmail.com>
In-Reply-To: <1389648656-25709-1-git-send-email-antonynpavlov@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

Hi,

whats the difference between v3 and v2 ?

    John

On 13/01/2014 22:30, Antony Pavlov wrote:
> In the worst case this adds less then 128 bytes of code
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
