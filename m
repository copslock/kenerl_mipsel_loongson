Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2007 08:53:34 +0100 (BST)
Received: from topsns2.0.225.230.202.in-addr.arpa ([202.230.225.126]:49480
	"EHLO topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20022690AbXFGHxc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Jun 2007 08:53:32 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 7 Jun 2007 16:53:30 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 6252241DF3;
	Thu,  7 Jun 2007 16:53:02 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 4DEC520457;
	Thu,  7 Jun 2007 16:53:02 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l577r1AF049544;
	Thu, 7 Jun 2007 16:53:02 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 07 Jun 2007 16:53:01 +0900 (JST)
Message-Id: <20070607.165301.63743560.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: smp_mb() in asm-mips/bitops.h
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15315
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

I found some funny usages of smp_mb() in asm-mips/bitops.h:

static inline int test_and_set_bit(unsigned long nr,
	volatile unsigned long *addr)
{
	if (cpu_has_llsc && R10000_LLSC_WAR) {
...
		return res != 0;
	} else if (cpu_has_llsc) {
...
		return res != 0;
	} else {
...
		return retval;
	}

	smp_mb();
}

It looks this smp_mb() never have any effects.  This change is from:

> commit 0004a9dfeaa709a7f853487aba19932c9b1a87c8
> Author: Ralf Baechle <ralf@linux-mips.org>
> Date:   Tue Oct 31 03:45:07 2006 +0000
> 
>     [MIPS] Cleanup memory barriers for weakly ordered systems.

at 2.6.18 development cycle.

---
Atsushi Nemoto
