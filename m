Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jan 2003 10:18:15 +0000 (GMT)
Received: from webmail29.rediffmail.com ([IPv6:::ffff:203.199.83.39]:16315
	"HELO rediffmail.com") by linux-mips.org with SMTP
	id <S8226112AbTAJKSO>; Fri, 10 Jan 2003 10:18:14 +0000
Received: (qmail 7451 invoked by uid 510); 10 Jan 2003 10:14:03 -0000
Date: 10 Jan 2003 10:14:03 -0000
Message-ID: <20030110101403.7450.qmail@webmail29.rediffmail.com>
Received: from unknown (203.196.179.98) by rediffmail.com via HTTP; 10 jan 2003 10:14:03 -0000
MIME-Version: 1.0
From: "atul srivastava" <atulsrivastava9@rediffmail.com>
Reply-To: "atul srivastava" <atulsrivastava9@rediffmail.com>
To: linux-mips@linux-mips.org
Subject: handling of s-record images by bootloader
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Return-Path: <atulsrivastava9@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: atulsrivastava9@rediffmail.com
Precedence: bulk
X-list: linux-mips

Hello .

A quick question..

I have developed a primitive bootloader for custom board, that is 
successfuly doing the board bringup and loads linux os image
currently through serial link (kermit) only.
network link is also likely to be up soon.

but through serial it loads  kernel image only in raw binary 
format.
now i want to extend this for s-record images as well..

I am umware that, how differently s-record image need to be 
handled..?
i just need some idea or if possible any example code for that..

Best Reagards,
Atul
