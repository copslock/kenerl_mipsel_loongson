Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Aug 2015 03:42:06 +0200 (CEST)
Received: from ozlabs.org ([103.22.144.67]:35348 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012007AbbHCBmEsqpzN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 3 Aug 2015 03:42:04 +0200
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 2A08914007F;
        Mon,  3 Aug 2015 11:41:59 +1000 (AEST)
Message-ID: <1438566118.8863.3.camel@ellerman.id.au>
Subject: Re: [PATCH v2] arch: use WRITE_ONCE/READ_ONCE in
 smp_store_release/smp_load_acquire
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Duyck <alexander.h.duyck@redhat.com>,
        Andre Przywara <andre.przywara@arm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Borislav Petkov <bp@suse.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Date:   Mon, 03 Aug 2015 11:41:58 +1000
In-Reply-To: <1438528264-714-1-git-send-email-andreyknvl@google.com>
References: <1438528264-714-1-git-send-email-andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <mpe@ellerman.id.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48536
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mpe@ellerman.id.au
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

On Sun, 2015-08-02 at 17:11 +0200, Andrey Konovalov wrote:
> Replace ACCESS_ONCE() macro in smp_store_release() and smp_load_acquire()
> with WRITE_ONCE() and READ_ONCE() on x86, arm, arm64, ia64, metag, mips,
> powerpc, s390, sparc and asm-generic since ACCESS_ONCE does not work
> reliably on non-scalar types.

.. and there are no restrictions on the argument to smp_load_acquire(), so it
may be a non-scalar type.

Though from a quick grep it looks like no one is doing that at the moment?

> WRITE_ONCE() and READ_ONCE() were introduced in the commits 230fa253df63
> ("kernel: Provide READ_ONCE and ASSIGN_ONCE") and 43239cbe79fc ("kernel:
> Change ASSIGN_ONCE(val, x) to WRITE_ONCE(x, val)").
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
> Changed in v2:
>   - Other archs besides x86.
> 
>  arch/powerpc/include/asm/barrier.h  | 4 ++--

> diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
> index 51ccc72..0eca6ef 100644
> --- a/arch/powerpc/include/asm/barrier.h
> +++ b/arch/powerpc/include/asm/barrier.h
> @@ -76,12 +76,12 @@
>  do {									\
>  	compiletime_assert_atomic_type(*p);				\
>  	smp_lwsync();							\
> -	ACCESS_ONCE(*p) = (v);						\
> +	WRITE_ONCE(*p, v);						\
>  } while (0)
>  
>  #define smp_load_acquire(p)						\
>  ({									\
> -	typeof(*p) ___p1 = ACCESS_ONCE(*p);				\
> +	typeof(*p) ___p1 = READ_ONCE(*p);				\
>  	compiletime_assert_atomic_type(*p);				\
>  	smp_lwsync();							\
>  	___p1;								\

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
