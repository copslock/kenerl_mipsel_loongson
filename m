Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Mar 2017 11:32:04 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:40182 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992123AbdCJKb42tm68 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Mar 2017 11:31:56 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v2AAVsNV022275;
        Fri, 10 Mar 2017 11:31:54 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v2AAVqHZ022274;
        Fri, 10 Mar 2017 11:31:52 +0100
Date:   Fri, 10 Mar 2017 11:31:52 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mips@linux-mips.org, james.hogan@imgtec.com,
        paul.burton@imgtec.com, marcin.nowakowski@imgtec.com,
        justinpopo6@gmail.com, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH 2/2] MIPS: c-r4k: Do not SMP function call during kexec
Message-ID: <20170310103152.GA22089@linux-mips.org>
References: <20170308014641.16267-1-f.fainelli@gmail.com>
 <20170308014641.16267-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170308014641.16267-3-f.fainelli@gmail.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57131
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

On Tue, Mar 07, 2017 at 05:46:41PM -0800, Florian Fainelli wrote:

> On SMP r4k cache style systems, we cannot issue a
> smp_function_call_many() like what __flush_cache_all() does *after* we
> have disabled interrupts for the calling CPU. Add a special check, and
> do a local cache operation instead.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/mips/mm/c-r4k.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index e7f798d55fbc..ea2998f1f5c5 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -19,6 +19,7 @@
>  #include <linux/mm.h>
>  #include <linux/export.h>
>  #include <linux/bitops.h>
> +#include <linux/kexec.h>
>  
>  #include <asm/bcache.h>
>  #include <asm/bootinfo.h>
> @@ -494,7 +495,10 @@ static inline void local_r4k___flush_cache_all(void * args)
>  
>  static void r4k___flush_cache_all(void)
>  {
> -	r4k_on_each_cpu(R4K_INDEX, local_r4k___flush_cache_all, NULL);
> +	if (!kexec_in_progress)
> +		r4k_on_each_cpu(R4K_INDEX, local_r4k___flush_cache_all, NULL);
> +	else
> +		local_r4k___flush_cache_all(NULL);
>  }

The cache management code shouldn't know about kexec.  And if the problem
is calling __flush_cache_all with interrupts disabled, then why not
calling it with interrupts enabled which can be trivially done by moving
the call by a few lines?

Suggested by untested patch below, so testing would be appreciated.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/kernel/machine_kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/machine_kexec.c b/arch/mips/kernel/machine_kexec.c
index 8b574bc..d6a6abe 100644
--- a/arch/mips/kernel/machine_kexec.c
+++ b/arch/mips/kernel/machine_kexec.c
@@ -117,6 +117,7 @@ machine_kexec(struct kimage *image)
 		    *ptr & IND_DESTINATION)
 			*ptr = (unsigned long) phys_to_virt(*ptr);
 	}
+	__flush_cache_all();
 
 	/*
 	 * we do not want to be bothered.
@@ -125,7 +126,6 @@ machine_kexec(struct kimage *image)
 
 	printk("Will call new kernel at %08lx\n", image->start);
 	printk("Bye ...\n");
-	__flush_cache_all();
 #ifdef CONFIG_SMP
 	/* All secondary cpus now may jump to kexec_wait cycle */
 	relocated_kexec_smp_wait = reboot_code_buffer +
