Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5RL49K14623
	for linux-mips-outgoing; Wed, 27 Jun 2001 14:04:09 -0700
Received: from mother.pmc-sierra.bc.ca (mother.pmc-sierra.bc.ca [216.241.224.12])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5RL48V14614
	for <linux-mips@oss.sgi.com>; Wed, 27 Jun 2001 14:04:08 -0700
Received: (qmail 27594 invoked by uid 104); 27 Jun 2001 21:04:02 -0000
Received: from Trina_Littlejohns@pmc-sierra.com by mother with qmail-scanner-0.93 (uvscan: v4.0.70/v4074. . Clean. Processed in 1.00018 secs); 27/06/2001 14:04:01
Received: from unknown (HELO procyon.pmc-sierra.bc.ca) (134.87.115.1)
  by mother.pmc-sierra.bc.ca with SMTP; 27 Jun 2001 21:04:01 -0000
Received: from bby1exi01.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by procyon.pmc-sierra.bc.ca (dave/8.11.2) with ESMTP id f5RL40e05942;
	Wed, 27 Jun 2001 14:04:00 -0700 (PDT)
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2653.19)
	id <MZ6DLQC5>; Wed, 27 Jun 2001 14:08:21 -0700
Message-ID: <60474D3886D54F4BAB0CB49A4BB6E8A8837906@bby1exp01>
From: Trina Littlejohns <Trina_Littlejohns@pmc-sierra.com>
To: "'Ralf Baechle'" <ralf@oss.sgi.com>,
   "'Maciej W. Rozycki'"
	 <macro@ds2.pg.gda.pl>
Cc: "'linux-mips@fnet.fr'" <linux-mips@fnet.fr>,
   "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: RE: [patch] 2.4.5 and earlier: Mysterious lock-ups resolved
Date: Wed, 27 Jun 2001 14:08:20 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f5RL48V14619
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Dear Mr. Baechle,

Thank you for your request for support on PMC-Sierra products.  In order to serve you better, we require some additional contact information.  This information will be used to direct your request to the appropriate factory or field applications engineer, and to help us track your support incident.

Could you please reply to me with the following information:

-   Part Number
· Full Name
· Company Name
· Company Location (city)
· Mailing Address (optional)
· Phone Number (optional)
· Fax Number (optional)

Thanks,

Applications Assistant
PMC-Sierra, Inc.
Ph: (604) 415-4533
Fax: (604) 415-6206
apps@pmc-sierra.com 
http://www.pmc-sierra.com/ <http://www.pmc-sierra.com/> 

-----Original Message-----
From: Ralf Baechle [mailto:ralf@oss.sgi.com]
Sent: Wednesday, June 27, 2001 6:50 AM
To: Maciej W. Rozycki
Cc: linux-mips@fnet.fr; linux-mips@oss.sgi.com
Subject: Re: [patch] 2.4.5 and earlier: Mysterious lock-ups resolved


On Mon, Jun 25, 2001 at 01:36:15PM +0200, Maciej W. Rozycki wrote:

>  After extensive debugging I managed to track down the bug that was
> preventing me from building binutils since the beginning of February.
> Once again the culprit turned out to the the explicit nature of MIPS'
> caches.
> 
>  The problem lies in r3k_flush_cache_sigtramp().  It flushes three
> consecutive word-wide locations starting from the address passed as an
> argument.  The argument is normally a sigreturn trampoline that is set up
> by setup_frame() or setup_rt_frame().  But these functions set up two
> opcodes only -- the third word is left untouched.  In my case the address
> was something like 0x7???bff8.  So the area to be flushed spanned a page
> boundary and since the third word was unreferenced, a TLB entry for the
> page the word was located in was absent.  As a result, a TLB refill
> exception happened with caches isolated, which is not necessarily a win.
> The symptom was a solid crash. 
> 
>  I don't see any reason to flush the third word location, so I removed the
> code doing it.  This fixed the crashes I was observing, but since we are
> using mapped (KUSEG) addresses in r3k_flush_cache_sigtramp(), I believe we
> need more protection against unwanted TLB exceptions.  The point is we are
> running with interrupts enabled and a reschedule may happen between
> touching the trampoline in setup*_frame() and flushing the cache.  Hence
> the TLB entries for the trampoline area, even once present, may get
> removed meanwhile.  So I added some code to explicitly load the entries,
> if needed, with interrupts disabled just before isolating caches. 
> Following is a resulting patch. 
> 
>  Ralf, this is a showstopper bug -- please apply the fix ASAP. 

Applied.

  Ralf
