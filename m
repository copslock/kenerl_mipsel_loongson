Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Nov 2008 16:17:57 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:63460 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S23793098AbYKTQRo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Nov 2008 16:17:44 +0000
Received: from localhost (p2225-ipad206funabasi.chiba.ocn.ne.jp [222.145.76.225])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 42A9DAEC5; Fri, 21 Nov 2008 01:17:39 +0900 (JST)
Date:	Fri, 21 Nov 2008 01:17:44 +0900 (JST)
Message-Id: <20081121.011744.103777651.anemo@mba.ocn.ne.jp>
To:	alessandro.zummo@towertech.it
Cc:	rtc-linux@googlegroups.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [rtc-linux] [PATCH 3/4] rtc: Add rtc-tx4939 driver
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20081120164533.73ba1f7f@i1501.lan.towertech.it>
References: <1227194815-16200-1-git-send-email-anemo@mba.ocn.ne.jp>
	<20081120164533.73ba1f7f@i1501.lan.towertech.it>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 20 Nov 2008 16:45:33 +0100, Alessandro Zummo <alessandro.zummo@towertech.it> wrote:
> > +struct tx4939rtc_plat_data {
> > +	struct rtc_device *rtc;
> > +	struct tx4939_rtc_reg __iomem *rtcreg;
> > +	spinlock_t lock;
> > +};
> 
>  is the additional lock necessary?

It is used to protect sysfs nvram access from rtc ops.

Hm, can I use rtc->ops_lock in sysfs read/write routine to achieve it?


I will address all other issues.  Thanks.

---
Atsushi Nemoto
