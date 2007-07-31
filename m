Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jul 2007 10:38:55 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:52448 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20021622AbXGaJiu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 31 Jul 2007 10:38:50 +0100
Received: (qmail 16837 invoked by uid 511); 31 Jul 2007 09:42:43 -0000
Received: from unknown (HELO ?192.168.2.233?) (192.168.2.233)
  by lemote.com with SMTP; 31 Jul 2007 09:42:43 -0000
Message-ID: <46AF02D9.40803@lemote.com>
Date:	Tue, 31 Jul 2007 17:37:29 +0800
From:	Songmao Tian <tiansm@lemote.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
CC:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] 16K page size in 32 bit kernel
References: <20070731130950.GA5540@sw-linux.com>
In-Reply-To: <20070731130950.GA5540@sw-linux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To:	unlisted-recipients:; (no To-header on input)
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15961
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

Thanks Dajie:)

With 22 PGDIR_SHIFT, 15 extra page tables is populated when a whole 64M 
address space is accessed, the patch can save memory quite a bit:)

Dajie Tan wrote:
> 32-bit Kernel for loongson2e currently use 16KB page size to avoid
> cache alias problem.So, the definiton of PGDIR_SHIFT muse be 12+14.
>
> Using 22 in 16K page size do not lead to a serious problem but the number
> of pages allocated for page table is more than previous. (cat
> /proc/vmstat | grep nr_page_table_pages)
>
> It's been tested on FuLong mini PC(loongson2e inside).
>
>
> Signed-off-by: Dajie Tan <jiankemeng@gmail.com>
> ---
>  include/asm-mips/pgtable-32.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/include/asm-mips/pgtable-32.h b/include/asm-mips/pgtable-32.h
> index 2fbd47e..8d34ebf 100644
> --- a/include/asm-mips/pgtable-32.h
> +++ b/include/asm-mips/pgtable-32.h
> @@ -46,7 +46,7 @@ extern int add_temporary_entry(unsigned long entrylo0, unsigned long entrylo1,
>  #ifdef CONFIG_64BIT_PHYS_ADDR
>  #define PGDIR_SHIFT	21
>  #else
> -#define PGDIR_SHIFT	22
> +#define PGDIR_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT + PTE_ORDER - 2))
>  #endif
>  #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
>  #define PGDIR_MASK	(~(PGDIR_SIZE-1))
>
>
>
>
>   
