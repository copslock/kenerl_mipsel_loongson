Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Sep 2003 14:58:30 +0100 (BST)
Received: from webmail10.rediffmail.com ([IPv6:::ffff:202.54.124.179]:35806
	"HELO rediffmail.com") by linux-mips.org with SMTP
	id <S8225364AbTIDN56>; Thu, 4 Sep 2003 14:57:58 +0100
Received: (qmail 28349 invoked by uid 510); 4 Sep 2003 12:52:58 -0000
Date: 4 Sep 2003 12:52:58 -0000
Message-ID: <20030904125258.28348.qmail@webmail10.rediffmail.com>
Received: from unknown (210.210.7.195) by rediffmail.com via HTTP; 04 sep 2003 12:52:58 -0000
MIME-Version: 1.0
From: "ashish  anand" <ashish_ibm@rediffmail.com>
Reply-To: "ashish  anand" <ashish_ibm@rediffmail.com>
To: linux-mips@linux-mips.org
Subject: configuring edge or level triggered interrupt..?
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Return-Path: <ashish_ibm@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3124
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashish_ibm@rediffmail.com
Precedence: bulk
X-list: linux-mips

Hello,
I have a problem of interfacing an ISDN SLAC device which raise
interrupts as edge triggered only .

while board is configured for Level triggered interrupts.
ocassionally i get spurious interrupts as edge is lost.
I tried to got a new edge by writing FFh in mask register and 
again
restoring oldmask but somehow it didn't help.

my question is that how I can configure edge triggered interrupt 
on my
linux host side on mips Lexra architecture...
I see no mention of that on my mips linux source tree..while on 
other architectures say PPC I used to explicitly configure the 
lines
of interrupt controller as edge or level triggered and active high 
or low polarity .

Best Regards,
Ashish Anand

___________________________________________________
Meet your old school or college friends from
1 Million + database...
Click here to reunite www.batchmates.com/rediff.asp
