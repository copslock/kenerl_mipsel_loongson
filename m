Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2006 14:28:56 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:40955 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133839AbWCTO2r (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 20 Mar 2006 14:28:47 +0000
Received: from localhost (p1007-ipad203funabasi.chiba.ocn.ne.jp [222.146.80.7])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 53BA6AADC; Mon, 20 Mar 2006 23:38:23 +0900 (JST)
Date:	Mon, 20 Mar 2006 23:38:29 +0900 (JST)
Message-Id: <20060320.233829.92585823.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	Vadivelan@soc-soft.com, linux-mips@linux-mips.org
Subject: Re: Init not working in 64-bit kernel
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060320131452.GA4491@linux-mips.org>
References: <4BF47D56A0DD2346A1B8D622C5C5902C01525385@soc-mail.soc-soft.com>
	<20060320131452.GA4491@linux-mips.org>
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
X-archive-position: 10882
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Mon, 20 Mar 2006 13:14:52 +0000, Ralf Baechle <ralf@linux-mips.org> said:

ralf> This kernel is already 15 months old and there have been a vast
ralf> number of bug fixes since.  And god knows what Montavista
ralf> changed in their kernel - I don't have the faintest idea.  In
ralf> short, try a modern kernel.  Btw, Linux 2.6.16 was released
ralf> today and chances are it'll solve alot of your issues.

I suppose he is trying 64bit kernel on RBTX4938 board, but the board
dependent code seems not ready for 64bit.  For example, there are some
0xff1fXXXX constants there and all these constants must be sign
extended (0xffffffffff1fXXXX) for 64bit.  Also these virtual address
are mapped to 36bit physical address 0xfff1fXXXX so some assumption in
the 32bit kernel (virt==phys for TX49 internal regs) is not true in
64bit kernel.

---
Atsushi Nemoto
