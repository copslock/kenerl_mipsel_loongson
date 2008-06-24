Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2008 11:18:45 +0100 (BST)
Received: from mail2.ict.tuwien.ac.at ([128.131.81.21]:43493 "EHLO
	mail.ict.tuwien.ac.at") by ftp.linux-mips.org with ESMTP
	id S20037172AbYFXKSi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Jun 2008 11:18:38 +0100
Received: from pc81-11.ict.tuwien.ac.at ([128.131.81.11])
	by mail.ict.tuwien.ac.at with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <krapfenbauer@ict.tuwien.ac.at>)
	id 1KB5bh-00058y-3O
	for linux-mips@linux-mips.org; Tue, 24 Jun 2008 12:18:37 +0200
Message-ID: <4860C9FD.60103@ict.tuwien.ac.at>
Date:	Tue, 24 Jun 2008 12:18:37 +0200
From:	Harald Krapfenbauer <krapfenbauer@ict.tuwien.ac.at>
Organization: Institute of Computer Technology, Vienna University of Technology
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
MIME-Version: 1.0
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: function call on MIPS (newbie question)
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 128.131.81.11
X-SA-Exim-Mail-From: krapfenbauer@ict.tuwien.ac.at
X-SA-Exim-Scanned: No (on mail.ict.tuwien.ac.at); SAEximRunCond expanded to false
Return-Path: <krapfenbauer@ict.tuwien.ac.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19609
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: krapfenbauer@ict.tuwien.ac.at
Precedence: bulk
X-list: linux-mips

Hi!

I'm a newbie to the MIPS architecture and I want to port some program to
MIPS.
I must call a function within the .text segment with 2 simple
parameters. So I figured out the following code which
*) loads arg1 into register $4
*) loads arg2 into register $5
*) loads the address into $15
*) executes a jalr
*) breaks afterwards


	*((guint32 *)(code)) = ((method_argument1 >> 16) & 0xffff) |
0x3c040000;    /* arg 1 upper half word */
	*((guint32 *)(code+4)) = (method_argument1 & 0xffff) | 0x24040000;
     /* arg 1 lower half word */
	*((guint32 *)(code+8)) = ((method_argument2 >> 16) & 0xffff) |
0x3c050000;  /* arg 2 upper half word */
	*((guint32 *)(code+12)) = (method_argument2 & 0xffff) | 0x24050000;
     /* arg 2 lower half word */
	*((guint32 *)(code+16)) = ((method_address >> 16) & 0xffff) |
0x3c0f0000;   /* address upper half word */
	*((guint32 *)(code+20)) = (method_address & 0xffff) | 0x240f0000;
     /* address lower half word */
	*((guint32 *)(code+24)) = 0x01e0f809;
     /* jalr */
	*((guint32 *)(code+28)) = 0x0;
     /* branch delay slot */
	*((guint32 *)(code+32)) = 0x0d;
     /* breakpoint */



The code is written to the stack, the SP and the PC are then set to the
beginning of the code on the stack.

Something must be going wrong because after the program stops again, the
PC is 0xffffcb38 (The method address is 0x53cb38) and my program
receives signal 10.

Did I miss something or is my code wrong?
Any help appreciated!

Best regards,
Harald Krapfenbauer
