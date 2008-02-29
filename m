Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Feb 2008 23:42:49 +0000 (GMT)
Received: from post2.wesleyan.edu ([129.133.6.128]:18662 "EHLO
	post2.wesleyan.edu") by ftp.linux-mips.org with ESMTP
	id S28596238AbYB2Xmr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 29 Feb 2008 23:42:47 +0000
Received: from webmail.wesleyan.edu (pony2.wesleyan.edu [129.133.6.193])
	by courier2.wesleyan.edu (8.13.6/8.13.6) with ESMTP id m1TNgdqK026734
	for <linux-mips@linux-mips.org>; Fri, 29 Feb 2008 18:42:39 -0500
Received: from 69.183.100.66
        (SquirrelMail authenticated user sknauert)
        by webmail.wesleyan.edu with HTTP;
        Sat, 1 Mar 2008 00:42:39 +0100 (CET)
Message-ID: <40668.69.183.100.66.1204328559.squirrel@webmail.wesleyan.edu>
Date:	Sat, 1 Mar 2008 00:42:39 +0100 (CET)
Subject: Kernel mode-setting and PCI video on MIPS?
From:	sknauert@wesleyan.edu
To:	linux-mips@linux-mips.org
User-Agent: SquirrelMail/1.4.10a
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-Wesleyan-MailScanner-Information: Please contact the ISP for more information
X-Wesleyan-MailScanner:	Found to be clean
X-Originating-IP: 129.133.6.193
X-MailScanner-From: sknauert@wesleyan.edu
Return-Path: <sknauert@wesleyan.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sknauert@wesleyan.edu
Precedence: bulk
X-list: linux-mips

I saw some of the recent work in trying to get graphics setup out of the X
server and into the kernel. I was wondering if that work (which is planned
for 2.6.26) would mean that any card with a supported kernel part could
then be used by an X server that supported the new kernel API.

Also, since this mode-setting directly addresses the hardware and does not
rely on BIOS, if this means it would effectively be cross-platform (or at
least easily portable).
