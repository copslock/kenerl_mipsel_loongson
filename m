Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jan 2003 15:24:44 +0000 (GMT)
Received: from [IPv6:::ffff:209.116.120.7] ([IPv6:::ffff:209.116.120.7]:26640
	"EHLO tnint11.telogy.design.ti.com") by linux-mips.org with ESMTP
	id <S8226173AbTAJPYn>; Fri, 10 Jan 2003 15:24:43 +0000
Received: by tnint11.telogy.design.ti.com with Internet Mail Service (5.5.2653.19)
	id <WY1ZW1DC>; Fri, 10 Jan 2003 10:22:17 -0500
Message-ID: <37A3C2F21006D611995100B0D0F9B73CBFE40C@tnint11.telogy.design.ti.com>
From: "Zajerko-McKee, Nick" <nmckee@telogy.com>
To: 'atul srivastava' <atulsrivastava9@rediffmail.com>,
	linux-mips@linux-mips.org
Subject: RE: handling of s-record images by bootloader
Date: Fri, 10 Jan 2003 10:22:15 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <nmckee@telogy.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nmckee@telogy.com
Precedence: bulk
X-list: linux-mips

I had a simular problem.  I ended up writing my own code for my
platform.  Here is a description of s-records:

http://www.amelek.gda.pl/avr/uisp/srecord.htm

-----Original Message-----
From: atul srivastava [mailto:atulsrivastava9@rediffmail.com]
Sent: Friday, January 10, 2003 5:17 AM
To: linux-mips@linux-mips.org
Subject: handling of s-record images by bootloader


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
