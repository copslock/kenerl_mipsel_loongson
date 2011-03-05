Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Mar 2011 01:58:04 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:42305 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491981Ab1CEA6B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Mar 2011 01:58:01 +0100
Received: by ywa8 with SMTP id 8so1035463ywa.36
        for <multiple recipients>; Fri, 04 Mar 2011 16:57:54 -0800 (PST)
Received: by 10.150.7.2 with SMTP id 2mr26269ybg.300.1299286674069;
        Fri, 04 Mar 2011 16:57:54 -0800 (PST)
Received: from angua (S01060002b3d79728.cg.shawcable.net [70.72.87.49])
        by mx.google.com with ESMTPS id q13sm100181yba.20.2011.03.04.16.57.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 Mar 2011 16:57:53 -0800 (PST)
Received: by angua (Postfix, from userid 1000)
        id 0E7083C00D3; Fri,  4 Mar 2011 17:57:50 -0700 (MST)
Date:   Fri, 4 Mar 2011 17:57:50 -0700
From:   Grant Likely <grant.likely@secretlab.ca>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 02/12] of: Allow scripts/dtc/libfdt to be used
 from kernel code
Message-ID: <20110305005750.GC7579@angua.secretlab.ca>
References: <1299267744-17278-1-git-send-email-ddaney@caviumnetworks.com>
 <1299267744-17278-3-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1299267744-17278-3-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips

[cc'ing David Gibson]
On Fri, Mar 04, 2011 at 11:42:14AM -0800, David Daney wrote:
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
>  include/linux/libfdt.h      |    3 +++
>  lib/Kconfig                 |    6 ++++++
>  lib/Makefile                |    2 ++
>  lib/libfdt/Makefile         |    7 +++++++
>  lib/libfdt/libfdt_env.h     |   21 +++++++++++++++++++++
>  scripts/dtc/libfdt/libfdt.h |    4 ++--
>  6 files changed, 41 insertions(+), 2 deletions(-)
>  create mode 100644 include/linux/libfdt.h
>  create mode 100644 lib/libfdt/Makefile
>  create mode 100644 lib/libfdt/libfdt_env.h
> 
> diff --git a/include/linux/libfdt.h b/include/linux/libfdt.h
> new file mode 100644
> index 0000000..10bce91
> --- /dev/null
> +++ b/include/linux/libfdt.h
> @@ -0,0 +1,3 @@
> +#include "../../lib/libfdt/libfdt_env.h"

libfdt_env.h should be in include/linux

> +#include "../../scripts/dtc/libfdt/fdt.h"
> +#include "../../scripts/dtc/libfdt/libfdt.h"

Hmmm... I wonder if there is a better way to do this.  I don't much
care for the relative path references.

Also, need to have #ifdef _INCLUDE_LIBFDT_H_ protection

> diff --git a/lib/Kconfig b/lib/Kconfig
> index 0ee67e0..e8a2638 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -219,4 +219,10 @@ config LRU_CACHE
>  config AVERAGE
>  	bool
>  
> +#
> +# The Flattened Device Tree manipulation library
> +#
> +config LIBFDT
> +	bool
> +

This should be in drivers/of/Kconfig

>  endmenu
> diff --git a/lib/Makefile b/lib/Makefile
> index cbb774f..5840115 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -110,6 +110,8 @@ obj-$(CONFIG_ATOMIC64_SELFTEST) += atomic64_test.o
>  
>  obj-$(CONFIG_AVERAGE) += average.o
>  
> +obj-$(CONFIG_LIBFDT) += libfdt/
> +

Ditto here; drivers/of/libfdt

>  hostprogs-y	:= gen_crc32table
>  clean-files	:= crc32table.h
>  
> diff --git a/lib/libfdt/Makefile b/lib/libfdt/Makefile
> new file mode 100644
> index 0000000..6c1a496
> --- /dev/null
> +++ b/lib/libfdt/Makefile
> @@ -0,0 +1,7 @@
> +obj-y = fdt.o fdt_wip.o fdt_ro.o
> +
> +EXTRA_CFLAGS += -include $(src)/libfdt_env.h -I$(src)/../../scripts/dtc/libfdt
> +
> +$(obj)/%.o: $(src)/../../scripts/dtc/libfdt/%.c FORCE
> +	$(call cmd,force_checksrc)
> +	$(call if_changed_rule,cc_o_c)
> diff --git a/lib/libfdt/libfdt_env.h b/lib/libfdt/libfdt_env.h
> new file mode 100644
> index 0000000..d977b8b
> --- /dev/null
> +++ b/lib/libfdt/libfdt_env.h
> @@ -0,0 +1,21 @@
> +#ifndef _LIBFDT_ENV_H
> +#define _LIBFDT_ENV_H
> +
> +#include <linux/string.h>
> +
> +#define _B(n)	((unsigned long long)((uint8_t *)&x)[n])
> +static inline uint32_t fdt32_to_cpu(uint32_t x)
> +{
> +	return (_B(0) << 24) | (_B(1) << 16) | (_B(2) << 8) | _B(3);
> +}
> +#define cpu_to_fdt32(x) fdt32_to_cpu(x)
> +
> +static inline uint64_t fdt64_to_cpu(uint64_t x)
> +{
> +	return (_B(0) << 56) | (_B(1) << 48) | (_B(2) << 40) | (_B(3) << 32)
> +		| (_B(4) << 24) | (_B(5) << 16) | (_B(6) << 8) | _B(7);
> +}
> +#define cpu_to_fdt64(x) fdt64_to_cpu(x)
> +#undef _B
> +

This isn't necessary, the kernel already has efficient architecture
macros for converting endianess.

#define fdt32_to_cpu(x) be32_to_cpu(x)
#define cpu_to_fdt32(x) cpu_to_be32(x)
#define fdt64_to_cpu(x) be64_to_cpu(x)
#define cpu_to_fdt64(x) cpu_to_be64(x)

> +#endif /* _LIBFDT_ENV_H */
> diff --git a/scripts/dtc/libfdt/libfdt.h b/scripts/dtc/libfdt/libfdt.h
> index ce80e4f..33a0c4d 100644
> --- a/scripts/dtc/libfdt/libfdt.h
> +++ b/scripts/dtc/libfdt/libfdt.h
> @@ -51,8 +51,8 @@
>   *     EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>   */
>  
> -#include <libfdt_env.h>
> -#include <fdt.h>
> +#include "libfdt_env.h"
> +#include "fdt.h"

This causes problems.  libfdt is an external library that is
periodically copied into the kernel tree.  It would be better to add
"-Iscripts/dtc/libfdt" to CFLAGS for .c files that want to call libfdt
routines.

>  
>  #define FDT_FIRST_SUPPORTED_VERSION	0x10
>  #define FDT_LAST_SUPPORTED_VERSION	0x11
> -- 
> 1.7.2.3
> 
