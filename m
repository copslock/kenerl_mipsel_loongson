Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2004 07:42:22 +0000 (GMT)
Received: from web10106.mail.yahoo.com ([IPv6:::ffff:216.136.130.56]:60278
	"HELO web10106.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225266AbUASHmV>; Mon, 19 Jan 2004 07:42:21 +0000
Message-ID: <20040119074219.15886.qmail@web10106.mail.yahoo.com>
Received: from [128.107.253.43] by web10106.mail.yahoo.com via HTTP; Mon, 19 Jan 2004 07:42:19 GMT
Date: Mon, 19 Jan 2004 07:42:19 +0000 (GMT)
From: =?iso-8859-1?q?karthikeyan=20natarajan?= <karthik_96cse@yahoo.com>
Subject: In r4k, where does PC point to?
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <karthik_96cse@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: karthik_96cse@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi All,

    Basically, the PC points to the next instruction
to
be executed. But, in R4k, there are 8 instructions
getting executed in parallel. Where does the PC point
to? My understanding is that PC points to the next 
instruction that will be entered into the pipeline.
    Please correct me if i am wrong..

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
