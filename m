Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2007 07:24:17 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:39825 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20022670AbXFGGYO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 7 Jun 2007 07:24:14 +0100
Received: (qmail 9566 invoked by uid 511); 7 Jun 2007 06:30:41 -0000
Received: from unknown (HELO ?192.168.1.9?) (222.92.8.142)
  by lemote.com with SMTP; 7 Jun 2007 06:30:41 -0000
Message-ID: <4667A443.8060105@lemote.com>
Date:	Thu, 07 Jun 2007 14:22:59 +0800
From:	Fuxin Zhang <zhangfx@lemote.com>
User-Agent: Thunderbird 2.0.0.0 (Windows/20070326)
MIME-Version: 1.0
To:	tiansm@lemote.com
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] override of arch/mips/mm/cache.c: __uncached_access
References: <20070606182814.GD30017@linux-mips.org> <11811962573610-git-send-email-tiansm@lemote.com>
In-Reply-To: <11811962573610-git-send-email-tiansm@lemote.com>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8bit
Return-Path: <zhangfx@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhangfx@lemote.com
Precedence: bulk
X-list: linux-mips

Recent Xorg depends on this hack/patch.

For example,if we are using this memory layout:
0-256MB phys mem
256-512M pci io/mem region
512-768MB phys mem
Xorg will crash due to pci video memory mapping problem.

So this is not really only for Fulong.

BTW:
Songmao, we'd better add a comment to justify this code.

tiansm@lemote.com 写道:
> From: Songmao Tian <tiansm@lemote.com>
>
> Signed-off-by: Songmao Tian <tiansm@lemote.com>
> ---
>  arch/mips/lemote/lm2e/Makefile |    2 +-
>  arch/mips/lemote/lm2e/mem.c    |   25 +++++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 1 deletions(-)
>  create mode 100644 arch/mips/lemote/lm2e/mem.c
>
> diff --git a/arch/mips/lemote/lm2e/Makefile b/arch/mips/lemote/lm2e/Makefile
> index 0ba6f12..fb1b48c 100644
> --- a/arch/mips/lemote/lm2e/Makefile
> +++ b/arch/mips/lemote/lm2e/Makefile
> @@ -2,6 +2,6 @@
>  # Makefile for Lemote Fulong mini-PC board.
>  #
>  
> -obj-y += setup.o prom.o reset.o irq.o pci.o bonito-irq.o dbg_io.o
> +obj-y += setup.o prom.o reset.o irq.o pci.o bonito-irq.o dbg_io.o mem.o
>  EXTRA_AFLAGS := $(CFLAGS)
>  
> diff --git a/arch/mips/lemote/lm2e/mem.c b/arch/mips/lemote/lm2e/mem.c
> new file mode 100644
> index 0000000..6068a17
> --- /dev/null
> +++ b/arch/mips/lemote/lm2e/mem.c
> @@ -0,0 +1,25 @@
> +/*
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/fs.h>
> +#include <linux/fcntl.h>
> +#include <linux/mm.h>
> +
> +/* override of arch/mips/mm/cache.c: __uncached_access */
> +int __uncached_access(struct file *file, unsigned long addr)
> +{
> +	if (file->f_flags & O_SYNC)
> +		return 1;
> +
> +	/* 
> +	 * on lemote loongson 2e system, peripheral register 
> +	 * reside between 0x1000 0000 and 0x2000 0000
> +	 */
> +	return addr >= __pa(high_memory) ||
> +		((addr >=0x10000000) && (addr < 0x20000000));
> +}
> +
>   

-- 
------------------------------------------------
张福新
江苏中科龙梦科技有限公司
地址：江苏省常熟市虞山镇梦兰工业园

General Manager
JiangSu Lemote Corp. Ltd.
MengLan, Yushan, Changshu, JiangSu Province, China
ZIP: 215500 
Tel: 86-512-52308679
Fax: 86-512-52308688
Email: zhangfx@lemote.com
http://www.lemote.com
------------------------------------------------
 
