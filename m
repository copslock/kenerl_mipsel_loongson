Received:  by oss.sgi.com id <S305190AbQAGAHV>;
	Thu, 6 Jan 2000 16:07:21 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:1838 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305175AbQAGAG5>; Thu, 6 Jan 2000 16:06:57 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id QAA08709; Thu, 6 Jan 2000 16:09:55 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA26680
	for linux-list;
	Thu, 6 Jan 2000 15:56:53 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA28484
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 6 Jan 2000 15:56:42 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA03606
	for <linux@cthulhu.engr.sgi.com>; Thu, 6 Jan 2000 15:56:16 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-9.uni-koblenz.de (cacc-9.uni-koblenz.de [141.26.131.9])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id AAA19993;
	Fri, 7 Jan 2000 00:56:07 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407891AbQAFXyU>;
	Fri, 7 Jan 2000 00:54:20 +0100
Date:   Fri, 7 Jan 2000 00:54:20 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     Ralf Baechle <ralf@oss.sgi.com>, Florian Lohoff <flo@rfc822.org>,
        linux@cthulhu.engr.sgi.com
Subject: Re: Decstation 5000/150 2.3.21 Boot successs
Message-ID: <20000107005420.C17537@uni-koblenz.de>
References: <00ef01bf5859$6d11f410$0ceca8c0@satanas.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <00ef01bf5859$6d11f410$0ceca8c0@satanas.mips.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Thu, Jan 06, 2000 at 04:19:27PM +0100, Kevin D. Kissell wrote:

> >If that's desired, how about providing a syscall which allows to manipulate
> >this and possibly other bits?
> 
> I very much prefer the idea of having exec() to the right thing, so
> that 32/32 fpr and o32 ABI programs can be mixed and matched
> as appropriate - assuming, of course, that there's sufficient information
> in the binary header to do the job!  In practical terms, given that
> Linux is a multiuser and multitasking system, a syscall that throws
> some sort of global switch could only be safely invoked once
> at boot time, and as such offers little advantage over hardwired
> kernel code.

I was suggesting such a syscall because embedded people have asked me about
making the 32/32 fpr model available to `normal' o32 code.  N32 won't work
for them for practical reasons (linker tooo buggy) and 64-bit ABI is
unacceptable for size / tlb / cache reasons.

For the general case you're of course right, exec() should do the right
thing.  And modulo the bug we're discussing here the 32-bit kernel already
does the right thing to handle the general case.

  Ralf
