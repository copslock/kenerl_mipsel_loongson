Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2007 01:48:04 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:57232 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20021428AbXHAAsC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Aug 2007 01:48:02 +0100
Received: (qmail 26100 invoked by uid 511); 1 Aug 2007 00:53:01 -0000
Received: from unknown (HELO ?192.168.2.233?) (192.168.2.233)
  by lemote.com with SMTP; 1 Aug 2007 00:53:01 -0000
Message-ID: <46AFD82D.9070304@lemote.com>
Date:	Wed, 01 Aug 2007 08:47:41 +0800
From:	Songmao Tian <tiansm@lemote.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Dajie Tan <jiankemeng@gmail.com>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] 16K page size in 32 bit kernel
References: <20070731130950.GA5540@sw-linux.com> <20070731100027.GA3983@linux-mips.org> <46AF3DEE.2080603@lemote.com> <20070731204532.GA22036@linux-mips.org>
In-Reply-To: <20070731204532.GA22036@linux-mips.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Tue, Jul 31, 2007 at 09:49:34PM +0800, Songmao Tian wrote:
>
>   
>> I think the following is more complete?
>>
>> #ifdef CONFIG_64BIT_PHYS_ADDR
>> -#define PGDIR_SHIFT    21
>> +#define PGDIR_SHIFT    (PAGE_SHIFT + (PAGE_SHIFT + PTE_ORDER - 3))
>> #else
>> -#define PGDIR_SHIFT    22
>> +#define PGDIR_SHIFT    (PAGE_SHIFT + (PAGE_SHIFT + PTE_ORDER - 2))
>> #endif
>>     
>
> Better suggestion :-)
>
>   Ralf
>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>
> diff --git a/include/asm-mips/pgtable-32.h b/include/asm-mips/pgtable-32.h
> index 2fbd47e..ff29485 100644
> --- a/include/asm-mips/pgtable-32.h
> +++ b/include/asm-mips/pgtable-32.h
> @@ -43,11 +43,7 @@ extern int add_temporary_entry(unsigned long entrylo0, unsigned long entrylo1,
>   */
>  
>  /* PGDIR_SHIFT determines what a third-level page table entry can map */
> -#ifdef CONFIG_64BIT_PHYS_ADDR
> -#define PGDIR_SHIFT	21
> -#else
> -#define PGDIR_SHIFT	22
> -#endif
> +#define PGDIR_SHIFT	(2 * PAGE_SHIFT + PTE_ORDER - PTE_T_LOG2)
>  #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
>  #define PGDIR_MASK	(~(PGDIR_SIZE-1))
>  
>
>
>   

Sure:)

Tian
