Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2004 07:24:10 +0000 (GMT)
Received: from web10102.mail.yahoo.com ([IPv6:::ffff:216.136.130.52]:21128
	"HELO web10102.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225254AbUAVHYJ>; Thu, 22 Jan 2004 07:24:09 +0000
Message-ID: <20040122072407.11156.qmail@web10102.mail.yahoo.com>
Received: from [128.107.253.43] by web10102.mail.yahoo.com via HTTP; Thu, 22 Jan 2004 07:24:07 GMT
Date: Thu, 22 Jan 2004 07:24:07 +0000 (GMT)
From: =?iso-8859-1?q?karthikeyan=20natarajan?= <karthik_96cse@yahoo.com>
Subject: Doubt in timer interrupt
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <karthik_96cse@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: karthik_96cse@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi All,

  In R4000 & descendent processors, interrupt number 7
is being used for internal timer interrupt. From this
i understand that the timer interrupt is also maskable
when the IE bit in status register is cleared. If 
somebody mask this interrupt for a long time 
erroneously, then won't there be a problem in 
maintaining the system time?
    Please correct me if i am wrong..

Does the system time is maintained via NMI?
   
Thanks in advance,
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
