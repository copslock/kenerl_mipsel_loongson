Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Mar 2014 18:38:00 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:8907 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817552AbaCURh5ptfzn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Mar 2014 18:37:57 +0100
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s2LHbsLn015826
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 21 Mar 2014 13:37:54 -0400
Received: from madcap2.tricolour.ca (vpn-59-180.rdu2.redhat.com [10.10.59.180])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s2LHboO3003305
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Fri, 21 Mar 2014 13:37:52 -0400
Date:   Fri, 21 Mar 2014 13:37:50 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Eric Paris <eparis@redhat.com>
Cc:     linux-audit@redhat.com, linux-mips@linux-mips.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/2] audit: use uapi/linux/audit.h for AUDIT_ARCH
 declarations
Message-ID: <20140321173750.GB16467@madcap2.tricolour.ca>
References: <1394573578-2558-1-git-send-email-eparis@redhat.com>
 <1394573578-2558-2-git-send-email-eparis@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1394573578-2558-2-git-send-email-eparis@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Return-Path: <rgb@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rgb@redhat.com
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

On 14/03/11, Eric Paris wrote:
> The syscall.h headers were including linux/audit.h but really only
> needed the uapi/linux/audit.h to get the requisite defines.  Switch to
> the uapi headers.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mips@linux-mips.org
> Cc: linux-s390@vger.kernel.org
> Cc: x86@kernel.org

Acked-by: Richard Guy Briggs <rgb@redhat.com>

> ---
>  arch/arm/include/asm/syscall.h  | 2 +-
>  arch/mips/include/asm/syscall.h | 2 +-
>  arch/s390/include/asm/syscall.h | 2 +-
>  arch/x86/include/asm/syscall.h  | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
> index ed805f1..4651f69 100644
> --- a/arch/arm/include/asm/syscall.h
> +++ b/arch/arm/include/asm/syscall.h
> @@ -7,7 +7,7 @@
>  #ifndef _ASM_ARM_SYSCALL_H
>  #define _ASM_ARM_SYSCALL_H
>  
> -#include <linux/audit.h> /* for AUDIT_ARCH_* */
> +#include <uapi/linux/audit.h> /* for AUDIT_ARCH_* */
>  #include <linux/elf.h> /* for ELF_EM */
>  #include <linux/err.h>
>  #include <linux/sched.h>
> diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
> index 625e709..fc556d8 100644
> --- a/arch/mips/include/asm/syscall.h
> +++ b/arch/mips/include/asm/syscall.h
> @@ -13,7 +13,7 @@
>  #ifndef __ASM_MIPS_SYSCALL_H
>  #define __ASM_MIPS_SYSCALL_H
>  
> -#include <linux/audit.h>
> +#include <uapi/linux/audit.h>
>  #include <linux/elf-em.h>
>  #include <linux/kernel.h>
>  #include <linux/sched.h>
> diff --git a/arch/s390/include/asm/syscall.h b/arch/s390/include/asm/syscall.h
> index bebc0bd..7776870 100644
> --- a/arch/s390/include/asm/syscall.h
> +++ b/arch/s390/include/asm/syscall.h
> @@ -12,7 +12,7 @@
>  #ifndef _ASM_SYSCALL_H
>  #define _ASM_SYSCALL_H	1
>  
> -#include <linux/audit.h>
> +#include <uapi/linux/audit.h>
>  #include <linux/sched.h>
>  #include <linux/err.h>
>  #include <asm/ptrace.h>
> diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
> index 7e6d0c4..d6a756a 100644
> --- a/arch/x86/include/asm/syscall.h
> +++ b/arch/x86/include/asm/syscall.h
> @@ -13,7 +13,7 @@
>  #ifndef _ASM_X86_SYSCALL_H
>  #define _ASM_X86_SYSCALL_H
>  
> -#include <linux/audit.h>
> +#include <uapi/linux/audit.h>
>  #include <linux/sched.h>
>  #include <linux/err.h>
>  #include <asm/asm-offsets.h>	/* For NR_syscalls */
> -- 
> 1.8.5.3
> 
> --
> Linux-audit mailing list
> Linux-audit@redhat.com
> https://www.redhat.com/mailman/listinfo/linux-audit

- RGB

--
Richard Guy Briggs <rbriggs@redhat.com>
Senior Software Engineer, Kernel Security, AMER ENG Base Operating Systems, Red Hat
Remote, Ottawa, Canada
Voice: +1.647.777.2635, Internal: (81) 32635, Alt: +1.613.693.0684x3545
