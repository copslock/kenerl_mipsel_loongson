Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jul 2005 04:29:18 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:42245
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8226306AbVGFD3C>; Wed, 6 Jul 2005 04:29:02 +0100
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 6 Jul 2005 03:29:20 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id B6B721F2F9;
	Wed,  6 Jul 2005 12:29:13 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id A32C21F261;
	Wed,  6 Jul 2005 12:29:13 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j663TCoj038386;
	Wed, 6 Jul 2005 12:29:13 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 06 Jul 2005 12:29:12 +0900 (JST)
Message-Id: <20050706.122912.71087098.nemoto@toshiba-tops.co.jp>
To:	ralf@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, djohnson+linuxmips@sw.starentnetworks.com,
	linux-mips@linux-mips.org
Subject: Re: preempt_schedule_irq missing from mfinfo[]?
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20050705200308.GE18772@linux-mips.org>
References: <17093.19241.353160.946039@cortez.sw.starentnetworks.com>
	<20050703.005921.25910131.anemo@mba.ocn.ne.jp>
	<20050705200308.GE18772@linux-mips.org>
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
X-archive-position: 8359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 5 Jul 2005 21:03:09 +0100, Ralf Baechle DL5RB <ralf@linux-mips.org> said:
ralf> If the WCHAN column of ps axl is supposed to be any useful we
ralf> need to unwind the stack until we find the caller of the
ralf> sleeping or scheduling function.  Very useful for debugging.

Yes, but many sleeping/scheduling (such as schedule_timeout(),
__down(), etc.)  are compiled without -fno-omit-frame-pointer, so
you can not find the caller of such functions anyway.

And some sleeping/scheduling functions which are compiled with
-fno-omit-frame-pointer are static or deprecated (sleep_on(), etc.)

You can find the caller of "schedule()" even with simple
thread_saved_pc().  I think it is enough so I do not think it is worth
to fix (and maintain) current minfo[].

---
Atsushi Nemoto
