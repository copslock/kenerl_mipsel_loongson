Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Dec 2007 09:50:05 +0000 (GMT)
Received: from miranda.se.axis.com ([193.13.178.8]:31121 "EHLO
	miranda.se.axis.com") by ftp.linux-mips.org with ESMTP
	id S20021618AbXLNJt5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 14 Dec 2007 09:49:57 +0000
Received: from exgate.se.axis.com (exgate.se.axis.com [10.0.5.55])
	by miranda.se.axis.com (8.13.4/8.13.4/Debian-3sarge3) with SMTP id lBE9nfdo022182
	for <linux-mips@linux-mips.org>; Fri, 14 Dec 2007 10:49:41 +0100
Received: from exmail1.se.axis.com ([10.0.5.70]) by exgate.se.axis.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 14 Dec 2007 10:49:40 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: GCC 3.4.5 and mftc0
Date:	Fri, 14 Dec 2007 10:49:40 +0100
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C6680557B0DB@exmail1.se.axis.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: GCC 3.4.5 and mftc0
Thread-Index: Acg+NqUmOqkfWFBVTzaV/6B9jRu56Q==
From:	"Mikael Starvik" <mikael.starvik@axis.com>
To:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 14 Dec 2007 09:49:40.0822 (UTC) FILETIME=[A5A43F60:01C83E36]
Return-Path: <mikael.starvik@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mikael.starvik@axis.com
Precedence: bulk
X-list: linux-mips

mftc0() is implemented as
 
 .word ...
  move %0, $1

With at least gcc 3.4.5 the move is implemented as an addu %0, $1, $0.
But in the MIPS sumulator this fails and %0 gets the value 0xffffffff.
Implementing this as a or %0, $1, $0 instead gives the expected result.

Any suggestions where the problem is and what the correct solution is?

After fixing this my next problem is that IPIs doesn't reach all TCs
correctly (it seams like the code doesn't detect IXMT status correctly,
but I am still investigating). It is likely that it is caused by
something similar to the problem above.

Regards
/Mikael
