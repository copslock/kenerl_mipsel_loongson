Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2006 15:02:00 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:55537 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133467AbWDFOBw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 6 Apr 2006 15:01:52 +0100
Received: from localhost (p7200-ipad30funabasi.chiba.ocn.ne.jp [221.184.82.200])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP id CA894AE62
	for <linux-mips@linux-mips.org>; Thu,  6 Apr 2006 23:13:05 +0900 (JST)
Date:	Thu, 06 Apr 2006 23:13:23 +0900 (JST)
Message-Id: <20060406.231323.108307238.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Handle IDE PIO cache aliases on SMP.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <S8133432AbWDETbL/20060405193111Z+63@ftp.linux-mips.org>
References: <S8133432AbWDETbL/20060405193111Z+63@ftp.linux-mips.org>
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
X-archive-position: 11047
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 05 Apr 2006 20:31:05 +0100, linux-mips@linux-mips.org wrote:
> Author: Ralf Baechle <ralf@linux-mips.org> Wed Apr 5 20:42:04 2006 +0100
> Commit: 7310307e37090796c2d343e46dc34b452f0a5d1c
> Gitweb: http://www.linux-mips.org/g/linux/7310307e
> Branch: master

It seems overkill for UP.  How about adding ifdef like this?

static inline void __ide_flush_prologue(void)
{
#ifdef CONFIG_SMP
      if (cpu_has_dc_aliases)
               preempt_disable();
#endif
}

---
Atsushi Nemoto
