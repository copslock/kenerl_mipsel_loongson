Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Feb 2005 12:06:05 +0000 (GMT)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:26831 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225072AbVBEMFu>; Sat, 5 Feb 2005 12:05:50 +0000
Received: from localhost (p3087-ipad30funabasi.chiba.ocn.ne.jp [221.184.78.87])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 21416839F; Sat,  5 Feb 2005 21:05:47 +0900 (JST)
Date:	Sat, 05 Feb 2005 21:06:48 +0900 (JST)
Message-Id: <20050205.210648.126573633.anemo@mba.ocn.ne.jp>
To:	jsun@junsun.net
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: dcache aliasing problem on fork
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20050204174410.GC30430@gw.junsun.net>
References: <20050204.183813.132760959.nemoto@toshiba-tops.co.jp>
	<20050204174410.GC30430@gw.junsun.net>
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
X-archive-position: 7159
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 4 Feb 2005 09:44:10 -0800, Jun Sun <jsun@junsun.net> said:

jsun> It seems to me a naive solution is to introduce a spinlock to
jsun> make all three operation automic.  you flush tlb first and make
jsun> relavent tlb fault handling sync with this spinlock as well.

jsun> At in theory it should fix the problem, but the spinlock might
jsun> be held for too long this dup_mmap().

Yes, it may be too long.  Also dup_mmap might sleep via alloc_pages,
cond_resched_lock, etc. therefore the spinlock can not be held
entirely.  Now I think fixing copy_cow_page() might be a way to go.

jsun> BTW, is this problem real or hypothetic?

Yes.  This is a real problem.  Using fork() in multi-thread program
should be legal and perhaps only way to call external program
(system() will use fork() internally).  It will not be a special case.

---
Atsushi Nemoto
