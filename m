Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Sep 2005 11:53:37 +0100 (BST)
Received: from smtp103.biz.mail.mud.yahoo.com ([IPv6:::ffff:68.142.200.238]:184
	"HELO smtp103.biz.mail.mud.yahoo.com") by linux-mips.org with SMTP
	id <S8225472AbVIRKxK>; Sun, 18 Sep 2005 11:53:10 +0100
Received: (qmail 58956 invoked from network); 18 Sep 2005 10:53:03 -0000
Received: from unknown (HELO ?192.168.1.105?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp103.biz.mail.mud.yahoo.com with SMTP; 18 Sep 2005 10:53:02 -0000
Subject: Re: [patch] little zImage.flash fixes
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Bruno Randolf <bruno.randolf@4g-systems.biz>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <200509141825.34038.bruno.randolf@4g-systems.biz>
References: <200509141825.34038.bruno.randolf@4g-systems.biz>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Sun, 18 Sep 2005 03:53:01 -0700
Message-Id: <1127040781.4948.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


Thanks. I'll create a 2.6.13 patch later.

Pete

On Wed, 2005-09-14 at 18:25 +0200, Bruno Randolf wrote:
> hello!
> 
> fyi - i had to make the following changes after applying your 
> zImage_2_6_10.patch to use "make zImage.flash" on the recent 2.6.13 
> linux-mips kernel.  also "make zImage" wouldn't compile through without the 
> "-I $(TOPDIR)/include" changes.
> 
> greetings,
> bruno
> 
> ---
> 
> diff --exclude CVS -Nurb linux/arch/mips/Makefile 
> linux-2.6.13/arch/mips/Makefile
> --- linux/arch/mips/Makefile    2005-09-14 16:44:32.000000000 +0200
> +++ linux-2.6.13/arch/mips/Makefile     2005-09-14 16:32:28.000000000 +0200
> @@ -798,6 +798,9 @@
>  zImage: vmlinux
>         +@$(call makeboot,$@)
>  
> +zImage.flash: vmlinux
> +       +@$(call makeboot,$@)
> +
>  CLEAN_FILES += vmlinux.ecoff \
>                vmlinux.srec \
>                vmlinux.rm200.tmp \
> diff --exclude CVS -Nurb linux/arch/mips/boot/Makefile 
> linux-2.6.13/arch/mips/boot/Makefile
> --- linux/arch/mips/boot/Makefile       2005-09-14 16:44:32.000000000 +0200
> +++ linux-2.6.13/arch/mips/boot/Makefile        2005-09-14 16:35:14.000000000 
> +0200
> @@ -26,7 +26,7 @@
>  
>  VMLINUX = vmlinux
>  
> -ZBOOT_TARGETS  = zImage
> +ZBOOT_TARGETS  = zImage zImage.flash
>  bootdir-y      := compressed
>  
>  all: vmlinux.ecoff vmlinux.srec addinitrd zImage
> diff --exclude CVS -Nurb linux/arch/mips/boot/compressed/Makefile 
> linux-2.6.13/arch/mips/boot/compressed/Makefile
> --- linux/arch/mips/boot/compressed/Makefile    2005-09-14 16:44:32.000000000 
> +0200
> +++ linux-2.6.13/arch/mips/boot/compressed/Makefile     2005-09-14 
> 16:31:53.000000000 +0200
> @@ -18,7 +18,7 @@
>  
>  CFLAGS         += -fno-builtin -D__BOOTER__ -I$(compressed)/include
>  
> -BOOT_TARGETS   = zImage 
> +BOOT_TARGETS   = zImage zImage.flash
>  
>  bootdir-$(CONFIG_SOC_AU1X00)   := au1xxx
>  subdir-y                       := common lib images
> diff --exclude CVS -Nurb linux/arch/mips/boot/compressed/au1xxx/Makefile 
> linux-2.6.13/arch/mips/boot/compressed/au1xxx/Makefile
> --- linux/arch/mips/boot/compressed/au1xxx/Makefile     2005-09-14 
> 16:44:32.000000000 +0200
> +++ linux-2.6.13/arch/mips/boot/compressed/au1xxx/Makefile      2005-09-14 
> 16:38:34.000000000 +0200
> @@ -73,12 +73,12 @@
>  endif
>  
>  $(obj)/head.o: $(obj)/head.S $(TOPDIR)/vmlinux
> -       $(CC) $(AFLAGS) \
> +       $(CC) -I $(TOPDIR)/include $(AFLAGS) \
>         -DKERNEL_ENTRY=$(shell sh $(ENTRY) $(NM) $(TOPDIR)/vmlinux ) \
>         -c -o $*.o $<
>  
>  $(common)/misc-simple.o:
> -       $(CC) $(CFLAGS) -DINITRD_OFFSET=0 -DINITRD_SIZE=0 -DZIMAGE_OFFSET=0 \
> +       $(CC) -I $(TOPDIR)/include $(CFLAGS) -DINITRD_OFFSET=0 -DINITRD_SIZE=0 
> -DZIMAGE_OFFSET=0 \
>                 -DAVAIL_RAM_START=$(AVAIL_RAM_START) \
>                 -DAVAIL_RAM_END=$(AVAIL_RAM_END) \
>                 -DLOADADDR=$(LOADADDR) \
> diff --exclude CVS -Nurb linux/arch/mips/boot/compressed/common/misc-simple.c 
> linux-2.6.13/arch/mips/boot/compressed/common/misc-simple.c
> --- linux/arch/mips/boot/compressed/common/misc-simple.c        2005-09-14 
> 16:44:32.000000000 +0200
> +++ linux-2.6.13/arch/mips/boot/compressed/common/misc-simple.c 2005-09-14 
> 16:31:07.000000000 +0200
> @@ -24,7 +24,7 @@
>  
>  #include <asm/page.h>
>  
> -#include "zlib.h"
> +#include "linux/zlib.h"
>  
>  extern struct NS16550 *com_port;
