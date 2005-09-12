Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Sep 2005 03:35:05 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:53026
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225554AbVILCer>; Mon, 12 Sep 2005 03:34:47 +0100
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 12 Sep 2005 02:36:20 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 8D49A1F655;
	Mon, 12 Sep 2005 11:36:18 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 7A0D41F64A;
	Mon, 12 Sep 2005 11:36:18 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j8C2aIoj042837;
	Mon, 12 Sep 2005 11:36:18 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 12 Sep 2005 11:36:17 +0900 (JST)
Message-Id: <20050912.113617.108740043.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: handler_tlb[lsm] not flushed explicitly
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20050715152329Z8226727-3678+3178@linux-mips.org>
References: <20050715152329Z8226727-3678+3178@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 15 Jul 2005 16:23:23 +0100, ralf@linux-mips.org said:
ralf> Modified files:
ralf> 	arch/mips/mm   : c-r4k.c c-tx39.c pg-r4k.c tlbex.c 

ralf> Log message:
ralf> 	Avoid SMP cacheflushes.  This is a minor optimization of startup but
ralf> 	will also avoid smp_call_function from doing stupid things when called
ralf> 	from a CPU that is not yet marked online.

This change removed some flush_icache_range() from tlbex.c.  Now the
refill handler is flushed by last flush_icache_range() in trap_init(),
but it seems handle_tlbl[], handle_tlbs[], handle_tlbm[] are not
explicitly flushed to main memory.

We should call __flush_cache_all() instead of flush_icache_range() in
 trap_init() ?

---
Atsushi Nemoto
