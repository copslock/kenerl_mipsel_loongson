Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1QBnJ212542
	for linux-mips-outgoing; Tue, 26 Feb 2002 03:49:19 -0800
Received: from oval.algor.co.uk (root@oval.algor.co.uk [62.254.210.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1QBnC912536
	for <linux-mips@oss.sgi.com>; Tue, 26 Feb 2002 03:49:13 -0800
Received: from gladsmuir.algor.co.uk.algor.co.uk (IDENT:dom@gladsmuir.algor.co.uk [192.168.5.75])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g1QAn6413505;
	Tue, 26 Feb 2002 10:49:07 GMT
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Message-ID: <15483.26654.874273.652089@gladsmuir.algor.co.uk>
Date: Tue, 26 Feb 2002 10:49:02 +0000
To: Scott A McConnell <samcconn@cotw.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: MIPS, i8259 and spurious interrupts.
In-Reply-To: <3C7A9579.BE02A838@cotw.com>
References: <3C7A9579.BE02A838@cotw.com>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Scott A McConnell (samcconn@cotw.com) writes:

> I have been trying to track down and resolve a spurious interrupt
> problem. I have attached some output and the code used to generate it in
> i8259.c.

Part of your problem may be write buffer hell.

Whatever you do to clear the interrupt when you've done with it
involves writing to the 8259 controller.  It's probably a long way
away - probably through a PCI bus to a simulated ISA bus.  Somewhere
along the line the writes will be 'posted'; your CPU is fast, so when
your CPU emerges from its interrupt routine the write may not have
reached the 8259 yet, and you'll get a spurious interrupt.

The code which switches off the interrupt at the 8259 should probably
be equipped with a 'barrier' call to some system function which waits
until the write has really happened.

Then 8259s are ugly things which have some very CPU-specific
interactions with x86 CPUs.  In a non-x86 context you need to
initialise them in particular ways.  

-- 
Dominic Sweetman
Algorithmics Ltd
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone +44 1223 706200/fax +44 1223 706250/direct +44 1223 706205
http://www.algor.co.uk
