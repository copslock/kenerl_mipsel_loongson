Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Nov 2004 01:25:25 +0000 (GMT)
Received: from pop.gmx.net ([IPv6:::ffff:213.165.64.20]:58537 "HELO
	mail.gmx.net") by linux-mips.org with SMTP id <S8225337AbUKVBZM>;
	Mon, 22 Nov 2004 01:25:12 +0000
Received: (qmail 8825 invoked by uid 0); 22 Nov 2004 01:25:06 -0000
Received: from 69.193.111.169 by www8.gmx.net with HTTP;
	Mon, 22 Nov 2004 02:25:06 +0100 (MET)
Date: Mon, 22 Nov 2004 02:25:06 +0100 (MET)
From: "Mad Props" <madprops@gmx.net>
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Subject: beginners question
X-Priority: 3 (Normal)
X-Authenticated: #24801140
Message-ID: <8709.1101086706@www8.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-Path: <madprops@gmx.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: madprops@gmx.net
Precedence: bulk
X-list: linux-mips

Hi,

i wrote a little MIPS startup code that uses the serial port to print some
output. Further I enabled timer interrupts. So far, I'm using kseg1 since
nothing else is intialized.

I have a static variable in my C exception hander. The problem with it: it's
apparently not within kseg1 but in the user segment and causes the exception
handler to get invoked recursively. How can I change this so that all
variables / code use kseg1 ?

thx

Thomas

-- 
Geschenkt: 3 Monate GMX ProMail + 3 Top-Spielfilme auf DVD
++ Jetzt kostenlos testen http://www.gmx.net/de/go/mail ++
