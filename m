Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Jan 2004 12:48:34 +0000 (GMT)
Received: from web10103.mail.yahoo.com ([IPv6:::ffff:216.136.130.53]:65451
	"HELO web10103.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8224988AbUAKMsd>; Sun, 11 Jan 2004 12:48:33 +0000
Message-ID: <20040111124828.71884.qmail@web10103.mail.yahoo.com>
Received: from [128.107.253.43] by web10103.mail.yahoo.com via HTTP; Sun, 11 Jan 2004 12:48:28 GMT
Date: Sun, 11 Jan 2004 12:48:28 +0000 (GMT)
From: =?iso-8859-1?q?karthikeyan=20natarajan?= <karthik_96cse@yahoo.com>
Subject: How to configure the cache size in r4000
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <karthik_96cse@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3899
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: karthik_96cse@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi All,

    The cache size is modified by setting the IC/DC
bits in the 'config' register. Seems they are set only
by the hardware during the processor reset. And also,
those bits are mentioned as read only bits..
   Could you please let me know how can we instruct 
the hardware to do so. Can we do this via s/w?.

Thanks,
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
