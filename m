Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2003 17:48:38 +0100 (BST)
Received: from p508B5EC1.dip.t-dialin.net ([IPv6:::ffff:80.139.94.193]:50050
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225235AbTDNQsh>; Mon, 14 Apr 2003 17:48:37 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3EGmXo19874;
	Mon, 14 Apr 2003 18:48:33 +0200
Date: Mon, 14 Apr 2003 18:48:33 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org
Subject: Re: minor c-r4k.c cleanup
Message-ID: <20030414184833.A19291@linux-mips.org>
References: <20030415.002425.74756927.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030415.002425.74756927.anemo@mba.ocn.ne.jp>; from anemo@mba.ocn.ne.jp on Tue, Apr 15, 2003 at 12:24:25AM +0900
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 15, 2003 at 12:24:25AM +0900, Atsushi Nemoto wrote:

> r4k_dma_cache_xxx should not flush icache ?

The dma_* functions of course don't need I-cache coherence.

> And I wonder why r4k_flush_pcache_mm (and r4k_flush_pcache_all) does
> nothing if cpu_has_dc_aliases was not true.  I'm still
> investigating...

R4000SC / R4400SC caches have the subset property.  S-cache cacheops
flush the primary caches as well and P-caches must always be a subset
of the S-cache or operation is undefined.

  Ralf
