Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jan 2016 17:40:12 +0100 (CET)
Received: from e35.co.us.ibm.com ([32.97.110.153]:54015 "EHLO
        e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009580AbcALQkKlfcnr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Jan 2016 17:40:10 +0100
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 12 Jan 2016 09:40:04 -0700
Received: from d03dlp01.boulder.ibm.com (9.17.202.177)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Tue, 12 Jan 2016 09:40:01 -0700
X-IBM-Helo: d03dlp01.boulder.ibm.com
X-IBM-MailFrom: paulmck@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 0EE941FF004A
        for <linux-mips@linux-mips.org>; Tue, 12 Jan 2016 09:28:11 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u0CGe0WL29360148
        for <linux-mips@linux-mips.org>; Tue, 12 Jan 2016 09:40:00 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
        by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u0CGdroA008722
        for <linux-mips@linux-mips.org>; Tue, 12 Jan 2016 09:40:00 -0700
Received: from paulmck-ThinkPad-W541 ([9.70.82.27])
        by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u0CGdnM3008363;
        Tue, 12 Jan 2016 09:39:49 -0700
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7AED816C29A0; Tue, 12 Jan 2016 08:31:02 -0800 (PST)
Date:   Tue, 12 Jan 2016 08:31:02 -0800
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        virtualization@lists.linux-foundation.org,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Joe Perches <joe@perches.com>,
        David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        xen-devel@lists.xenproject.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v3 05/41] powerpc: reuse asm-generic/barrier.h
Message-ID: <20160112163102.GE3818@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <1452426622-4471-1-git-send-email-mst@redhat.com>
 <1452426622-4471-6-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1452426622-4471-6-git-send-email-mst@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16011216-0013-0000-0000-00001BCFEF96
Return-Path: <paulmck@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51080
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paulmck@linux.vnet.ibm.com
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

On Sun, Jan 10, 2016 at 04:17:09PM +0200, Michael S. Tsirkin wrote:
> On powerpc read_barrier_depends, smp_read_barrier_depends
> smp_store_mb(), smp_mb__before_atomic and smp_mb__after_atomic match the
> asm-generic variants exactly. Drop the local definitions and pull in
> asm-generic/barrier.h instead.
> 
> This is in preparation to refactoring this code area.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Looks sane to me.

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> ---
>  arch/powerpc/include/asm/barrier.h | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
> index a7af5fb..980ad0c 100644
> --- a/arch/powerpc/include/asm/barrier.h
> +++ b/arch/powerpc/include/asm/barrier.h
> @@ -34,8 +34,6 @@
>  #define rmb()  __asm__ __volatile__ ("sync" : : : "memory")
>  #define wmb()  __asm__ __volatile__ ("sync" : : : "memory")
> 
> -#define smp_store_mb(var, value) do { WRITE_ONCE(var, value); smp_mb(); } while (0)
> -
>  #ifdef __SUBARCH_HAS_LWSYNC
>  #    define SMPWMB      LWSYNC
>  #else
> @@ -60,9 +58,6 @@
>  #define smp_wmb()	barrier()
>  #endif /* CONFIG_SMP */
> 
> -#define read_barrier_depends()		do { } while (0)
> -#define smp_read_barrier_depends()	do { } while (0)
> -
>  /*
>   * This is a barrier which prevents following instructions from being
>   * started until the value of the argument x is known.  For example, if
> @@ -87,8 +82,8 @@ do {									\
>  	___p1;								\
>  })
> 
> -#define smp_mb__before_atomic()     smp_mb()
> -#define smp_mb__after_atomic()      smp_mb()
>  #define smp_mb__before_spinlock()   smp_mb()
> 
> +#include <asm-generic/barrier.h>
> +
>  #endif /* _ASM_POWERPC_BARRIER_H */
> -- 
> MST
> 
