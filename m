Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2007 15:11:25 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:21128 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20021617AbXG3OLW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 30 Jul 2007 15:11:22 +0100
Received: (qmail 9313 invoked by uid 511); 30 Jul 2007 14:16:08 -0000
Received: from unknown (HELO ?192.168.2.233?) (192.168.2.233)
  by lemote.com with SMTP; 30 Jul 2007 14:16:08 -0000
Message-ID: <46ADF17D.3090905@lemote.com>
Date:	Mon, 30 Jul 2007 22:11:09 +0800
From:	Songmao Tian <tiansm@lemote.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To:	Dajie Tan <jiankemeng@gmail.com>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] 16KB page size in mips32
References: <5861a7880707200110w588eacb8v98b1481b4a2dbd5c@mail.gmail.com>
In-Reply-To: <5861a7880707200110w588eacb8v98b1481b4a2dbd5c@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15947
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

Dajie Tan wrote:
> Hello,
>
> 32-bit Kernel for loongson2e currently use 16KB page size to avoid
> cache alias problem.So, the definiton of PGDIR_SHIFT muse be 14+12.
>
> The last is the patch. It's been tested on FuLong mini PC(loongson2e 
> inside).
>
>
> --------------------
>
> --- a/include/asm-mips/pgtable-32.h 2007-07-19 08:22:43.000000000 +0800
> +++ b/include/asm-mips/pgtable-32.h 2007-07-20 11:12:40.000000000 +0800
> @@ -46,7 +46,7 @@
> #ifdef CONFIG_64BIT_PHYS_ADDR
> #define PGDIR_SHIFT    21
> #else
> -#define PGDIR_SHIFT    22
> +#define PGDIR_SHIFT    (PAGE_SHIFT + (PAGE_SHIFT + PTE_ORDER - 2))
> #endif
> #define PGDIR_SIZE (1UL << PGDIR_SHIFT)
> #define PGDIR_MASK (~(PGDIR_SIZE-1))
>
>
>
Ralf, please take a look at this patch, and I suspect the "21" also need 
to be fixed too.

Dajie Tan, would you please resend the patch with correct format and add 
a detailed comment as you posted on lemote forum? Thanks.
