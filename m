Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Oct 2003 06:43:07 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:59398
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225208AbTJBFmf>; Thu, 2 Oct 2003 06:42:35 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for [62.254.210.162]) with SMTP; 2 Oct 2003 05:42:33 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h925gNgc014467
	for <linux-mips@linux-mips.org>; Thu, 2 Oct 2003 14:42:24 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Thu, 02 Oct 2003 14:45:08 +0900 (JST)
Message-Id: <20031002.144508.122621824.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org
Subject: time(2) for mips64
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Should mips64 kernel support time(2) system call for n32/n64 ABI?

Both 2.4 and 2.6 kernel define __NR_time and use sys_time.  But
sys_time in kernel/time.c is not 64-bit clean.

We should remove definition of __NR_time from unistd.h (and sys_time
from scall_64.S), or implement local version of sys_time.

Which way to go?
---
Atsushi Nemoto
