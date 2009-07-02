Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jul 2009 01:28:46 +0200 (CEST)
Received: from ogre.sisk.pl ([217.79.144.158]:39960 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492308AbZGBX2U (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 3 Jul 2009 01:28:20 +0200
Received: from localhost (localhost.localdomain [127.0.0.1])
	by ogre.sisk.pl (Postfix) with ESMTP id 8259B1481A5;
	Fri,  3 Jul 2009 01:16:48 +0200 (CEST)
Received: from ogre.sisk.pl ([127.0.0.1])
 by localhost (ogre.sisk.pl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 17198-05; Fri,  3 Jul 2009 01:16:41 +0200 (CEST)
Received: from tosh.localnet (220-bem-13.acn.waw.pl [82.210.184.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ogre.sisk.pl (Postfix) with ESMTP id 906851480B1;
	Fri,  3 Jul 2009 01:16:41 +0200 (CEST)
From:	"Rafael J. Wysocki" <rjw@sisk.pl>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: Re: [PATCH] [MIPS] Hibernation: only save pages in system ram
Date:	Fri, 3 Jul 2009 01:22:40 +0200
User-Agent: KMail/1.11.2 (Linux/2.6.31-rc1-rjw; KDE/4.2.4; x86_64; ; )
Cc:	LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org,
	Pavel Machek <pavel@ucw.cz>,
	Ralf Baechle <ralf@linux-mips.org>,
	Wu Zhangjin <wuzj@lemote.com>
References: <1246373570-21090-1-git-send-email-wuzhangjin@gmail.com>
In-Reply-To: <1246373570-21090-1-git-send-email-wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200907030122.41176.rjw@sisk.pl>
X-Virus-Scanned: amavisd-new at ogre.sisk.pl using MkS_Vir for Linux
Return-Path: <rjw@sisk.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23636
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rjw@sisk.pl
Precedence: bulk
X-list: linux-mips

On Tuesday 30 June 2009, Wu Zhangjin wrote:
> From: Wu Zhangjin <wuzj@lemote.com>
> 
> when using hibernation(STD) with CONFIG_FLATMEM in linux-mips-64bit, it
> fails for the current mips-specific hibernation implementation save the
> pages in all of the memory space(except the nosave section) and make
> there will be not enough memory left to the STD task itself, and then
> fail. in reality, we only need to save the pages in system rams.
> 
> here is the reason why it fail:
> 
> kernel/power/snapshot.c:
> 
> static void mark_nosave_pages(struct memory_bitmap *bm)
> {
> 		...
> 		if (pfn_valid(pfn)) {
> 			...
> 		}
> }
> 
> arch/mips/include/asm/page.h:
> 
> 	...
> 	#ifdef CONFIG_FLATMEM
> 
> 	#define pfn_valid(pfn)		((pfn) >= ARCH_PFN_OFFSET && (pfn) < max_mapnr)
> 
> 	#elif defined(CONFIG_SPARSEMEM)
> 
> 	/* pfn_valid is defined in linux/mmzone.h */
> 	...
> 
> we can rewrite pfn_valid(pfn) to fix this problem, but I really do not
> want to touch such a widely-used macro, so, I used another solution:
> 
> static struct page *saveable_page(struct zone *zone, unsigned long pfn)
> {
> 	...
> 	if ( .... pfn_is_nosave(pfn)
> 		return NULL;
> 	...
> }
> 
> and pfn_is_nosave is implemented in arch/mips/power/cpu.c, so, hacking
> this one is better.

Not really.

Could that be handled with the help of register_nosave_region() or
register_nosave_region_late() instead?

Best,
Rafael


> Signed-off-by: Wu Zhangjin <wuzj@lemote.com>
> ---
>  arch/mips/power/cpu.c |   19 ++++++++++++++++++-
>  1 files changed, 18 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/mips/power/cpu.c b/arch/mips/power/cpu.c
> index 7995df4..ef472e3 100644
> --- a/arch/mips/power/cpu.c
> +++ b/arch/mips/power/cpu.c
> @@ -10,6 +10,7 @@
>  #include <asm/suspend.h>
>  #include <asm/fpu.h>
>  #include <asm/dsp.h>
> +#include <asm/bootinfo.h>
>  
>  static u32 saved_status;
>  struct pt_regs saved_regs;
> @@ -34,10 +35,26 @@ void restore_processor_state(void)
>  		restore_dsp(current);
>  }
>  
> +int pfn_in_system_ram(unsigned long pfn)
> +{
> +	int i;
> +
> +	for (i = 0; i < boot_mem_map.nr_map; i++) {
> +		if (boot_mem_map.map[i].type == BOOT_MEM_RAM) {
> +			if ((pfn >= (boot_mem_map.map[i].addr >> PAGE_SHIFT)) &&
> +				((pfn) < ((boot_mem_map.map[i].addr +
> +					boot_mem_map.map[i].size) >> PAGE_SHIFT)))
> +				return 1;
> +		}
> +	}
> +	return 0;
> +}
> +
>  int pfn_is_nosave(unsigned long pfn)
>  {
>  	unsigned long nosave_begin_pfn = PFN_DOWN(__pa(&__nosave_begin));
>  	unsigned long nosave_end_pfn = PFN_UP(__pa(&__nosave_end));
>  
> -	return	(pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
> +	return ((pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn))
> +			|| !pfn_in_system_ram(pfn);
>  }
