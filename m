Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Mar 2004 14:01:29 +0000 (GMT)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:36315 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225269AbUCPOB3>; Tue, 16 Mar 2004 14:01:29 +0000
Received: from localhost (p8075-ipad31funabasi.chiba.ocn.ne.jp [221.189.132.75])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id D9E745760; Tue, 16 Mar 2004 23:01:23 +0900 (JST)
Date: Tue, 16 Mar 2004 23:09:28 +0900 (JST)
Message-Id: <20040316.230928.74756852.anemo@mba.ocn.ne.jp>
To: sjhill@realitydiluted.com
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] [RFC] r4k_dma_cache_wback_inv function fails when
 size=0...
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <4055E320.8080808@realitydiluted.com>
References: <4055E320.8080808@realitydiluted.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4545
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Mon, 15 Mar 2004 12:08:48 -0500, "Steven J. Hill" <sjhill@realitydiluted.com> said:

sjhill> The 'r4k_dma_cache_wback_inv' function will fail when the
sjhill> requested size equals 0 AND when the address is a multiple of
sjhill> the line size. I discovered this bug while using the National
sjhill> Semiconductor DP8381x series PCI ethernet driver. I have
sjhill> attached a test program showing the bug as well as a patch for
sjhill> comment. Okay to apply?

I think your patch is overkill.  It flushes many one line then needed.

How about just inserting

	if (unlikely(size == 0))
		return;

in beginning of each function?

---
Atsushi Nemoto
