Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Mar 2008 09:41:30 +0000 (GMT)
Received: from host194-211-dynamic.20-79-r.retail.telecomitalia.it ([79.20.211.194]:38889
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S28599305AbYCQJl2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Mar 2008 09:41:28 +0000
Received: from router-wag54gp2 ([192.168.1.33] helo=[192.168.2.7])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1JbBqJ-0004Hl-Mq
	for linux-mips@linux-mips.org; Mon, 17 Mar 2008 10:41:21 +0100
Subject: unexpected irq 71 on ip32
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Mon, 17 Mar 2008 10:41:44 +0100
Message-Id: <1205746904.3515.37.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Hi all,
since 2.6.24 I find this message on the console. The message is
displayed very randomly (or, I cannot find any related event), once or
twice a week.

irq 71, desc: ffffffff803fccf0, depth: 1, count: 0, unhandled: 0
->handle_irq():  ffffffff80069510, handle_bad_irq+0x0/0x2c0
->chip(): ffffffff803f6610, 0xffffffff803f6610
->action(): 0000000000000000
  IRQ_DISABLED set
   IRQ_NOPROBE set

from what I understand, this is an irq related to serial line ttyS1. On
this line I have a modem managed by hylafax, but those messages are
displayed even when there is no activity on the modem line.

Bye,
Giuseppe
