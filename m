Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2009 12:53:33 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:54389 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S20021422AbZEVLx1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 22 May 2009 12:53:27 +0100
Received: from localhost (p3039-ipad311funabasi.chiba.ocn.ne.jp [123.217.213.39])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C2C18ABBF; Fri, 22 May 2009 20:53:21 +0900 (JST)
Date:	Fri, 22 May 2009 20:53:21 +0900 (JST)
Message-Id: <20090522.205321.95059875.anemo@mba.ocn.ne.jp>
To:	gerg@snapgear.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: system lockup with 2.6.29 on Cavium/Octeon
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <4A15FD84.8050505@snapgear.com>
References: <20090520142604.GA29677@linux-mips.org>
	<20090521.235020.173372074.anemo@mba.ocn.ne.jp>
	<4A15FD84.8050505@snapgear.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 22 May 2009 11:19:00 +1000, Greg Ungerer <gerg@snapgear.com> wrote:
> > The wrong combination comes from lazy vunmapping which was introduced
> > in 2.6.28 cycle.  Maybe we can add new API (non-lazy version of
> > vfree()) to vmalloc.c to implement module_free(), but I suppose
> > fallbacking to local_flush_tlb_all() in local_flush_tlb_kernel_range()
> > is enough().
> 
> Is there any performance impact on falling back to that?
> 
> The flushing due to lazy vunmapping didn't seem to happen
> often in the tests I was running.

I think the wrong combination can happen only when some modules were
unloaded, so performance impact would not be serious even if exists.

---
Atsushi Nemoto
