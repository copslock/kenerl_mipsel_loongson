Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jul 2006 18:46:03 +0100 (BST)
Received: from imf22aec.mail.bellsouth.net ([205.152.59.70]:12494 "EHLO
	imf22aec.mail.bellsouth.net") by ftp.linux-mips.org with ESMTP
	id S8133875AbWGJRpy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 10 Jul 2006 18:45:54 +0100
Received: from ibm67aec.bellsouth.net ([74.236.202.48])
          by imf22aec.mail.bellsouth.net with ESMTP
          id <20060710174548.SFPI13979.imf22aec.mail.bellsouth.net@ibm67aec.bellsouth.net>
          for <linux-mips@linux-mips.org>; Mon, 10 Jul 2006 13:45:48 -0400
Received: from [192.168.1.96] (really [74.236.202.48])
          by ibm67aec.bellsouth.net with ESMTP
          id <20060710174548.RVBY16552.ibm67aec.bellsouth.net@[192.168.1.96]>
          for <linux-mips@linux-mips.org>; Mon, 10 Jul 2006 13:45:48 -0400
Mime-Version: 1.0 (Apple Message framework v750)
Content-Transfer-Encoding: 7bit
Message-Id: <4E35E8AD-C3ED-47AE-A738-97B7F08D946C@willmert.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To:	linux-mips@linux-mips.org
From:	craigslist <craigslist@willmert.com>
Subject: PCMCIA Help - AU1000 Alchemy Dev Board
Date:	Mon, 10 Jul 2006 13:45:24 -0400
X-Mailer: Apple Mail (2.750)
Return-Path: <craigslist@willmert.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: craigslist@willmert.com
Precedence: bulk
X-list: linux-mips

Hi all,

I'm working on a project with linux 2.6.10 on the AMD au1000 alchemy  
board. I'm attempting to get the pcmcia socket working with a  
wireless network card using the madwifi drivers. I have the 2.6.10  
kernel built for the au1000 dev board and the filesystem, etc.  
However, I'm having difficulties getting the PCMCIA socket to work  
correctly.

At this point, i'm just working with the au1x00_ss module trying to  
get it to recognize a card insert into socket 0 of the au1000 dev  
board. Through debugging, I've noticed that the board_status register  
at 0XAE000004, bit 4, is not changing whether a card is inserted or  
not. It's my understanding that the first step to getting this  
working is detecting the presence of a card, however, I am apparently  
missing some detail as that register value never changes.

Does anyone have experience with this? Has anyone gotten the pcmcia  
sockets working on the au1000 in 2.6?

Any suggestions would be greatly appreciated.


Thanks

Stefan Willmert
