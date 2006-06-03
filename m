Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Jun 2006 05:39:25 +0200 (CEST)
Received: from [220.76.242.187] ([220.76.242.187]:57493 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S8133349AbWFCDjM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 3 Jun 2006 05:39:12 +0200
Received: from mrv ([192.168.11.157])
	by localhost.localdomain (8.12.8/8.12.8) with SMTP id k533f8EE029218;
	Sat, 3 Jun 2006 12:41:12 +0900
Message-ID: <000701c686be$fc1ac980$9d0ba8c0@mrv>
From:	"Roman Mashak" <mrv@corecom.co.kr>
To:	<linux-mips@linux-mips.org>
Cc:	"Raj Palani" <Rajesh_Palani@pmc-sierra.com>
Subject: Tg3 driver problem on 2.6.12-rc3 (Sequoia)
Date:	Sat, 3 Jun 2006 12:37:02 +0900
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
X-archive-position: 11655
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mrv@corecom.co.kr
Precedence: bulk
X-list: linux-mips

Hello,

a few days ago I was asking about bcm5700 driver problems and I got 
recommendations to use tg3 driver shipped with kernel. I did it and faced 
serious issues. Here's the story.

1) took 2.6.12-rc_L002 patched by PMC-sierra and compiled in 32bit mode
2) compiled tg3 driver as module
3) booted Sequoia board with this kernel
4) set up bridge between one of on-board interface (Titan GE) and Broadcom 
external NIC, get mysterious warning:

bridge: can't decode speed from eth2: 0

eth2 is Broadcom interface

5) at this stage I connect Sequoia's GE interfaces to SmartBit gigabit 
interfaces, to measure throughput between two gigabit links in bridge mode. 
So, both interfaces are working well (I can ping SmartBit and vice versa). 
But I traffic's coming only in one direction and never through the bridge, 
so 'brctl showmacs br0' always show only one SmartBit MAC address learned.

I configured bridge accroding to documentation (I made sure bridge is 
enabled in kernel):
#brctl addbr br0
#brctl addif br0 eth1    #titan GE
#brctl addif br0 eth2    #broadcom
#ifconfig eth1 0.0.0.0 up
#ifconfig eth2 0.0.0.0 up
#ifconfig eth1 0.0.0.0 up
#ifconfig br0 0.0.0.0 up

Has anybody observed the same behavior?

Thanks for any help!

With best regards, Roman Mashak.  E-mail: mrv@corecom.co.kr 
