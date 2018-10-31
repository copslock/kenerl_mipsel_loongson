Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2018 14:50:22 +0100 (CET)
Received: from merlin.infradead.org ([IPv6:2001:8b0:10b:1231::1]:55458 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
	with ESMTP id S23990901AbeJaNuSwVDKE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 31 Oct 2018 14:50:18 +0100
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	 bh=B29CGHTcZSRPozCawRO0XQWdzdy7ZVHP04YQm6az4Fg=; b=2b5VPEDS93iezL40hzfFNdB2Q
	Q2oa5emouDWxBDM7YjtCvq3RBkzYU9UIAhg4JYT01GQFj0M0iqYO6+dBiwEGq2gzVWqL4Z17nzAIt
	/B6Mw8Pfum22SIv40RbXUlPzRuOIwFss6fTghn7UuDUfNBHGP4GEMz19SdWzpCc+WDfIaRdUB3sZG
	8GRBWpBKrxDu+ziq0SVvPyqxxbDYcWxfT0Xhih5/K0Vaud120bGBsU6fMFbNhViPxD4EkUUuEv0o8
	CiOgYuuGdLGodb+aXmisTm5i694FBlKVCPEwsGRkq6o6x7rywLw/sbA47HHO8UScG/QrmYyAFJMes
	335WGiv3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
	by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gHqsD-0003jt-9j; Wed, 31 Oct 2018 13:49:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id 528272029F885; Wed, 31 Oct 2018 14:49:26 +0100 (CET)
Date:	Wed, 31 Oct 2018 14:49:26 +0100
From:	Peter Zijlstra <peterz@infradead.org>
To:	Douglas Anderson <dianders@chromium.org>
Cc:	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	kgdb-bugreport@lists.sourceforge.net, linux-mips@linux-mips.org,
	linux-sh@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	James Hogan <jhogan@kernel.org>, linux-hexagon@vger.kernel.org,
	Vineet Gupta <vgupta@synopsys.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Rich Felker <dalias@libc.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-snps-arc@lists.infradead.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Will Deacon <will.deacon@arm.com>,
	Paul Mackerras <paulus@samba.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@c-s.fr>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Paul Burton <paul.burton@mips.com>,
	linux-kernel@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/2] kgdb: Fix kgdb_roundup_cpus() for arches who used
 smp_call_function()
Message-ID: <20181031134926.GB13237@hirez.programming.kicks-ass.net>
References: <20181030221843.121254-1-dianders@chromium.org>
 <20181030221843.121254-3-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030221843.121254-3-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peterz@infradead.org
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

On Tue, Oct 30, 2018 at 03:18:43PM -0700, Douglas Anderson wrote:
> Looking closely at it, it seems like a really bad idea to be calling
> local_irq_enable() in kgdb_roundup_cpus().  If nothing else that seems
> like it could violate spinlock semantics and cause a deadlock.
> 
> Instead, let's use a private csd alongside
> smp_call_function_single_async() to round up the other CPUs.  Using
> smp_call_function_single_async() doesn't require interrupts to be
> enabled so we can remove the offending bit of code.

You might want to mention that the only reason this isn't a deadlock
itself is because there is a timeout on waiting for the slaves to
check-in.

> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -55,6 +55,7 @@
>  #include <linux/mm.h>
>  #include <linux/vmacache.h>
>  #include <linux/rcupdate.h>
> +#include <linux/irq.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/byteorder.h>
> @@ -220,6 +221,39 @@ int __weak kgdb_skipexception(int exception, struct pt_regs *regs)
>  	return 0;
>  }
>  
> +/*
> + * Default (weak) implementation for kgdb_roundup_cpus
> + */
> +
> +static DEFINE_PER_CPU(call_single_data_t, kgdb_roundup_csd);
> +
> +void __weak kgdb_call_nmi_hook(void *ignored)
> +{
> +	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
> +}
> +
> +void __weak kgdb_roundup_cpus(void)
> +{
> +	call_single_data_t *csd;
> +	int cpu;
> +
> +	for_each_cpu(cpu, cpu_online_mask) {
> +		csd = &per_cpu(kgdb_roundup_csd, cpu);
> +		smp_call_function_single_async(cpu, csd);
> +	}
> +}
> +
> +static void kgdb_generic_roundup_init(void)
> +{
> +	call_single_data_t *csd;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		csd = &per_cpu(kgdb_roundup_csd, cpu);
> +		csd->func = kgdb_call_nmi_hook;
> +	}
> +}
> +
>  /*
>   * Some architectures need cache flushes when we set/clear a
>   * breakpoint:
> @@ -993,6 +1027,8 @@ int kgdb_register_io_module(struct kgdb_io *new_dbg_io_ops)
>  		return -EBUSY;
>  	}
>  
> +	kgdb_generic_roundup_init();
> +
>  	if (new_dbg_io_ops->init) {
>  		err = new_dbg_io_ops->init();
>  		if (err) {

That's a little bit of overhead for those architectures not using that
generic code; but I suppose we can live with that.
