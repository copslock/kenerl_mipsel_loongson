Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Aug 2003 20:37:42 +0100 (BST)
Received: from bay1-f6.bay1.hotmail.com ([IPv6:::ffff:65.54.245.6]:16659 "EHLO
	hotmail.com") by linux-mips.org with ESMTP id <S8225201AbTHOThk>;
	Fri, 15 Aug 2003 20:37:40 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Fri, 15 Aug 2003 12:37:22 -0700
Received: from 207.13.167.2 by by1fd.bay1.hotmail.msn.com with HTTP;
	Fri, 15 Aug 2003 19:37:22 GMT
X-Originating-IP: [207.13.167.2]
X-Originating-Email: [michaelanburaj@hotmail.com]
From: "Michael Anburaj" <michaelanburaj@hotmail.com>
To: linux-mips@linux-mips.org
Subject: RTL8139 -- Link status change
Date: Fri, 15 Aug 2003 12:37:22 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F65q4IaYZVCA1G0003fe37@hotmail.com>
X-OriginalArrivalTime: 15 Aug 2003 19:37:22.0566 (UTC) FILETIME=[A5C6E260:01C36364]
Return-Path: <michaelanburaj@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3060
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michaelanburaj@hotmail.com
Precedence: bulk
X-list: linux-mips

Hi,

Setup: MIPS board -> Hub <- RH 9 (DHCP server)

I have a RTL8139 based PCI NIC inserted on the MIPS’s PCI (2.1) slot. The
WAL on the NIC is left floating (Is that a problem?). I am able to send
packets from the MIPS board to RH 9, but the packets sent from the RH 9 is
not reaching the MIPS board.

Even if the DHCP server is not connected, I see the Link status change
interrupt (status) bit of ISR going high after every packet sent from the
MIPS board. Seems like the cause for the problem I see, am I right?
Can somebody tell me why the link status is changing after a packet is sent
out?

Sample at every change in ISR:
-----------------------------
BMCR = 0x1100
BMSR = 0x782d
ANAR = 0x01e1
ANLPAR = 0x45e1
ANER = 0x0001
DIS = 0x0000
FCSC = 0x0000


Is there a register to look at, for the cause to this link status change
<The above registers don't change at all>? Please suggest me a way to debug
this issue.

Thanks,
-Mike.

_________________________________________________________________
Protect your PC - get McAfee.com VirusScan Online  
http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963
