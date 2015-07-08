Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jul 2015 13:07:06 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:50629 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009509AbbGHLHEca0Vt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Jul 2015 13:07:04 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E349317;
        Wed,  8 Jul 2015 04:07:24 -0700 (PDT)
Received: from e104818-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25CBD3F23A;
        Wed,  8 Jul 2015 04:06:54 -0700 (PDT)
Date:   Wed, 8 Jul 2015 12:06:51 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Eric B Munson <emunson@akamai.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org, Michal Hocko <mhocko@suse.cz>,
        linux-am33-list@redhat.com, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com,
        linux-mips@linux-mips.org, linux-s390@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        adi-buildroot-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-m68k@lists.linux-m68k.org, Vlastimil Babka <vbabka@suse.cz>,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-api@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V3 2/5] mm: mlock: Add new mlock, munlock, and munlockall
 system calls
Message-ID: <20150708110651.GC6944@e104818-lin.cambridge.arm.com>
References: <1436288623-13007-1-git-send-email-emunson@akamai.com>
 <1436288623-13007-3-git-send-email-emunson@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1436288623-13007-3-git-send-email-emunson@akamai.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <catalin.marinas@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: catalin.marinas@arm.com
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

On Tue, Jul 07, 2015 at 01:03:40PM -0400, Eric B Munson wrote:
> diff --git a/arch/arm/kernel/calls.S b/arch/arm/kernel/calls.S
> index 05745eb..514e77b 100644
> --- a/arch/arm/kernel/calls.S
> +++ b/arch/arm/kernel/calls.S
> @@ -397,6 +397,9 @@
>  /* 385 */	CALL(sys_memfd_create)
>  		CALL(sys_bpf)
>  		CALL(sys_execveat)
> +		CALL(sys_mlock2)
> +		CALL(sys_munlock2)
> +/* 400 */	CALL(sys_munlockall2)

s/400/390/

> diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> index cef934a..318072aa 100644
> --- a/arch/arm64/include/asm/unistd32.h
> +++ b/arch/arm64/include/asm/unistd32.h
> @@ -797,3 +797,9 @@ __SYSCALL(__NR_memfd_create, sys_memfd_create)
>  __SYSCALL(__NR_bpf, sys_bpf)
>  #define __NR_execveat 387
>  __SYSCALL(__NR_execveat, compat_sys_execveat)
> +#define __NR_mlock2 388
> +__SYSCALL(__NR_mlock2, sys_mlock2)
> +#define __NR_munlock2 389
> +__SYSCALL(__NR_munlock2, sys_munlock2)
> +#define __NR_munlockall2 390
> +__SYSCALL(__NR_munlockall2, sys_munlockall2)

These look fine.

Catalin
