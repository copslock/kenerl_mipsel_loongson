Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g15FBlc14205
	for linux-mips-outgoing; Tue, 5 Feb 2002 07:11:47 -0800
Received: from chmls20.mediaone.net (chmls20.ne.ipsvc.net [24.147.1.156])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g15FBQA14155;
	Tue, 5 Feb 2002 07:11:26 -0800
Received: from localhost (h00a0cc39f081.ne.mediaone.net [65.96.250.215])
	by chmls20.mediaone.net (8.11.1/8.11.1) with ESMTP id g15FCZx09366;
	Tue, 5 Feb 2002 10:12:35 -0500 (EST)
Date: Tue, 5 Feb 2002 10:10:29 -0500
Subject: Re: PATCH: Fix ll/sc for mips (take 3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v480)
Cc: Jay Carlson <nop@nop.com>, Dominic Sweetman <dom@algor.co.uk>,
   Hiroyuki Machida <machida@sm.sony.co.jp>, hjl@lucon.org,
   linux-mips@oss.sgi.com
To: Ralf Baechle <ralf@oss.sgi.com>
From: Jay Carlson <nop@nop.com>
In-Reply-To: <20020205092811.C2582@dea.linux-mips.net>
Message-Id: <7E232BAE-1A4A-11D6-927F-0030658AB11E@nop.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.480)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


On Tuesday, February 5, 2002, at 03:28 AM, Ralf Baechle wrote:

> On Tue, Feb 05, 2002 at 01:16:46AM -0500, Jay Carlson wrote:
>
>> Given that I tossed out the SVR4 ABI in search of code density in snow,
>> I'm probably a little abnormal in these concerns.  But other people on
>> small platforms may care.
>
> SNOW certainly was a nice invention and the definition of small is
> changing.  Are you planning to keep up the support for SNOW?

Yeah, although it's slow going.  As usual, "which toolchain" plays a 
major part in the delay :-)

(Quick background for the list: Because there's such a large code size 
penalty to PIC/abicalls, I resurrected the bad old Linux/SVR3 statically 
linked, dynamically loaded libraries, which are linked at absolute 
locations.  Shane Nay took this from a cute demo to a working 
distribution for the Agenda VR3; Brian Webb helped.  Typical code 
reduction is ~25-40%, eg 391k->272k.)

I think I finally have a working jumptable implementation, which should 
allow (careful!) upgrades of libraries without triggering app rebuilds.  
The pain was not actually jumptables themselves; it was getting all 
exported data in a library shuffled around so it could live at fixed 
addresses.  -fdata-sections let me do most of this with linker scripts.  
Unfortunately, g++ was still emitting "int foo;" in ".bss", so I had to 
fix it to generate the proper ".bss.foo".

I created a toolchain builder based on the RH71 SRPMs.  About halfway 
through this, I remembered why I hadn't upgraded from glibc 2.0 to 2.2 
before---the library size doubled.  So after getting a few huge 
statically linked executables tested to make sure the toolchain was 
sound, I backtracked to uclibc and the old Agenda glibc "2.0.7".  I have 
plausible-looking builds of both, but I haven't actually run them on 
real hardware.....

(Is there any hope of patching glibc 2.2.4 with the sglibc patches?  If 
so, how?)

I started writing a /lib/ld-snow.so.1 to get the library loading code 
out of the main body of executables.

I'm hoping to have a beta of a full toolchain/library build tool shipped 
this weekend or next, and from there hook into the community efforts to 
automate rebuilding the Agenda VR3 from source.  I figure X and a pile 
of C++ fltk apps will expose any lingering bugs in the toolchain and new 
bugs in the shared library mechanism.

I'd like to be less Agenda-centric.  I think this work would benefit the 
Helio as well as other small platforms.  But as you say, the definition 
of "small" is changing; hopefully in few years, machines will be big 
enough to support the SVR4 ABI without second thoughts.  I don't know; 
it's possible that the really low end machines will just get cheaper 
instead of bigger.

Speaking of small, anybody have a Linux box with a CPU with working 
MIPS16 support?  (Other than Vr41xx; I have plenty of those to test 
on.)  I have a small test case I'd like someone to run.

Jay
