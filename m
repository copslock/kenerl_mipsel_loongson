Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jul 2008 10:34:48 +0100 (BST)
Received: from mail2.ict.tuwien.ac.at ([128.131.81.21]:6590 "EHLO
	mail.ict.tuwien.ac.at") by ftp.linux-mips.org with ESMTP
	id S20044857AbYGHJej (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 Jul 2008 10:34:39 +0100
Received: from pc81-11.ict.tuwien.ac.at ([128.131.81.11])
	by mail.ict.tuwien.ac.at with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <krapfenbauer@ict.tuwien.ac.at>)
	id 1KG9an-0002f4-Il
	for linux-mips@linux-mips.org; Tue, 08 Jul 2008 11:34:37 +0200
Message-ID: <487334AD.70100@ict.tuwien.ac.at>
Date:	Tue, 08 Jul 2008 11:34:37 +0200
From:	Harald Krapfenbauer <krapfenbauer@ict.tuwien.ac.at>
Organization: Institute of Computer Technology, Vienna University of Technology
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
MIME-Version: 1.0
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: 64-bit values on 32-bit machine
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 128.131.81.11
X-SA-Exim-Mail-From: krapfenbauer@ict.tuwien.ac.at
X-SA-Exim-Scanned: No (on mail.ict.tuwien.ac.at); SAEximRunCond expanded to false
Return-Path: <krapfenbauer@ict.tuwien.ac.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: krapfenbauer@ict.tuwien.ac.at
Precedence: bulk
X-list: linux-mips

Hello,

I want to know how 64-bit values are passed on a little-endian 32-bit
MIPS machine on function calls.

If there is one 64-bit argument to a function, it is passed in registers
a0-a1 I think, but does a0 contain the lower 4 bytes or the upper 4?

Similarly, if there are several arguments so that a 64-bit argument is
passed on the stack: Do the lower 4 bytes go to the lower address or to
the higher?

Thanks in advance!
Harald
