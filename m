Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Oct 2006 03:09:09 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:59062 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20038872AbWJWCJH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Oct 2006 03:09:07 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Mon, 23 Oct 2006 11:09:03 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id BF1CF41AEB;
	Mon, 23 Oct 2006 11:09:01 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id B439920438;
	Mon, 23 Oct 2006 11:09:01 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k9N290W0085342;
	Mon, 23 Oct 2006 11:09:01 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 23 Oct 2006 11:09:00 +0900 (JST)
Message-Id: <20061023.110900.96686010.nemoto@toshiba-tops.co.jp>
To:	m_lachwani@yahoo.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] rest of works for migration to GENERIC_TIME
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20061022193958.4188.qmail@web37509.mail.mud.yahoo.com>
References: <20061023.033407.104640794.anemo@mba.ocn.ne.jp>
	<20061022193958.4188.qmail@web37509.mail.mud.yahoo.com>
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
X-archive-position: 13058
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 22 Oct 2006 12:39:58 -0700 (PDT), Manish Lachwani <m_lachwani@yahoo.com> wrote:
> The init_mips_clocksource() call is made via
> module_init(). It does not need to be explicitly
> called in time_init() after plat_timer_setup().

Yes, module_init() can do this, but I have no good reason to use
module_init() here.  Actually x86's hpet.c, i8253.c and tsc.c are
using module_init(), these usages would avoid modifying
i386/kernel/time.c every time new clocksource added.

For MIPS, init_mips_clocksource is generic and live in
mips/kernel/time.c, so I feel calling it directly is good and enough.

---
Atsushi Nemoto
