Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Nov 2007 14:27:37 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:49900 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20029615AbXK1O1e (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Nov 2007 14:27:34 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lASBNdlP021486
	for <linux-mips@linux-mips.org>; Wed, 28 Nov 2007 11:23:39 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lASBNdCA021472;
	Wed, 28 Nov 2007 11:23:39 GMT
Date:	Wed, 28 Nov 2007 11:23:39 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Pavel Kiryukhin <vksavl@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: BUG: using smp_processor_id() in preemptible code
Message-ID: <20071128112338.GA21444@linux-mips.org>
References: <73cd086a0711270820r92dc164heaa453e94cf1a8c6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73cd086a0711270820r92dc164heaa453e94cf1a8c6@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17625
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 27, 2007 at 07:20:47PM +0300, Pavel Kiryukhin wrote:

> I get the following bug running 2.6.18 on malta34Kc .
> 
> Freeing prom memory: 956kb freed
> Freeing firmware memory: 978944k freed
> Freeing unused kernel memory: 180k freed
> BUG: using smp_processor_id() in preemptible [00000000] code: swapper/1
> caller is r4k_dma_cache_wback_inv+0x144/0x2a0
> Call Trace:
>  [<80117af8>] r4k_dma_cache_wback_inv+0x144/0x2a0
>  [<802e4b84>] debug_smp_processor_id+0xd4/0xf0
>  [<802e4b7c>] debug_smp_processor_id+0xcc/0xf0
> ...
> CONFIG_DEBUG_PREEMPT is enabled.
> --
> Bug cause is blast_dcache_range() in preemptible code [in
> r4k_dma_cache_wback_inv()].
> blast_dcache_range() is constructed via __BUILD_BLAST_CACHE_RANGE that
> uses cpu_dcache_line_size(). It uses current_cpu_data that use
> smp_processor_id() in turn. In case of CONFIG_DEBUG_PREEMPT
> smp_processor_id emits BUG if we are executing with preemption
> enabled.
> 
> Cpu options of cpu0 are assumed to be the superset of all processors.
> 
> Can I make the same assumptions for cache line size  and fix this
> issue the following way:

That's safe and probably saner than littlering preempt_disable /
preempt_enable calls over the code.

  Ralf
