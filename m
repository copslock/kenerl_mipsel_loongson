Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2005 15:38:55 +0100 (BST)
Received: from no-dns-yet.demon.co.uk ([IPv6:::ffff:83.104.11.251]:65185 "EHLO
	exterity.co.uk") by linux-mips.org with ESMTP id <S8226026AbVDDOil> convert rfc822-to-8bit;
	Mon, 4 Apr 2005 15:38:41 +0100
Received: from gillpc ([192.168.0.32]) by exterity.co.uk with Microsoft SMTPSVC(6.0.3790.211);
	 Mon, 4 Apr 2005 15:40:19 +0100
From:	"Gill" <gill.robles@exterity.co.uk>
To:	<linux-mips@linux-mips.org>
Subject: No PCI memory response
Date:	Mon, 4 Apr 2005 15:44:51 +0100
Organization: Exterity
Message-ID: <000001c53924$db7c75e0$2000a8c0@gillpc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-OriginalArrivalTime: 04 Apr 2005 14:40:19.0656 (UTC) FILETIME=[39852480:01C53924]
Return-Path: <gill.robles@exterity.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7586
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gill.robles@exterity.co.uk
Precedence: bulk
X-list: linux-mips

Can anyone help?  We're trying to talk to a RealTek RTL8139 device across
the PCI bus, and, although linux can access configuration registers on the
device, it does not access memory space correctly, and we are unable to read
back any sensible values from the RTL8139 registers. 

We are using the latest 2.6 linux on an Alchemy DB1550 board.

Any help would be much appreciated!


Gill
