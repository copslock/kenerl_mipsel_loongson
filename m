Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2004 15:03:24 +0000 (GMT)
Received: from no-dns-yet.demon.co.uk ([IPv6:::ffff:193.195.124.4]:20724 "EHLO
	exterity-serv1.exterity.co.uk") by linux-mips.org with ESMTP
	id <S8225310AbUA3PDY> convert rfc822-to-8bit; Fri, 30 Jan 2004 15:03:24 +0000
Received: from gillpc ([192.168.0.32]) by exterity-serv1.exterity.co.uk with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 30 Jan 2004 15:04:29 +0000
From: "Gill" <gill.robles@exterity.co.uk>
To: <linux-mips@linux-mips.org>
Subject: Char device driver problem
Date: Fri, 30 Jan 2004 15:07:07 -0000
Organization: Exterity
Message-ID: <000b01c3e742$ba513d90$2000a8c0@gillpc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-OriginalArrivalTime: 30 Jan 2004 15:04:29.0187 (UTC) FILETIME=[5BE18530:01C3E742]
Return-Path: <gill.robles@exterity.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4203
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gill.robles@exterity.co.uk
Precedence: bulk
X-list: linux-mips

I'm currently writing a char device driver, and I've seen some unexpected
behaviour, which someone may be able to explain.

 
I have some test code which simply opens my device and makes an ioctl call.
Initially, the device's "open" function did nothing, and the ioctl call:

o Performed initialisation

o Called function to produce a test tone.

This worked as expected, and generated the test tone.  However, I then moved
the initialisation code into the open function.  This time, when the user
opens the device and makes the ioctl call, no test tone is generated,
although the function returns with a success code.

Does anyone know why moving code in this way should change the behaviour?
The initialisation code does not create any tasks, and calls to the device
driver are blocking.  I've even tried using copy_to_user, and copy_from_user
to ensure that arguments are passed correctly, although this doesn't make
any discernable difference.  The only difference I can see is that I do
additional context switches...

Any help/suggestions would be much appreciated!

 
Gill

 

 
