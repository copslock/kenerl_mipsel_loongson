Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Nov 2002 08:53:48 +0100 (CET)
Received: from webmail36.rediffmail.com ([203.199.83.248]:26861 "HELO
	webmail36.rediffmail.com") by linux-mips.org with SMTP
	id <S1121742AbSKYHxr>; Mon, 25 Nov 2002 08:53:47 +0100
Received: (qmail 28849 invoked by uid 510); 25 Nov 2002 07:52:38 -0000
Date: 25 Nov 2002 07:52:38 -0000
Message-ID: <20021125075238.28848.qmail@webmail36.rediffmail.com>
Received: from unknown (203.200.7.93) by rediffmail.com via HTTP; 25 nov 2002 07:52:38 -0000
MIME-Version: 1.0
From: "atul srivastava" <atulsrivastava9@rediffmail.com>
Reply-To: "atul srivastava" <atulsrivastava9@rediffmail.com>
To: linux-mips@linux-mips.org
Subject: watch exception only for kseg0 addresses..?
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Return-Path: <atulsrivastava9@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 699
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: atulsrivastava9@rediffmail.com
Precedence: bulk
X-list: linux-mips

Hello,

I am trying to set a watch exception in (IDT RC32334) my debugging 
execise
In arch/mips/lib/watch.S says "curremtly available only for KSEG0 
address"

which is evident by following assembly..
                 LEAF(__watch_set)
                 li      t0,0x80000000
                 subu    a0,t0
                 ori     a0,7
                 xori    a0,7
                 or      a0,a1
                 mtc0    a0,CP0_WATCHLO
                 .......

it is loading the physical address of KSEG0 addresses in CP0 
watchpoint register.

in change history of this file i am able to see  KSEG0 restriction 
removed only for arch/mips64/lib/watch.S...

while my manual is not specific about KSEG0 , can i safely use it 
for all addresses ,offcourse then above assembly has to be 
modified appropiately for addresses of different regions..

Best Regards.
Ashish
