Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Oct 2004 02:39:22 +0100 (BST)
Received: from [IPv6:::ffff:202.230.225.5] ([IPv6:::ffff:202.230.225.5]:3864
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8224858AbUJRBjR>; Mon, 18 Oct 2004 02:39:17 +0100
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 18 Oct 2004 01:39:15 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 6D4FD239E43; Mon, 18 Oct 2004 10:38:43 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id i9I1cg3i027457;
	Mon, 18 Oct 2004 10:38:43 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Mon, 18 Oct 2004 10:37:37 +0900 (JST)
Message-Id: <20041018.103737.74754888.nemoto@toshiba-tops.co.jp>
To: macro@mips.com
Cc: linux-mips@linux-mips.org, libc-alpha@sources.redhat.com,
	dom@mips.com, nigel@mips.com, macro@linux-mips.org
Subject: Re: [patch] glibc 2.3: Memory clobber missing from syscalls
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.61.0410151318550.8084@perivale.mips.com>
References: <Pine.LNX.4.61.0410151318550.8084@perivale.mips.com>
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
X-archive-position: 6077
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 15 Oct 2004 13:47:59 +0100 (BST), "Maciej W. Rozycki" <macro@mips.com> said:
macro>  It seems nobody at the libc-alpha list is intersted in this
macro> fix, so I'm sending it here, so that people do not struggle
macro> against weird failures, while a fix is already done.  The fix
macro> is needed for the current version of glibc.

Then, kernel header (include/asm-mips/unistd.h) should be fixed too?

It includes some asm statements like this:

	__asm__ volatile ( \
	".set\tnoreorder\n\t" \
	"li\t$2, %2\t\t\t# " #name "\n\t" \
	"syscall\n\t" \
	"move\t%0, $2\n\t" \
	".set\treorder" \
	: "=&r" (__v0), "=r" (__a3) \
	: "i" (__NR_##name) \
	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \

---
Atsushi Nemoto
