Received:  by oss.sgi.com id <S305158AbQCISdH>;
	Thu, 9 Mar 2000 10:33:07 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:17448 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305154AbQCIScw>; Thu, 9 Mar 2000 10:32:52 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id KAA01126; Thu, 9 Mar 2000 10:36:09 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA31292
	for linux-list;
	Thu, 9 Mar 2000 10:10:22 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [163.154.5.24])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA04546
	for <linux@relay.engr.sgi.com>;
	Thu, 9 Mar 2000 10:10:20 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id KAA20838
	for linux@engr.sgi.com; Thu, 9 Mar 2000 10:10:19 -0800
Date:   Thu, 9 Mar 2000 10:10:19 -0800
Message-Id: <200003091810.KAA20838@liveoak.engr.sgi.com>
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Tim Wilkinson <tim@transvirtual.com>
Cc:     linux-mips@fnet.fr, linux-mips@vger.rutgers.edu,
        linux@cthulhu.engr.sgi.com
Subject: Re: Mips/Linux integration of latest GCC, Binutils & GLibc
In-Reply-To: <38C6BE35.C58B0630@transvirtual.com>
References: <38C54F05.458A3EFE@transvirtual.com> <20000308140301.B1425@uni-koblenz.de> <38C6A5D4.F08DFCE4@transvirtual.com> <20000308174251.A6399@uni-koblenz.de> <38C6BE35.C58B0630@transvirtual.com>
X-Mailer: Mutt 1.0pre3us
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, Mar 08, 2000 at 08:55:17PM +0000, Tim Wilkinson wrote:

> Okay this makes sense.  This then means there's a problem with GLIBC since it
> excludes certain files when building a static library but unfortuantely
> needs them because it uses #ifdef PIC to include bits of code related to
> shared library workings (essentially it considers PIC to mean SHARED when
> this may not infact be the case - not for MIPS anyway).
> 
> So what you're saying is pretty much how I have my gcc, binutils and glibc
> set up - I introduced a -DSHARED to glibc (which I suspect isn't really
> okay) when building shared libraries so static libraries didn't include
> the bad code.  I may look for a better solution however.

Indeed.  The problem is just that Ulrich drepper didn't accept such a patch
the last time I sent it to him.

> I've also made a bunch of elf related changes to mips/linux so that the
> assembler output from gcc is more like the elf output for the x86/linux
> targets.  It's interesting to note that mips/linux doesn't even defined
> linux for CPP (and doesn't do a bunch of other stuff either come to that)
> which confused things no end when compiling the linux kernel.

Go to oss.sgi.com and get /pub/linux/mips/src/egcs/egcs-1.0.3a-2.diff.gz
and integrate that with a current egcs.  This is what most people are
using and is known to work.  It generates assembler output that is known
to be working with binutils and even halfway human-readable as far as this
can be said from compiler output.  You'll also find binutils test patches
for more current releases there.

  Ralf
