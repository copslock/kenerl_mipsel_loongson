Received:  by oss.sgi.com id <S305160AbQBOTWO>;
	Tue, 15 Feb 2000 11:22:14 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:56698 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbQBOTV6>; Tue, 15 Feb 2000 11:21:58 -0800
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id LAA05146; Tue, 15 Feb 2000 11:24:50 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id LAA31613; Tue, 15 Feb 2000 11:21:57 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA71787
	for linux-list;
	Tue, 15 Feb 2000 11:01:26 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [163.154.5.24])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA97829;
	Tue, 15 Feb 2000 11:01:20 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id LAA16636;
	Tue, 15 Feb 2000 11:01:13 -0800
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
From:   "William J. Earl" <wje@cthulhu.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14505.41593.247197.385716@liveoak.engr.sgi.com>
Date:   Tue, 15 Feb 2000 11:01:13 -0800 (PST)
To:     "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>
Cc:     "Kevin D. Kissell" <kevink@mips.com>, linux@cthulhu.engr.sgi.com,
        Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: ioremap() broken?
In-Reply-To: <XFMail.000215181433.Harald.Koerfgen@home.ivm.de>
References: <00f001bf77a7$01e6cd10$0ceca8c0@satanas.mips.com>
	<XFMail.000215181433.Harald.Koerfgen@home.ivm.de>
X-Mailer: VM 6.74 under Emacs 20.3.1
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Harald Koerfgen writes:
 > 
 > On 15-Feb-00 Kevin D. Kissell wrote:
...
 > > It is a coincidence that ioremap() is so simple on most current MIPS 
 > > platforms.  On some systems, and on MIPS systems with more than 
 > > 512M of combined memory and mapped I/O, it would be necessary
 > > to invoke VM functions to create (and possibly wire) a kernel address
 > > mapping, and on such systems ioremap() would have some real work
 > > to do.
 > 
 > Yes, indeed. The Philips PR31700/Toshiba TMPR3912 is such a beast and I could
 > imagine that other MIPS based embedded CPUs tend to be similar.
 > 
 > On this particular CPU PCMCIA memory is accessed through *physical* addresses
 > 0x64000000-0x6bffffff, and thus unreachable through KSEG0 or KSEG1. To make
 > things even more delicate, this CPU is based on a R3000 core and supports 4kB
 > pages only, so even ye olde "let's create a wired TLB entry with 16 MB page
 > size"-trick will not work. 
...

     As part of the XFS port to Linux, Steve Lord (lord@sgi.com) has done
a function to map a set of pages into contiguous kernel virtual space,
where the kernel virtual space is dynamically allocated and released as
one acquires and releases the mapping.  (For calls which happen to resolve
to a single, statically-mapped page, the call can use the static mapping.)
This is presently embedded in a higher-level module, but it could be made
a separate facility.  The present implementation is inefficient, as it uses
an inefficient underlying Linux facility, but that could be fixed if there
much need for it.  Check with Steve Lord if interested.  The XFS source
is trickling out onto oss.sgi.com as we finished the encumbrance reviews,
but it will be at least a few weeks more before a compilable patch is
available.
