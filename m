Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Jun 2009 03:52:15 +0200 (CEST)
Received: from fwgate.192.149.94.202.in-addr.arpa ([202.94.149.254]:39570 "EHLO
	topsms.toshiba-tops.co.jp" rhost-flags-OK-FAIL-OK-FAIL)
	by ftp.linux-mips.org with ESMTP id S1493034AbZFYBwI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 25 Jun 2009 03:52:08 +0200
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id E30A04D7D9;
	Thu, 25 Jun 2009 10:38:07 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id CF5874C055;
	Thu, 25 Jun 2009 10:38:07 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id n5P1mOoI090243;
	Thu, 25 Jun 2009 10:48:25 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 25 Jun 2009 10:48:24 +0900 (JST)
Message-Id: <20090625.104824.00670470.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	KKylheku@zeugmasystems.com, aurelien@aurel32.net,
	ralf@linux-mips.org
Subject: icache flushing (Re: Broadcom Swarm support)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <DDFD17CC94A9BD49A82147DDF7D545C501C3539B@exchange.ZeugmaSystems.local>
References: <20090624063453.GA16846@volta.aurel32.net>
	<DDFD17CC94A9BD49A82147DDF7D545C501C3539B@exchange.ZeugmaSystems.local>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 6.2.50 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 24 Jun 2009 15:18:24 -0700, "Kaz Kylheku" <KKylheku@zeugmasystems.com> wrote:
> At some point in the kernel history, Ralfie decided that
> the flush_icache_page function is unnecessary and
> turned it into a MIPS-wide noop. But the SB1 core, which has
> a VIVT instruction cache, it appears that there
> is some kind of issue whereby when it
> is handling a fault for a not-present virtual page,
> it somehow ends up with bad data in the instruction
> cache---perhaps an inconsistent state due to not having
> been able to complete the fetch, but having initiated
> a cache update on the expectation that the fetch
> will complete. It seems that the the fault handler
> is expected to do a flush.

Looking at current code, I also have some questions aboud icache
flushing.

* flush_cache_mm does not flush icache.  Is it OK?

* flush_cache_{vmap,vunmap} does not flush icache.  When icache used
  by modules flushed after unloading?

* __update_cache, copy_user_highpage does not flush icache even if
  !cpu_has_ic_fills_f_dc.  Is it OK?

* free_initmem does not flush icache.  When these init pages are
  reused, how corresponding icache will be flushed?

I suppose flushing icache in flush_icache_page() will hide real bugs
somewhere else...

---
Atsushi Nemoto
