Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id NAA774862 for <linux-archive@neteng.engr.sgi.com>; Mon, 17 Nov 1997 13:33:03 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA18591 for linux-list; Mon, 17 Nov 1997 13:28:26 -0800
Received: from hollywood.engr.sgi.com (hollywood.engr.sgi.com [150.166.61.38]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA18586 for <linux@cthulhu.engr.sgi.com>; Mon, 17 Nov 1997 13:28:25 -0800
Received: (from fisher@localhost) by hollywood.engr.sgi.com (940816.SGI.8.6.9/960327.SGI.AUTOCF) id NAA04775; Mon, 17 Nov 1997 13:28:24 -0800
From: fisher@hollywood.engr.sgi.com (William Fisher)
Message-Id: <199711172128.NAA04775@hollywood.engr.sgi.com>
Subject: Re: Pentium F00F bug Linux workaround; BSDI Response
To: linux@hollywood.engr.sgi.com
Date: Mon, 17 Nov 1997 13:28:20 -0800 (PST)
Cc: fisher@hollywood.engr.sgi.com (William Fisher)
Reply-To: fisher@sgi.com
X-Mailer: ELM [version 2.4 PL3]
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Here is the response I got from BSDI on the Pentium F00F bug fix.

-- Bill
-----------------------
>From dab@frantic.BSDI.COM  Sat Nov 15 09:32:26 1997
Date: Sat, 15 Nov 1997 11:32:42 -0600 (CST)
From: David Borman <dab@BSDI.COM>
Message-Id: <199711151732.LAA17129@frantic.BSDI.COM>
To: fisher@sgi.com
Subject: Re: Pentium F00F bug Linux workaround

Hi Bill,

> Is this true that:
> 
> "BSDI signed an NDA with Intel to get early fix techniques"?
> 
> ...
> Subject: Re: Pentium F00F bug Linux workaround
> References:  <199711142117.NAA27890@.....>
> Sender: owner-linux@cthulhu
> Precedence: bulk
> 
> We also got some good press from it pretty fast after we released the fixes:
> 
> http://www.news.com/News/Item/0,4,16312,00.html
> 
> Whats extremely humorous is that BSDI signed an NDA with Intel to get
> early fix techniques told to them by Intel engineers.  But the NDA
> stated they could not release patch sets for BSDI until Intel said so,
> the thinking on Intel's part is that they wanted nobody to be the
> first with a fix.  BSDI overlooked this and put the fix out, then
> quickly took the fixes down once they released they had breached the
> Intel NDA.
> 
> After the Linux fix was already out, Intel engineers spoke with Linus
> and tried to get him to sign an NDA, I've never laughed so hard in my life.
>
Hmm... The Linux message is not accurate.  At no time has BSDI violated
any agreements with Intel.  The first patch that we put up was a beta
patch.  It solves the problem, but we made some minor improvements on
it in our official patch.

I'll also point out that Intel called us.  From our official patch:

	BSDI has worked closely with Intel since they contacted us about
	this erratum. We were able to develop a workaround for BSD/OS very
	quickly, and Intel's assistance was invaluable in this process.
	BSDI is confident that the software workaround solves this problem
	for our customers.
	...
	Thanks to Intel Corporation for contacting BSDI with data that
	led to the fix.

Also, though I don't personally have anything to support this, it is our
understanding that the Linux fix was based at least in part upon
disassembling our beta patch.

I've attached our "press release".

		-David Borman, dab@bsdi.com


FOR IMMEDIATE RELEASE
Contact:	Donna Faulkner
		Baron, McDonald & Wells
		770/492-0373
		dfaulkner@bmwpr.com

First Intel Pentium Processor 'F0' Bug Fix Announced for BSDI ISP Customers

ISPs and other users of BSD/OS can be protected against system 'freezes'
caused by illegal code strings 

COLORADO SPRINGS, Co.  (November 17, 1997)

Internet Service Providers (ISPs) and other users of the BSD/OS can now protect themselves against problems associated with the 'F0' bug discovered in Intel's Pentium processor.  Berkeley Software Design, Inc. (BSDI) today announced a patch that protects companies running BSD/OS 3.1, 3.0, 2.1 against system freezes caused when the processor receives an illegal, one-line instruction.  
	BSDI's patch enables the BSD/OS to gain control whenever an invalid sequence is executed, enabling the system to take its normal action in response to illegal instructions.  The patch offers a solution to more than 7,000 organizations and companies relying on the BSD/OS, including over 3,000 ISPs worldwide.  ISPs are particularly vulnerable to system attacks based on the Pentium processor bug, since any user or subscriber with malicious intent has the potential to create a system-wide hang-up.

	"BSDI has developed an outstanding reputation for rapid response to attacks," said Mike Karels, vice president of engineering for BSDI.  "Last summer, we were the first commercial vendor to provide a defense against 'SYN-flooding' attacks.  This week, we have once again demonstrated industry-leading support for our customers."

The BSD/OS patch is downloadable from the company's web site at
	http://www.bsdi.com. 
Berkeley Software Design, Inc. is the commercial supplier of the
high-performance BSD Internet and networking system software originally
developed at the University of California, Berkeley.

Internet experts worldwide are powering the networked economy with over 75,000 deployed servers running BSDI software engines and applications.  BSDI products for Intel-based PC platforms include the BSDI Internet Server, BSD/OS, and network software for networking appliance developers.  BSDI customers include Adobe Systems, Chase Manhattan Bank, CompuServe, U.S. West, UUNET Technologies, Volvo, and leading Internet Service Providers worldwide.  BSDI is privately held and headquartered in Colorado Springs, Colorado.  Contact BSDI at 719-593-9445, info@bsdi.com or http://www.bsdi.com.

BSDI, BSD/OS and the BSDI logo are trademarks of Berkeley Software Design, Inc.  All other product or service names are trademarks of their respective owners.
