Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 May 2004 08:59:24 +0100 (BST)
Received: from no-dns-yet.demon.co.uk ([IPv6:::ffff:83.104.11.251]:25782 "EHLO
	exterity-serv1.exterity.co.uk") by linux-mips.org with ESMTP
	id <S8224986AbUEVH7X> convert rfc822-to-8bit; Sat, 22 May 2004 08:59:23 +0100
Received: from gillpc ([192.168.0.32]) by exterity-serv1.exterity.co.uk with Microsoft SMTPSVC(5.0.2195.6713);
	 Sat, 22 May 2004 09:01:25 +0100
From: "Gill" <gill.robles@exterity.co.uk>
To: <linux-mips@linux-mips.org>
Subject: Socket problem?
Date: Sat, 22 May 2004 09:02:48 +0100
Organization: Exterity
Message-ID: <000001c43fd3$2c25a350$2000a8c0@gillpc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-OriginalArrivalTime: 22 May 2004 08:01:25.0984 (UTC) FILETIME=[FAFDDE00:01C43FD2]
Return-Path: <gill.robles@exterity.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5091
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gill.robles@exterity.co.uk
Precedence: bulk
X-list: linux-mips

Hi -

Has anyone come across a socket problem where the user app calls select() on
a set of sockets, which returns, indicating that data is waiting...then
subsequent recvfrom() call returns -1 indicating that there's nothing
there??

I'm using linux v2.4.2, IPv4, and the ethernet driver is pcnet32.  We're
receiving a UDP stream.

I'm trying to check for dropped packets.  /proc/net/snmp indicates a number
of UDP InErrors (~1 per second).  However, not yet sure whether this is a
consequence of the problem above, or cause of it.

Any help much appreciated!

/Gill
