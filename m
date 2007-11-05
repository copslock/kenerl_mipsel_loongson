Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2007 13:03:18 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:2447 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20029963AbXKENDP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Nov 2007 13:03:15 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lA5D2xKj031224
	for <linux-mips@linux-mips.org>; Mon, 5 Nov 2007 13:02:59 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lA5D2xSP031223
	for linux-mips@linux-mips.org; Mon, 5 Nov 2007 13:02:59 GMT
Date:	Mon, 5 Nov 2007 13:02:59 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Deleting read-only environment variable on Sibyte board.
Message-ID: <20071105130259.GA31023@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17402
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

I've got a read-only environment variable on my Sibyte/Broadcom Bigsur
system.  Annoyingly it's the network address.  Any help on how to
delete such an undeletable environment variable would be welcome.

Thanks,

  Ralf
