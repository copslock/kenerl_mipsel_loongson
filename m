Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Aug 2008 14:10:16 +0100 (BST)
Received: from kuber.nabble.com ([216.139.236.158]:38124 "EHLO
	kuber.nabble.com") by ftp.linux-mips.org with ESMTP
	id S20023701AbYHENKK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 5 Aug 2008 14:10:10 +0100
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1KQMIi-0006cn-Gd
	for linux-mips@linux-mips.org; Tue, 05 Aug 2008 06:10:08 -0700
Message-ID: <18830812.post@talk.nabble.com>
Date:	Tue, 5 Aug 2008 06:10:08 -0700 (PDT)
From:	TriKri <kristoferkrus@hotmail.com>
To:	linux-mips@linux-mips.org
Subject: Debugging MIPS cpu with a probe, how?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: kristoferkrus@hotmail.com
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20103
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kristoferkrus@hotmail.com
Precedence: bulk
X-list: linux-mips


Hello!

I have an embedded system, a box, with a MIPS processor on it, which I need
to debug (stop and start the processor, tell what instructions it has
previously executed, etc.). I also have an EJTAG probe, which I have
connected between the computer's usb and the box, and written software for
it. The software can communicate with the probe, which in its own turn can
communicate with the box through the tap (test access port), by giving the
tap certain instructions. It can also, through the tap, feed the MIPS
processor with instructions, and read/write data from processor registers.

The question is now, how can debug the processor? How do I stop it, do I
have to send any certain instructions to it? How can I set a breakpoint
(which I understand is a quite crucial point)? Can I use GDB with my
software to help debug the processor and how do I do that?

Thank you in advance!
/Kristofer Krus
-- 
View this message in context: http://www.nabble.com/Debugging-MIPS-cpu-with-a-probe%2C-how--tp18830812p18830812.html
Sent from the linux-mips main mailing list archive at Nabble.com.
