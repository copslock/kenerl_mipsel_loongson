Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Feb 2006 05:09:31 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([202.230.225.5]:29204 "HELO
	topsns.toshiba-tops.co.jp") by ftp.linux-mips.org with SMTP
	id S8126537AbWBCFJN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 3 Feb 2006 05:09:13 +0000
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with SMTP; 3 Feb 2006 05:14:27 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 9DC5D203A3;
	Fri,  3 Feb 2006 14:14:25 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 89D40201FC;
	Fri,  3 Feb 2006 14:14:25 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k135EO4D023175;
	Fri, 3 Feb 2006 14:14:25 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 03 Feb 2006 14:14:24 +0900 (JST)
Message-Id: <20060203.141424.72708300.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [PATCH] local_r4k_flush_cache_page fix
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060201.000356.25911337.anemo@mba.ocn.ne.jp>
References: <20060201.000356.25911337.anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10323
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 01 Feb 2006 00:03:56 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:
anemo> If dcache_size != icache_size or dcache_size != scache_size,
anemo> icache/scache does not flushed properly.  Use correct cache
anemo> size to calculate index value for scache/icache.

Sorry, this patch was wrong !

We should use mask value based on the waysize (not whole cache size).

And now I think it would be better to do it in __BUILD_BLAST_CACHE().

I'll post a new patch later.

---
Atsushi Nemoto
