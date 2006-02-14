Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2006 10:06:08 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:36046 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133421AbWBNKF6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Feb 2006 10:05:58 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Tue, 14 Feb 2006 19:12:18 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id CD5C4200BA;
	Tue, 14 Feb 2006 19:12:15 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id C0DE31F4B9;
	Tue, 14 Feb 2006 19:12:15 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k1EACF4D076129;
	Tue, 14 Feb 2006 19:12:15 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 14 Feb 2006 19:12:15 +0900 (JST)
Message-Id: <20060214.191215.115641299.nemoto@toshiba-tops.co.jp>
To:	yoichi_yuasa@tripeaks.co.jp
Cc:	anemo@mba.ocn.ne.jp, linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] fix cache coherency issues
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <200602140856.k1E8uvm1021728@mbox03.po.2iij.net>
References: <200602140707.k1E77Tah013064@mbox00.po.2iij.net>
	<20060214.164216.48797359.nemoto@toshiba-tops.co.jp>
	<200602140856.k1E8uvm1021728@mbox03.po.2iij.net>
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
X-archive-position: 10454
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 14 Feb 2006 17:56:57 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> said:
yuasa> This patch fixed the boot problem, but the kernel still has
yuasa> cache coherency problem.

yuasa> ~# ./cachetest 
yuasa> Test separation: 4096 bytes: FAIL - cache not coherent

Thank you for testing.

As for the cachetest program, I think the test program is wrong.

It try to mmap offset 0 of a shared file to odd address page with
MAP_FIXED.  It means "I want non-coherent mapping if dcache alias
exists".  Currently the kernel surely gives what the program want.

The kernel might have to return EINVAL in such case, but I'm not sure
which is the right behavior.  Please look at David S. Miller's
comments, for example, http://lkml.org/lkml/2003/9/1/48

---
Atsushi Nemoto
