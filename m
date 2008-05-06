Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 May 2008 19:15:09 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:1433 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20024837AbYEFSPG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 May 2008 19:15:06 +0100
Received: (qmail 9356 invoked by uid 1000); 6 May 2008 20:15:04 +0200
Date:	Tue, 6 May 2008 20:15:04 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org
Subject: [RFT] au1xmmc: remove board-specific code
Message-ID: <20080506181504.GA9294@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19110
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hello,

I received a new Au1200 based toy on which the current driver-implemented
SD card-detect scheme doesn't work.  However since this toy does have a 
dedicated SD carddetect IRQ and card status bits, I took the opportunity
to get rid of the DB1200 specific parts in the driver and added callbacks
for platform/board-specific carddetect and voltage setting methods.

What I need is feedback from testers with access to db1200/pb1200 boards:
The patch below (+ boardstuff) works on my board but I'm not sure if
I got the carddetect poll timer for the db1200 right.

Please test and comment!

Thanks!
	Manuel Lauss

--- 
