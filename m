Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Feb 2008 21:28:27 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:63720 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28574393AbYBRV2Z (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 18 Feb 2008 21:28:25 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m1ILSNMc010480;
	Mon, 18 Feb 2008 21:28:24 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m1ILSNsf010479;
	Mon, 18 Feb 2008 21:28:23 GMT
Date:	Mon, 18 Feb 2008 21:28:23 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Reimplement clear_page/copy_page
Message-ID: <20080218212823.GA10420@linux-mips.org>
References: <20080218193249.GD4747@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080218193249.GD4747@networkno.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 18, 2008 at 07:32:49PM +0000, Thiemo Seufer wrote:

> Fold the SB-1 specific implementation of clear_page/copy_page in the
> generic version, and rewrite that one in tlbex style. The immediate
> benefits:
>   - It converts the compile-time workaround for SB-1 pass 1 prefetches
>     to a more efficient run-time check.
>   - It allows adjustment of loop unfolling, which helps to reduce the
>     number of redundant cdex cache ops.
>   - It fixes some esoteric cornercases (the cache line length calculations
>     can go wrong, and support for 64k pages without prefetch instructions
>     will overflow the addiu immediate).
>   - Somewhat better guesses of "good" prefetch values.
> 
> 
> Signed-off-by: Thiemo Seufer <ths@networkno.de>
> ---
> 
> Lmbench3 running on a BCM1480 system shows improvements for some
> benchmarks (three runs with the original kernel, then three runs
> with the patched kernel), most markedly (~5%) for open/close and
> exec:

The patch is certainly a good thing but I somehow doubt for many of the
improvments that they are a result of the patch and not the unavoidable
benchmarking noise.

Queued for 2.6.26,

  Ralf
