Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Oct 2004 06:00:05 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:35356
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8224908AbUJEFAA>; Tue, 5 Oct 2004 06:00:00 +0100
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 5 Oct 2004 04:59:59 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 258AA239E39; Tue,  5 Oct 2004 14:02:37 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id i954xm8G020375;
	Tue, 5 Oct 2004 13:59:51 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Tue, 05 Oct 2004 13:58:45 +0900 (JST)
Message-Id: <20041005.135845.27956630.nemoto@toshiba-tops.co.jp>
To: jsun@junsun.net
Cc: jsun@mvista.com, wsonguci@yahoo.com, linux-mips@linux-mips.org
Subject: Re: 2.6 preemptive kernel on mips
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20041005000002.GB9718@gateway.junsun.net>
References: <20040803124048.C1926@mvista.com>
	<20041004.211504.03974923.nemoto@toshiba-tops.co.jp>
	<20041005000002.GB9718@gateway.junsun.net>
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
X-archive-position: 5937
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Mon, 4 Oct 2004 17:00:02 -0700, Jun Sun <jsun@junsun.net> said:
>> It lacks some preempt_disable/preempt_enable which were in
>> preempt-patch for 2.4 kernel.  Are these all unnecessary at all?

jsun> They are necessary.

>> For example, fpu-emulation is not preemptive-safe, isn't it?

jsun> That is correct.

jsun> I think the best thing to do right now is to go through 2.4
jsun> preemption patch and pick up the missing ones for 2.6.

Thank you.  I think there are some issue to fix.

1. ll/sc emulation (ll_bit, ll_task).  This is easy to fix.

2. There is an global variable ieee754_csr in math-emu.  This must be
protected by preempt_disable.  But math-emu uses put_user/get_user
which can not be used with preempt disabled.  (Is it true?)

3. save_fp_context/restore_fp_context is not preemptable.  But these
function uses put_user/get_user.


Actually, math-emu/fp_context issues are not only for preemptive
kernel.  I suppose bad things can happen if a process going to sleep
on get_user/put_user in math-emu/save_fp_context/restore_fp_context...

---
Atsushi Nemoto
