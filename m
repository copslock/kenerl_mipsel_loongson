Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2003 13:07:44 +0100 (BST)
Received: from inspiration-98-179-ban.inspiretech.com ([IPv6:::ffff:203.196.179.98]:50059
	"EHLO smtp.inspirtek.com") by linux-mips.org with ESMTP
	id <S8225072AbTDHMHl>; Tue, 8 Apr 2003 13:07:41 +0100
Received: from mail.inspiretech.com (mail.inspiretech.com [150.1.1.1])
	by smtp.inspirtek.com (8.12.5/8.12.5) with ESMTP id h38CBgf6024962
	for <linux-mips@linux-mips.org>; Tue, 8 Apr 2003 17:41:48 +0530
Message-Id: <200304081211.h38CBgf6024962@smtp.inspirtek.com>
Received: from WorldClient [150.1.1.1] by inspiretech.com [150.1.1.1]
	with SMTP (MDaemon.v3.5.7.R)
	for <linux-mips@linux-mips.org>; Tue, 08 Apr 2003 17:27:24 +0530
Date: Tue, 08 Apr 2003 17:27:23 +0530
From: "Avinash S." <avinash.s@inspiretech.com>
To: "linux" <linux-mips@linux-mips.org>
Subject: printk problems
X-Mailer: WorldClient Standard 3.5.0e
X-MDRemoteIP: 150.1.1.1
X-Return-Path: avinash.s@inspiretech.com
X-MDaemon-Deliver-To: linux-mips@linux-mips.org
Return-Path: <avinash.s@inspiretech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: avinash.s@inspiretech.com
Precedence: bulk
X-list: linux-mips

Hello,
I am trying to port linux to a custom built IDT MIPS board. I have 
managed to get the UART working. My bootup code loads and prints some 
debugging messages initially and then actual kernel bootup occurs. 
However it hangs when it reaches the first printk function. i have tried 
to debug this with some difficulty but with no effect. Could some one 
tell me or atleast point me to where i can get some info on how printk 
works or atleast how to debug my printk to see where the actual problem 
lies?

Thanks in advance.


Avinash
