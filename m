Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Mar 2004 07:38:04 +0100 (BST)
Received: from [IPv6:::ffff:202.230.225.5] ([IPv6:::ffff:202.230.225.5]:2058
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225215AbUC3GiD>; Tue, 30 Mar 2004 07:38:03 +0100
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 30 Mar 2004 06:38:02 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 9E2A1239E79; Tue, 30 Mar 2004 15:39:09 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id i2U6blwB066793;
	Tue, 30 Mar 2004 15:37:48 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Tue, 30 Mar 2004 15:38:43 +0900 (JST)
Message-Id: <20040330.153842.48794669.nemoto@toshiba-tops.co.jp>
To: pdh@colonel-panic.org
Cc: phorton@bitbox.co.uk, linux-mips@linux-mips.org
Subject: Re: missing flush_dcache_page call in 2.4 kernel
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20040328130400.GA28177@skeleton-jack>
References: <20040326184317.GA3661@skeleton-jack>
	<20040327.224952.74755860.anemo@mba.ocn.ne.jp>
	<20040328130400.GA28177@skeleton-jack>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4689
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Sun, 28 Mar 2004 14:04:00 +0100, Peter Horton <pdh@colonel-panic.org> said:
pdh> I've ditched the original Cobalt hack in c-r4k.c, and am using
pdh> the patch below instead. Seems to work okay ...

+	for (; addr < (void *) end; addr += PAGE_SIZE)
+		flush_data_cache_page((unsigned long) addr);

dma_cache_wback() will be more efficient ?

Also, I personally think replacing all insb/insw/insl is a bit
overkill.  I'd prefer redefine insb/insw/insl in asm-mips/ide.h, but
I'm not sure it is enough. (really all ins[bwl] should take care of
the cache inconsistency?)

---
Atsushi Nemoto
