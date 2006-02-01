Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Feb 2006 06:27:20 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([202.230.225.5]:39947 "HELO
	topsns.toshiba-tops.co.jp") by ftp.linux-mips.org with SMTP
	id S8133551AbWBAG04 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Feb 2006 06:26:56 +0000
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with SMTP; 1 Feb 2006 06:31:58 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 908112036A;
	Wed,  1 Feb 2006 15:31:55 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 82B522036E;
	Wed,  1 Feb 2006 15:31:55 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k116Vs4D012929;
	Wed, 1 Feb 2006 15:31:55 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 01 Feb 2006 15:31:54 +0900 (JST)
Message-Id: <20060201.153154.108306076.nemoto@toshiba-tops.co.jp>
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
X-archive-position: 10263
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

BTW, I wonder if current code (with or without this patch) works
properly for physically indexed cache.  Though I do not know if there
were physically indexed icache, there are certainly physically indexed
dcache (ex. MIPS 20KC).

For those physically indexed caches, we should use 'pfn' argument
passed to flush_cache_page ?

---
Atsushi Nemoto
