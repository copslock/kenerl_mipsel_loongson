Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2010 11:51:52 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57082 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492785Ab0AZKvs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Jan 2010 11:51:48 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o0QApusV003056;
        Tue, 26 Jan 2010 11:51:56 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o0QAptsH003054;
        Tue, 26 Jan 2010 11:51:55 +0100
Date:   Tue, 26 Jan 2010 11:51:55 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH -queue 2/2] MIPS: Cleanup the debugging of compressed
 kernel support
Message-ID: <20100126105155.GC30098@linux-mips.org>
References: <979633248ed16f2724296fd90f4b824f601809e1.1264496568.git.wuzhangjin@gmail.com>
 <cbf30435132e35087c6c6b8ca172c7d9cb0cbc37.1264496568.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbf30435132e35087c6c6b8ca172c7d9cb0cbc37.1264496568.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 25665
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16601

On Tue, Jan 26, 2010 at 05:04:03PM +0800, Wu Zhangjin wrote:

> This patch adds a new DEBUG_ZBOOT option to allow the developers to
> debug the compressed kernel support for a new board.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  arch/mips/Kconfig.debug            |   18 ++++++++++++++++++
>  arch/mips/boot/compressed/Makefile |    2 ++
>  2 files changed, 20 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
> index d2b88a0..b3e20f4 100644
> --- a/arch/mips/Kconfig.debug
> +++ b/arch/mips/Kconfig.debug
> @@ -102,4 +102,22 @@ config RUNTIME_DEBUG
>  	  arch/mips/include/asm/debug.h for debugging macros.
>  	  If unsure, say N.
>  
> +config DEBUG_ZBOOT
> +	bool "Enable compressed kernel support debugging"
> +	depends on SYS_SUPPORTS_ZBOOT_UART16550

This should probably depend on DEBUG_KERNEL also.

> +	help
> +	  If you want to add compressed kernel support to a new board, and the
> +	  board supports uart16550 compatible serial port, please select
> +	  SYS_SUPPORTS_ZBOOT_UART16550 for your board and enable this option to
> +	  debug it.
> +
> +	  If your board doesn't support uart16550 compatible serial port, you
> +	  can try to select SYS_SUPPORTS_ZBOOT and use the other methods to
> +	  debug it. for example, add a new serial port support just as
> +	  arch/mips/boot/compressed/uart-16550.c does.
> +
> +	  After the compressed kernel support works, please disable this option
> +	  to reduce the kernel image size and speed up the booting procedure a
> +	  little.
> +
>  endmenu
> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
> index 91a57a6..68e5db8 100644
> --- a/arch/mips/boot/compressed/Makefile
> +++ b/arch/mips/boot/compressed/Makefile
> @@ -32,7 +32,9 @@ KBUILD_AFLAGS := $(LINUXINCLUDE) $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
>  
>  obj-y := $(obj)/head.o $(obj)/decompress.o $(obj)/dbg.o
>  
> +ifdef CONFIG_DEBUG_ZBOOT
>  obj-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
> +endif

DEBUG_ZBOOT already depends on SYS_SUPPORTS_ZBOOT_UART16550 so this can be
simplified into just obj-$(CONFIG_DEBUG_ZBOOT) and no ifdef.

  Ralf
