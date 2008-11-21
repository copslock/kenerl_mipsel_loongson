Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Nov 2008 03:39:33 +0000 (GMT)
Received: from fwtops.0.225.230.202.in-addr.arpa ([202.230.225.126]:14172 "EHLO
	topsms.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S23804121AbYKUDjV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Nov 2008 03:39:21 +0000
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 5367B1D924;
	Fri, 21 Nov 2008 12:37:02 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 483C81D907;
	Fri, 21 Nov 2008 12:37:02 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id mAL3cunf049061;
	Fri, 21 Nov 2008 12:39:01 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 21 Nov 2008 12:38:56 +0900 (JST)
Message-Id: <20081121.123856.112816526.nemoto@toshiba-tops.co.jp>
To:	alessandro.zummo@towertech.it
Cc:	rtc-linux@googlegroups.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [rtc-linux] [PATCH 3/4] rtc: Add rtc-tx4939 driver
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20081120172138.2de2da58@i1501.lan.towertech.it>
References: <20081120164533.73ba1f7f@i1501.lan.towertech.it>
	<20081121.011744.103777651.anemo@mba.ocn.ne.jp>
	<20081120172138.2de2da58@i1501.lan.towertech.it>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 6.1 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 20 Nov 2008 17:21:38 +0100, Alessandro Zummo <alessandro.zummo@towertech.it> wrote:
> > It is used to protect sysfs nvram access from rtc ops.
> > 
> > Hm, can I use rtc->ops_lock in sysfs read/write routine to achieve it?
> 
>  it should be doable, rtc-ds1305 uses it

But ops_lock is mutex, so it cannot protect from an interrupt handler.
I will try rtc->irq_lock.

---
Atsushi Nemoto
