Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Oct 2005 15:23:49 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:34007 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S3465558AbVJSOXd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 19 Oct 2005 15:23:33 +0100
Received: from localhost (p1208-ipad207funabasi.chiba.ocn.ne.jp [222.145.83.208])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 82629A5DD; Wed, 19 Oct 2005 23:23:29 +0900 (JST)
Date:	Wed, 19 Oct 2005 23:22:22 +0900 (JST)
Message-Id: <20051019.232222.59465169.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: Fix zero length sys_cacheflush
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20051019132902.GE2616@linux-mips.org>
References: <20051019.195714.89066462.nemoto@toshiba-tops.co.jp>
	<20051019132902.GE2616@linux-mips.org>
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
X-archive-position: 9270
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 19 Oct 2005 14:29:02 +0100, Ralf Baechle <ralf@linux-mips.org> said:

>> I found cacheflush(0, 0, 0) will crash the system.
>> 
>> This is because flush_icache_range(start, end) tries to flushing
>> whole address space (0 - ffffffff) if both start and end are zero
>> (at least in c-r4k.c).

ralf> Applied,

Thanks.

BTW, sparse complains for this "unsigned long __user addr".

asmlinkage int sys_cacheflush(unsigned long __user addr,
	unsigned long bytes, unsigned int cache)

/work/git/linux-mips/arch/mips/mm/cache.c:59:7: warning: dereference of noderef expression

I suppose the "unsigned long __user addr" means that the "addr"
variable itself is an userspace object.  So its usage is wrong, isn't
it?

---
Atsushi Nemoto
