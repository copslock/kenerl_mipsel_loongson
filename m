Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Feb 2004 10:49:35 +0000 (GMT)
Received: from web10102.mail.yahoo.com ([IPv6:::ffff:216.136.130.52]:45873
	"HELO web10102.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225248AbUBZKte>; Thu, 26 Feb 2004 10:49:34 +0000
Message-ID: <20040226104929.3711.qmail@web10102.mail.yahoo.com>
Received: from [128.107.253.43] by web10102.mail.yahoo.com via HTTP; Thu, 26 Feb 2004 10:49:29 GMT
Date: Thu, 26 Feb 2004 10:49:29 +0000 (GMT)
From: =?iso-8859-1?q?karthikeyan=20natarajan?= <karthik_96cse@yahoo.com>
Subject: Doubt in updating the cache..
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <karthik_96cse@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4450
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: karthik_96cse@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi All,

    When the Instruction/data is read from memory,
it's copy will be put into the cache.

Question:

    How does the R4k processor determines whether the
value read from memory is Instruction or Data so that
the value will be put into the appropriate primary 
cache?

Thanks much,
-karthi

=====
The expert at anything was once a beginner
                  ______________________________
                 /                              \
             O  /      Karthikeyan.N             \
           O   |       Chennai, India.            |
    `\|||/'     \    Mobile: +919884104346       /
     (o o)       \                              /
_ ooO (_) Ooo____________________________________
_____|_____|_____|_____|_____|_____|_____|_____|_
__|_____|_____|_____|_____|_____|_____|_____|____
_____|_____|_____|_____|_____|_____|_____|_____|_

________________________________________________________________________
Yahoo! Messenger - Communicate instantly..."Ping" 
your friends today! Download Messenger Now 
http://uk.messenger.yahoo.com/download/index.html
