Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Oct 2004 13:16:21 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:33554
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8224837AbUJDMQR>; Mon, 4 Oct 2004 13:16:17 +0100
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 4 Oct 2004 12:16:16 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 714AD239E39; Mon,  4 Oct 2004 21:18:53 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id i94CG78G017169;
	Mon, 4 Oct 2004 21:16:08 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Mon, 04 Oct 2004 21:15:04 +0900 (JST)
Message-Id: <20041004.211504.03974923.nemoto@toshiba-tops.co.jp>
To: jsun@mvista.com
Cc: wsonguci@yahoo.com, linux-mips@linux-mips.org
Subject: Re: 2.6 preemptive kernel on mips
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20040803124048.C1926@mvista.com>
References: <20040803192244.5889.qmail@web40002.mail.yahoo.com>
	<20040803124048.C1926@mvista.com>
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
X-archive-position: 5931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 3 Aug 2004 12:40:48 -0700, Jun Sun <jsun@mvista.com> said:
jsun> Try the latest kernel.  I checked preemption around 2.6.5 time
jsun> and I believe all the obvious problems are fixed then.

Hi.  Now I'm looking current (2.6.9-rc1) code.

It lacks some preempt_disable/preempt_enable which were in
preempt-patch for 2.4 kernel.  Are these all unnecessary at all?

For example, fpu-emulation is not preemptive-safe, isn't it?

---
Atsushi Nemoto
