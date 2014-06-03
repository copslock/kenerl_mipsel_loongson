Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jun 2014 00:47:58 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46941 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6854780AbaFCWr410Z1E (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Jun 2014 00:47:56 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s53MlgLo027600;
        Wed, 4 Jun 2014 00:47:42 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s53MldkW027568;
        Wed, 4 Jun 2014 00:47:39 +0200
Date:   Wed, 4 Jun 2014 00:47:39 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V2 4/8] MIPS: Add NUMA support for Loongson-3
Message-ID: <20140603224739.GU17197@linux-mips.org>
References: <1397348662-22502-1-git-send-email-chenhc@lemote.com>
 <1397348662-22502-5-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1397348662-22502-5-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Sun, Apr 13, 2014 at 08:24:18AM +0800, Huacai Chen wrote:

> Multiple Loongson-3A chips can be interconnected with HT0-bus. This is
> a CC-NUMA system that every chip (node) has its own local memory and
> cache coherency is maintained by hardware. The 64-bit physical memory
> address format is as follows:
> 
> 0x-0000-YZZZ-ZZZZ-ZZZZ
> 
> The high 16 bits should be 0, which means the real physical address
> supported by Loongson-3 is 48-bit. The "Y" bits is the base address of
> each node, which can be also considered as the node-id. The "Z" bits is
> the address offset within a node, which means every node has a 44 bits
> address space.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>

> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2233,9 +2233,14 @@ config SYS_SUPPORTS_NUMA
>  	bool
>  
>  config NODES_SHIFT
> -	int
> +	int "Maximum Number of NUMA Nodes Shift"
> +	range 1 10
>  	default "6"
>  	depends on NEED_MULTIPLE_NODES
> +	help
> +	  This option specifies the maximum number of available NUMA nodes
> +	  on the target system. MAX_NUMNODES will be 2^(This value).
> +	  If in doubt, use the default.

I always feel a bit uneasy to present options such as NODES_SHIFT to the
user.

> --- a/arch/mips/include/asm/addrspace.h
> +++ b/arch/mips/include/asm/addrspace.h
> @@ -51,8 +51,14 @@
>   * Returns the physical address of a CKSEGx / XKPHYS address
>   */
>  #define CPHYSADDR(a)		((_ACAST32_(a)) & 0x1fffffff)
> +
> +#ifndef CONFIG_NUMA
>  #define XPHYSADDR(a)		((_ACAST64_(a)) &			\
>  				 _CONST64_(0x000000ffffffffff))
> +#else
> +#define XPHYSADDR(a)		((_ACAST64_(a)) &			\
> +				 _CONST64_(0x0000ffffffffffff))
> +#endif

The mask in XPHYSADDR is a function of the processor architecture, not
imlementation, not NUMA.  The latest version of the MIPS architecture
permits PABITS to be as large as 49 bits, so the mask should be
0x0001ffffffffffff.  Always.

> diff --git a/arch/mips/include/asm/sparsemem.h b/arch/mips/include/asm/sparsemem.h
> index d2da53c..c001a90 100644
> --- a/arch/mips/include/asm/sparsemem.h
> +++ b/arch/mips/include/asm/sparsemem.h
> @@ -11,7 +11,12 @@
>  #else
>  # define SECTION_SIZE_BITS	28
>  #endif
> +
> +#ifdef CONFIG_NUMA
> +#define MAX_PHYSMEM_BITS	48
> +#else
>  #define MAX_PHYSMEM_BITS	35
> +#endif

Essentially the same comment as for XPHYSADDR above.

  Ralf
