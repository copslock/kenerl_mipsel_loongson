Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Mar 2008 14:36:17 +0000 (GMT)
Received: from [79.20.211.194] ([79.20.211.194]:61839 "EHLO
	eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S28651396AbYCIOgP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 9 Mar 2008 14:36:15 +0000
Received: from localhost ([127.0.0.1] helo=sgi)
	by eppesuigoccas.homedns.org with smtp (Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1JYMd7-00023d-41
	for linux-mips@linux-mips.org; Sun, 09 Mar 2008 15:36:03 +0100
Date:	Sun, 9 Mar 2008 15:35:59 +0100
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
Subject: How to find source of a panic event?
Message-Id: <20080309153559.2d58c9f5.giuseppe@eppesuigoccas.homedns.org>
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; mips-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Hi all,
I am testing new kernels on a spare O2. Since I see some strange behaviour, I would like to ask you for a comment on this subject.

What happens is that when the kernel is loaded and then started, the led immediately start blinking red/green and the machine power off after 120 seconds.

Looking at arch/mips/sgi-ip32/ip32-reset.c I found that when setting up the system, a new interrupt is requested, MACEISA_RTC_IRQ, and a notifier_block structure is setup in order to be used when a panic action is triggered. When this happens, the panic action uses the interrupt to wait two minutes and power off the machine.

So I wonder how to find the source calling this panic_action.

Thanks to all,
Giuseppe
