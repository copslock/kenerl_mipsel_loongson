Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Jan 2006 18:04:47 +0000 (GMT)
Received: from p549F60EF.dip.t-dialin.net ([84.159.96.239]:24714 "EHLO
	p549F60EF.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S8133479AbWAOSEL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 15 Jan 2006 18:04:11 +0000
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:17645 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.net with SMTP id <S870928AbWALQVR>;
	Thu, 12 Jan 2006 17:21:17 +0100
Received: from localhost (p3016-ipad205funabasi.chiba.ocn.ne.jp [222.146.98.16])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A3D8365E; Fri, 13 Jan 2006 01:19:56 +0900 (JST)
Date:	Fri, 13 Jan 2006 01:19:27 +0900 (JST)
Message-Id: <20060113.011927.75184433.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: QEMU and kernel 2.6.15
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060110153652.GA4871@linux-mips.org>
References: <20060111.002431.93019846.anemo@mba.ocn.ne.jp>
	<20060110153652.GA4871@linux-mips.org>
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
X-archive-position: 9868
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 10 Jan 2006 15:36:52 +0000, Ralf Baechle <ralf@linux-mips.org> said:

ralf> Qemu is still work in progress and needs further debugging.

Do you mean QEMU itself or Qemu port of the kernel?

It looks timer setting in arch/mips/qemu is somewhat broken.

qemu_timer_setup() installs the timer interrupt handler on irq 0, but
do_qemu_int() also calls ll_timer_interrupt() directly.

Which timer interrupt source does the kernel expect?  r4k counter
interrupt or i8259 timer?

---
Atsushi Nemoto
