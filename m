Received:  by oss.sgi.com id <S305190AbQAGCBL>;
	Thu, 6 Jan 2000 18:01:11 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:27504 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305175AbQAGCA7>;
	Thu, 6 Jan 2000 18:00:59 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA01658; Thu, 6 Jan 2000 18:01:43 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA63742
	for linux-list;
	Thu, 6 Jan 2000 17:51:05 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [163.154.5.24])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA62708;
	Thu, 6 Jan 2000 17:50:57 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id RAA29862;
	Thu, 6 Jan 2000 17:50:36 -0800
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
From:   "William J. Earl" <wje@cthulhu.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14453.18027.601606.841041@liveoak.engr.sgi.com>
Date:   Thu, 6 Jan 2000 17:50:35 -0800 (PST)
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     "Kevin D. Kissell" <kevink@mips.com>,
        Florian Lohoff <flo@rfc822.org>, linux@cthulhu.engr.sgi.com
Subject: Re: Decstation 5000/150 2.3.21 Boot successs
In-Reply-To: <20000107005420.C17537@uni-koblenz.de>
References: <00ef01bf5859$6d11f410$0ceca8c0@satanas.mips.com>
	<20000107005420.C17537@uni-koblenz.de>
X-Mailer: VM 6.74 under Emacs 20.3.1
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Ralf Baechle writes:
 > On Thu, Jan 06, 2000 at 04:19:27PM +0100, Kevin D. Kissell wrote:
 > 
 > > >If that's desired, how about providing a syscall which allows to manipulate
 > > >this and possibly other bits?
 > > 
 > > I very much prefer the idea of having exec() to the right thing, so
 > > that 32/32 fpr and o32 ABI programs can be mixed and matched
 > > as appropriate - assuming, of course, that there's sufficient information
 > > in the binary header to do the job!  In practical terms, given that
 > > Linux is a multiuser and multitasking system, a syscall that throws
 > > some sort of global switch could only be safely invoked once
 > > at boot time, and as such offers little advantage over hardwired
 > > kernel code.
 > 
 > I was suggesting such a syscall because embedded people have asked me about
 > making the 32/32 fpr model available to `normal' o32 code.  N32 won't work
 > for them for practical reasons (linker tooo buggy) and 64-bit ABI is
 > unacceptable for size / tlb / cache reasons.

       It could work, but only for very carefully constructed code.
The regular gcc code generation (and matching glibc) for o32 will give
wrong answers with FR=1.  If people really want "o32" with FR=1, then
they need to build yet another binary type, "o32FR1" or some such, with
different code generation rules.  Fundamentally, any code which loads
a double using a pair of lwc1 instructions will get the wrong answer
if FR=1.

 > For the general case you're of course right, exec() should do the right
 > thing.  And modulo the bug we're discussing here the 32-bit kernel already
 > does the right thing to handle the general case.
 > 
 >   Ralf
