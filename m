Received:  by oss.sgi.com id <S305280AbQEAVcA>;
	Mon, 1 May 2000 14:32:00 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:12666 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305275AbQEAVbn>; Mon, 1 May 2000 14:31:43 -0700
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id OAA02978; Mon, 1 May 2000 14:35:57 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id OAA13277; Mon, 1 May 2000 14:31:12 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA57220
	for linux-list;
	Mon, 1 May 2000 14:21:16 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from hollywood.engr.sgi.com (hollywood.engr.sgi.com [163.154.34.46])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA12205;
	Mon, 1 May 2000 14:21:09 -0700 (PDT)
	mail_from (fisher@hollywood.engr.sgi.com)
Received: (from fisher@localhost) by hollywood.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) id OAA31066; Mon, 1 May 2000 14:19:51 -0700 (PDT)
From:   fisher@hollywood.engr.sgi.com (William Fisher)
Message-Id: <200005012119.OAA31066@hollywood.engr.sgi.com>
Subject: Re: VC exceptions
To:     ralf@oss.sgi.com (Ralf Baechle)
Date:   Mon, 1 May 2000 14:19:50 -0700 (PDT)
Cc:     nick@ns.snowman.net, ralf@oss.sgi.com (Ralf Baechle),
        flo@rfc822.org (Florian Lohoff), linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr, linux-mips@vger.rutgers.edu,
        fisher@hollywood.engr.sgi.com (William Fisher)
In-Reply-To: <20000430004557.A1972@uni-koblenz.de> from "Ralf Baechle" at Apr 30, 2000 12:45:58 AM
Reply-To: fisher@sgi.com
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

> 
> On Sat, Apr 29, 2000 at 06:33:54PM -0400, nick@ns.snowman.net wrote:
> 
> > What is a r7000?  I've heard of the r8000, is that the same?
> 
> Stupid answer: No, otherwise they'd have the same name :-)
> 
> The R8000 was some kind of CPU hack which SGI came up with when the R4400
> performance was begining to look bad in comparison to the Alphas and the
> R10000 project still would have taken quite some time.  It was featuring
> roughly the integer performance and twice or trice the fp performance of
> a 250MHz R4400 while running at just 75 - 90 MHz.  It was used only by
> SGI.
> 
> The R7000 is kind of a successor to the R5000 featuring roughly R10000
> performance but at a much lower price.  This was developed by either
> IDT or QED mostly for embedded purposes.
> 
	The R5000, was designed and built by QED whom SGI funded to build the processor
	for the O2 product line. SGI still owns the rights via MTI and is allowed to
	license them to the various MIPS Licensees.

	The QED folks ARE the original RXXXX Series designers who originally worked
	for MIPS Computer System until SGI bought the company in 1992. The various
	processor designs which they developed included the R2000/2010, R3000/3010,
	R4000, R4400, R5000 and R7000 processors. Nearly all of the original MIPS
	Computer systems processor designers are now working at QED. MIPS Technoloy
	Inc, MTI, is mostly SGI processor designers and lots of new engineers who
	own the SGI rights to the various MIPS processor designs.

	The R8000 was shipped in a VME based machine which was placed in the
	Challenge line which included R4400, R8000 and R10000 processors. As was noted
	it was an SGI design in total and had a very short life-time.

-- Bill


	
