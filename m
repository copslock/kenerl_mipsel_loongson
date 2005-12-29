Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Dec 2005 16:31:48 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:60646 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133523AbVL2Qba (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 29 Dec 2005 16:31:30 +0000
Received: from localhost (p1122-ipad201funabasi.chiba.ocn.ne.jp [222.146.64.122])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 9ECE48C89; Fri, 30 Dec 2005 01:33:20 +0900 (JST)
Date:	Fri, 30 Dec 2005 01:32:42 +0900 (JST)
Message-Id: <20051230.013242.74752856.anemo@mba.ocn.ne.jp>
To:	sshtylyov@dev.rtsoft.ru
Cc:	rmk@arm.linux.org.uk, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] serial_txx9: forcibly init the spinlock for PCI UART
 used as a console
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20051228.132544.96684396.nemoto@toshiba-tops.co.jp>
References: <43B18DD2.3090206@ru.mvista.com>
	<43B196A9.8010608@dev.rtsoft.ru>
	<20051228.132544.96684396.nemoto@toshiba-tops.co.jp>
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
X-archive-position: 9752
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 28 Dec 2005 13:25:44 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:

anemo> * The uart_console() returns 1 even if the console was not
anemo> successfully configured (CON_ENABLED was not set and spinlock
anemo> did not initialized).  So uart_add_one_port() does not
anemo> initialize the spinlock for the console.

This is same for the 8250 driver which also can handle PCI and legacy
ports.

The 8250 driver is working correctly just because
serial8250_isa_init_ports() initializes all spinlocks.  If this way a
right way, spin_lock_init() in uart_add_one_port() seems redundant...

---
Atsushi Nemoto
