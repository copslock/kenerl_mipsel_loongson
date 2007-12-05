Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Dec 2007 16:08:11 +0000 (GMT)
Received: from rtsoft3.corbina.net ([85.21.88.6]:6428 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S20025455AbXLEQIB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Dec 2007 16:08:01 +0000
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id D383F8816; Wed,  5 Dec 2007 21:07:59 +0400 (SAMT)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	ralf@linux-mips.org
Subject: [PATCH 0/2] Alchemy: fix interrupt routing
Date:	Wed, 5 Dec 2007 19:08:18 +0300
User-Agent: KMail/1.5
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200712051908.18780.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17700
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

   The two following patches together fix the interrupt routing currently broken
and causing boot failure with such messages:

unexpected IRQ # 8
irq 8, desc: 80406dd0, depth: 1, count: 0, unhandled: 0
->handle_irq():  80157d70, handle_bad_irq+0x0/0x38c
->chip(): 804016d0, 0x804016d0
->action(): 00000000
  IRQ_DISABLED set

   The patches are against the Linus' tree...

WBR, Sergei
