Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Feb 2006 02:03:05 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:46524 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133593AbWB0CCt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Feb 2006 02:02:49 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Mon, 27 Feb 2006 11:10:23 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id DB60220539;
	Mon, 27 Feb 2006 11:10:20 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id D0E7320533;
	Mon, 27 Feb 2006 11:10:20 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k1R2AK4D040080;
	Mon, 27 Feb 2006 11:10:20 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 27 Feb 2006 11:10:20 +0900 (JST)
Message-Id: <20060227.111020.74752419.nemoto@toshiba-tops.co.jp>
To:	zzh.hust@gmail.com
Cc:	linux-mips@linux-mips.org
Subject: Re: bogus packet in ei_receive of 8390.c
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <50c9a2250602261729q543eb515hff7af85153ac779@mail.gmail.com>
References: <50c9a2250602251831n27d11b5ar7a309c9716a8683a@mail.gmail.com>
	<20060226.230541.75185772.anemo@mba.ocn.ne.jp>
	<50c9a2250602261729q543eb515hff7af85153ac779@mail.gmail.com>
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
X-archive-position: 10651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Mon, 27 Feb 2006 09:29:23 +0800, zhuzhenhua <zzh.hust@gmail.com> said:
zzh> our board is a FPGA board for embedded system, there is no ISA,
zzh> and use memory map IO, is there anything need to configure?

Even if it is not true ISA, your FPGA should drive ISA-like signals
for the chip.  AC timings of these signals should meet the
requirements of the chip.  I do not know they are configurable or not.
Do cross-check the 8019 datasheet and the FPGA specification.

zzh> now i printk the ISR and RSR value when bogus packet accepted,
zzh> are these two registers correct? messages as follow

It seems correct.  So it would be something wrong with get_8390_hdr ...

---
Atsushi Nemoto
