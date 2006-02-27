Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Feb 2006 13:33:25 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:50147 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133487AbWB0NdR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 27 Feb 2006 13:33:17 +0000
Received: from localhost (p7028-ipad211funabasi.chiba.ocn.ne.jp [58.91.163.28])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 3758FAF92; Mon, 27 Feb 2006 22:40:51 +0900 (JST)
Date:	Mon, 27 Feb 2006 22:40:45 +0900 (JST)
Message-Id: <20060227.224045.93021902.anemo@mba.ocn.ne.jp>
To:	zzh.hust@gmail.com
Cc:	linux-mips@linux-mips.org
Subject: Re: bogus packet in ei_receive of 8390.c
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <50c9a2250602261910t2241cd14ue877361310e29136@mail.gmail.com>
References: <50c9a2250602261729q543eb515hff7af85153ac779@mail.gmail.com>
	<20060227.111020.74752419.nemoto@toshiba-tops.co.jp>
	<50c9a2250602261910t2241cd14ue877361310e29136@mail.gmail.com>
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
X-archive-position: 10660
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Mon, 27 Feb 2006 11:10:50 +0800, zhuzhenhua <zzh.hust@gmail.com> said:

>> Even if it is not true ISA, your FPGA should drive ISA-like signals
>> for the chip.  AC timings of these signals should meet the
>> requirements of the chip.  I do not know they are configurable or
>> not.  Do cross-check the 8019 datasheet and the FPGA specification.

zzh> the ethernet just use the sram interface to control IO

So you can check the sram interface's timing satisfy the ethernet
chip's AC timings.  I have no more idea ...

---
Atsushi Nemoto
