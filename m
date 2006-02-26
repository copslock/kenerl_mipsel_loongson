Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Feb 2006 13:58:30 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:57038 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133409AbWBZN6U (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 26 Feb 2006 13:58:20 +0000
Received: from localhost (p3082-ipad31funabasi.chiba.ocn.ne.jp [221.189.127.82])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 04B78B56B; Sun, 26 Feb 2006 23:05:47 +0900 (JST)
Date:	Sun, 26 Feb 2006 23:05:41 +0900 (JST)
Message-Id: <20060226.230541.75185772.anemo@mba.ocn.ne.jp>
To:	zzh.hust@gmail.com
Cc:	linux-mips@linux-mips.org
Subject: Re: bogus packet in ei_receive of 8390.c
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <50c9a2250602251831n27d11b5ar7a309c9716a8683a@mail.gmail.com>
References: <50c9a2250602251831n27d11b5ar7a309c9716a8683a@mail.gmail.com>
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
X-archive-position: 10649
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Sun, 26 Feb 2006 10:31:44 +0800, zhuzhenhua <zzh.hust@gmail.com> said:

zzh> i use a rtl8019as ethernet card for my board, and now the driver
zzh> can boot up with nfs root, it also can run helloworld via nfs,
zzh> but if i run a big application,or something like vi, it will get
zzh> messages like that "eth0: bogus packet: status=0x0 nxpg=0x65
zzh> size=102" and i find it is in ei_receive of 8390.c caused by
zzh> uncorrect status of receive in the 8390_hdr, does someone meet
zzh> this situation?  what may cause this? hardware or uncorrect
zzh> driver?

Though I do now know what is wrong, here is some general considerations:

RTL8019AS has 8bit mode and 16bit mode.  Does your driver select right
mode (ei_status.word16) ?

And if your RTL8019AS is running in 8bit mode, PSTOP (Page Stop)
register should not exceed to 0x60 (please refer detasheet available
from www.realtek.com.tw).  Check your driver's PSTOP value.

Also, it would be worth checking your ISA-like bus is correctly
configured.  Bus-width, clock, wait-cycles, setup/hold time, etc.

---
Atsushi Nemoto
