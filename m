Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Dec 2003 06:01:47 +0000 (GMT)
Received: from web10107.mail.yahoo.com ([IPv6:::ffff:216.136.130.57]:20625
	"HELO web10107.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225357AbTLSGBo>; Fri, 19 Dec 2003 06:01:44 +0000
Message-ID: <20031219060127.90257.qmail@web10107.mail.yahoo.com>
Received: from [128.107.253.43] by web10107.mail.yahoo.com via HTTP; Fri, 19 Dec 2003 06:01:27 GMT
Date: Fri, 19 Dec 2003 06:01:27 +0000 (GMT)
From: =?iso-8859-1?q?karthikeyan=20natarajan?= <karthik_96cse@yahoo.com>
Subject: Regarding branch delay instructions in R4000
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <karthik_96cse@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3798
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: karthik_96cse@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi All,

    If this is not a right forum to ask this Question,

please redirect me to the appropriate one...
    Since R4000 is using the 8 stage pipeline, three
instructions are already entered into the pipeline
when the branch instruction is executed. Out of these
three instructions, the first instruction will be 
executed for sure.

My question is:
    What happens to the other two instruction that are
in the delay slots? are they nullified?
    Could anyone please shed some light on this.

Thanks much,
-karthi

=====
The expert at anything was once a beginner

________________________________________________________________________
Yahoo! Messenger - Communicate instantly..."Ping" 
your friends today! Download Messenger Now 
http://uk.messenger.yahoo.com/download/index.html
