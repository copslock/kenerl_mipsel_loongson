Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3ID4X8d020834
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 18 Apr 2002 06:04:33 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3ID4XZn020833
	for linux-mips-outgoing; Thu, 18 Apr 2002 06:04:33 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from rwcrmhc51.attbi.com (rwcrmhc51.attbi.com [204.127.198.38])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3ID4P8d020821
	for <linux-mips@oss.sgi.com>; Thu, 18 Apr 2002 06:04:25 -0700
Received: from localhost ([65.96.250.215]) by rwcrmhc51.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020418130522.ZRYH1143.rwcrmhc51.attbi.com@localhost>;
          Thu, 18 Apr 2002 13:05:22 +0000
Date: Thu, 18 Apr 2002 09:05:39 -0400
Subject: FYI: release of snow toolchain builder 1.4
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v481)
From: Jay Carlson <nop@nop.com>
To: linux-mips@oss.sgi.com
Content-Transfer-Encoding: 7bit
Message-Id: <FB40A540-52CC-11D6-A0DC-0030658AB11E@nop.com>
X-Mailer: Apple Mail (2.481)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I finally got around to writing a built-from-bare-sources toolchain for 
snow.  snow's an alternate ABI for small MIPS systems which uses 
statically linked dynamically loaded shared libraries in -fno-pic 
-mno-abicalls mode.  It has massive performance advantages on the Agenda 
VR3's Vr4181.

New in this release is jumptable support; when used properly, it should 
allow careful library maintainers to provide forward binary 
compatibility against shared libraries.

Snow could be the basis for MIPS16 work, since -fpic MIPS16 looks 
difficult.  However, the compiler I currently use, Debian gcc 2.95.4, is 
completely broken for -mips16.  (I'd say "can't compile dhrystone" is a 
good metric.  :-)  If anybody sends me a known-good MIPS16 platform, I'd 
be delighted to make snow work on it.  (At this point, getting MIPS16 
working under Linux is a matter of personal honor to me.)

For background information on snow, see 
http://www.desertscenes.net/agenda/snow/ , although it's slightly out of 
date.  The vrp stuff mentioned below is documented at 
http://www.desertscenes.net/index.cgi/Agenda_20Romdisk_20Building_20Instructions 
but is unlikely to be useful for other platforms as-is.

Here's the announcement I made on the agenda-snow mailing list:

snow-build-1.4 is available at http://place.org/~nop/snow-
build-1.4.tar.gz .  It builds a complete snow toolchain from sources, 
using the new jumptable snow implementation, which may allow for 
forwards binary compatibility of libraries.  Also, it can build XFree86 
4.2.0 for the Agenda from sources, including shared library-linked 
executables of many xc apps.

Note that it is not compatible with the Agenda 1.2.0 toolchain, and it 
is likely that there will be a period of thrashing out library export 
lists that will break apps linked with it; however, this should improve 
future compatibility.

Included in this release is an experimental interface to Brian Webb's 
snow distribution and build tools.  It will build a working (if somewhat 
minimal) romdisk.  Some changes to other source packages will be 
required; Debian gcc-2.95.4 has a different set of quirks from the gcc 
snapshot used previously, and ideally applications should switch from 
CC='mipsel-linux-gcc -B/opt/snow-gcc/lib/snow/' to 
CC='mipsel-linux-snow-gcc' to get rid of fixed paths in the build 
process.  (Of course VRP sources that use ${VRP_COMPILER_CC} get this 
for free.)

Documentation remains minimal, but hopefully not much is required to at 
least watch the pretty build scroll by.

Necessary sources are again mirrored at http://vhl-
tools.sf.net/snow-src/ .

Gloating summary: after downloading the required source tarballs, you 
edit a config file to tell it where to build.  Then, you type "make" in 
builder/ and "make" in vrp-build/, and around 45 minutes later out pops 
a romdisk!

Let me know if it doesn't build on your box.  The only two odd tools 
you'll need are for the vrp-build section.  ash wants byacc.  I want 
fakeroot, http://packages.debian.org/testing/utils/fakeroot.html , 
because I don't believe in building software as root.  If you're daring, 
you can run the vrp-build section as root and nuke the calls to fakeroot.

Jay
