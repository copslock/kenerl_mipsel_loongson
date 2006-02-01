Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Feb 2006 16:33:22 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:38870 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S3458482AbWBAQdD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Feb 2006 16:33:03 +0000
Received: from localhost (p6192-ipad212funabasi.chiba.ocn.ne.jp [58.91.170.192])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 38357A41A; Thu,  2 Feb 2006 01:38:07 +0900 (JST)
Date:	Thu, 02 Feb 2006 01:37:46 +0900 (JST)
Message-Id: <20060202.013746.36924107.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [PATCH] local_r4k_flush_cache_page fix
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060201.153154.108306076.nemoto@toshiba-tops.co.jp>
References: <20060201.000356.25911337.anemo@mba.ocn.ne.jp>
	<20060201.153154.108306076.nemoto@toshiba-tops.co.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10284
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 01 Feb 2006 15:31:54 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:

anemo> BTW, I wonder if current code (with or without this patch)
anemo> works properly for physically indexed cache.  Though I do not
anemo> know if there were physically indexed icache, there are
anemo> certainly physically indexed dcache (ex. MIPS 20KC).

anemo> For those physically indexed caches, we should use 'pfn'
anemo> argument passed to flush_cache_page ?

I'm thinking of introducing MIPS_CACHE_PINDEX and 'cpu_has_pindex_dcache'.

I guess secondary cache is also physically indexed.  Is there any
virtually indexed secondary cache ?

---
Atsushi Nemoto
