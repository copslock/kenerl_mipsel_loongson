Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Sep 2004 08:40:38 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:9508
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8224841AbUIXHkd>; Fri, 24 Sep 2004 08:40:33 +0100
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 24 Sep 2004 07:40:31 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 25763239E1D; Fri, 24 Sep 2004 16:43:05 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id i8O7eN8G073799;
	Fri, 24 Sep 2004 16:40:24 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Fri, 24 Sep 2004 16:39:23 +0900 (JST)
Message-Id: <20040924.163923.98854911.nemoto@toshiba-tops.co.jp>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: Re: gcc 3.3.4/3.4.1 and get_user
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20040920171021.GA25371@linux-mips.org>
References: <87656yqsmz.fsf@redhat.com>
	<20040920154042.GB5150@linux-mips.org>
	<20040920171021.GA25371@linux-mips.org>
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
X-archive-position: 5878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Mon, 20 Sep 2004 19:10:21 +0200, Ralf Baechle <ralf@linux-mips.org> said:
ralf> And here the same for 2.4.  Actually this is a straight backport
ralf> of the 2.6 uaccess.h to 2.4 so with this patch
ralf> include/asm-mips/uaccess.h and include/asm-mips64/uaccess.h are
ralf> going to be identical.

This also fixes long standing bug in 2.4 mips64 __ua_size macro.  Thank you.

There is still an another problem in 64-bit __access_ok (both 2.4 and
2.6).

The __access_ok for 64-bit kernel returns 0 if 'addr' + 'size' ==
TASK_SIZE (which should be OK).

#define __access_ok(addr, size, mask)					\
	(((signed long)((mask) & ((addr) | ((addr) + (size)) | __ua_size(size)))) == 0)

I think this should be:

#define __access_ok(addr, size, mask)					\
	(((signed long)((mask) & ((addr) | ((addr) + (size) - 1) | __ua_size(size)))) == 0)

This fix is needed for 64-bit native mount syscall (which try to read
variable length string parameters from user stack.  See
fs/namespace.c:copy_mount_options).

This fix also makes __access_ok(0, 0, __access_mask) return 0, but
pointer 0 is invalid anyway.

---
Atsushi Nemoto
