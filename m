Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Feb 2007 15:44:56 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:10743 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038909AbXBPPou (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 16 Feb 2007 15:44:50 +0000
Received: from localhost (p2199-ipad213funabasi.chiba.ocn.ne.jp [124.85.67.199])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP id 8C5C6AAD4
	for <linux-mips@linux-mips.org>; Sat, 17 Feb 2007 00:43:29 +0900 (JST)
Date:	Sat, 17 Feb 2007 00:43:29 +0900 (JST)
Message-Id: <20070217.004329.108739438.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Subject: fadvise on MIPS
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
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
X-archive-position: 14120
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

I found some confusions about posix_fadvise() on MIPS.

1) unistd.h defines __NR_fadvise64 for all ABI but no
__NR_fadvise64_64.  But sys_fadvise64_64 is used for all syscall
entries.  For N64, sys_fadvise64 and sys_fadvise64_64 are same so no
problem, but for other ABIs size of 'len' argument cause mismatch
between kernel and libc.

2) On O32, glibc pass a 'long long' argument by hi and lo words, but
kernel needs padding word between 'fd' and 'offset' argument.

3) On N32, glibc pass a 'long long' argument by hi and lo words, but
kernel expects a single register value for 'long long' argument.

4) __ARCH_WANT_SYS_FADVISE64 is defined in unistd.h but sys_fadvise64
is not used.

What is preferred way to fix those issues?

It seems N64 do not need any fix.

For N32 and O32, kernel should be fixed anyway, but which syscall
should be supported?  And whether kernel or libc should take care of
'long long' issue?

---
Atsushi Nemoto
