Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2009 12:36:20 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:9981 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S21365156AbZA2MgS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 29 Jan 2009 12:36:18 +0000
Received: from localhost (p2102-ipad401funabasi.chiba.ocn.ne.jp [123.217.236.102])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 9F842A89A; Thu, 29 Jan 2009 21:36:11 +0900 (JST)
Date:	Thu, 29 Jan 2009 21:36:13 +0900 (JST)
Message-Id: <20090129.213613.128618730.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	ddaney@caviumnetworks.com, msundius@cisco.com,
	linux-mips@linux-mips.org, dvomlehn@cisco.com, msundius@sundius.com
Subject: Re: memcpy and prefetch
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20090128183047.GA1691@linux-mips.org>
References: <20090128103753.GC2234@linux-mips.org>
	<20090129.002850.118974677.anemo@mba.ocn.ne.jp>
	<20090128183047.GA1691@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 28 Jan 2009 18:30:47 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> --- a/arch/mips/lib/memcpy.S
> +++ b/arch/mips/lib/memcpy.S
> @@ -21,7 +21,7 @@
>   * end of memory on some systems.  It's also a seriously bad idea on non
>   * dma-coherent systems.
>   */
> -#if !defined(CONFIG_DMA_COHERENT) || !defined(CONFIG_DMA_IP27)
> +#ifdef CONFIG_DMA_NONCOHERENT
>  #undef CONFIG_CPU_HAS_PREFETCH
>  #endif
>  #ifdef CONFIG_MIPS_MALTA

This makes IP27 (and all other coherent platforms) use prefetch.  Is
prefetch OK for all of them?

I suppose memcpy_fromio() should not use PREFETCH, at least.

---
Atsushi Nemoto
