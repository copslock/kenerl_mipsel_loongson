Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jun 2006 10:02:21 +0100 (BST)
Received: from [220.76.242.187] ([220.76.242.187]:4325 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S8133475AbWFSJCM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Jun 2006 10:02:12 +0100
Received: from mrv ([192.168.11.157])
	by localhost.localdomain (8.12.8/8.12.8) with SMTP id k5J93aBb012119
	for <linux-mips@linux-mips.org>; Mon, 19 Jun 2006 18:03:39 +0900
Message-ID: <000601c6937f$0bed5270$9d0ba8c0@mrv>
From:	"Roman Mashak" <mrv@corecom.co.kr>
To:	<linux-mips@linux-mips.org>
Subject: Ethernet bridging on 2.6.12-rc3 (PMC-sierra patched)
Date:	Mon, 19 Jun 2006 18:02:08 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="koi8-r";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
FL-Build: Fidolook 2002 (SL) 6.0.2800.86 - 14/6/2003 22:16:25
Return-Path: <mrv@corecom.co.kr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11763
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mrv@corecom.co.kr
Precedence: bulk
X-list: linux-mips

Hello,

I was observing this strange problem today while verifying performance of 
Sequoia board.

Initial conditions:
1) 2.6.12-rc3_L002 kernel from PMCS ftp, compiled for 32bit mode
2) bridge code is compiled into kernel
3) four 100Mbps ethernet devices and one onboard Gigabit link are joined 
into bridge using bridge-utils-1.1
4) I connected board gigabit link to SmartBit Gb interface and four 100mbps 
links to SmartBit FastEthernet interfaces

But 'brctl showmacs br0' shows only fast ethernet links being learned, but 
never gigabit. We have suspicion that Titan driver affects this somehow.

Does anybody have any idea about it or ran into this before?

Thanks in advance!

With best regards, Roman Mashak.  E-mail: mrv@corecom.co.kr 
