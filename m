Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jul 2008 12:02:29 +0100 (BST)
Received: from mail2.ict.tuwien.ac.at ([128.131.81.21]:65202 "EHLO
	mail.ict.tuwien.ac.at") by ftp.linux-mips.org with ESMTP
	id S28577238AbYGNLC1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Jul 2008 12:02:27 +0100
Received: from pc81-11.ict.tuwien.ac.at ([128.131.81.11])
	by mail.ict.tuwien.ac.at with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <krapfenbauer@ict.tuwien.ac.at>)
	id 1KILp4-0000he-NP
	for linux-mips@linux-mips.org; Mon, 14 Jul 2008 13:02:26 +0200
Message-ID: <487B3242.60202@ict.tuwien.ac.at>
Date:	Mon, 14 Jul 2008 13:02:26 +0200
From:	Harald Krapfenbauer <krapfenbauer@ict.tuwien.ac.at>
Organization: Institute of Computer Technology, Vienna University of Technology
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
MIME-Version: 1.0
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: ptrace question
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 128.131.81.11
X-SA-Exim-Mail-From: krapfenbauer@ict.tuwien.ac.at
X-SA-Exim-Scanned: No (on mail.ict.tuwien.ac.at); SAEximRunCond expanded to false
Return-Path: <krapfenbauer@ict.tuwien.ac.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19815
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: krapfenbauer@ict.tuwien.ac.at
Precedence: bulk
X-list: linux-mips

Hello,

If I write memory (maybe with instructions) of a traced application with
the ptrace() call, are the caches invalidated automatically, i.e. can I
assume that the processor uses the newly written values after continuing?

Thanks + best regards,
Harald
