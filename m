Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jan 2003 06:56:16 +0000 (GMT)
Received: from p508B65B9.dip.t-dialin.net ([IPv6:::ffff:80.139.101.185]:44955
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225194AbTA1G4Q>; Tue, 28 Jan 2003 06:56:16 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h0S6uAP20913;
	Tue, 28 Jan 2003 07:56:10 +0100
Date: Tue, 28 Jan 2003 07:56:10 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Chien-Lung Wu <cwu@deltartp.com>
Cc: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: mips cross-compiler
Message-ID: <20030128075610.B20541@linux-mips.org>
References: <A4E787A2467EF849B00585F14C9005590689D3@dprn03.deltartp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <A4E787A2467EF849B00585F14C9005590689D3@dprn03.deltartp.com>; from cwu@deltartp.com on Mon, Jan 27, 2003 at 04:53:38PM -0500
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1242
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 27, 2003 at 04:53:38PM -0500, Chien-Lung Wu wrote:

> from ftp://oss.sgi.com/pub/linux/mips

The Linux/MIPS project has moved to (guess ...) linux-mips.org.  oss
still contains a mirror of ftp.linux-mips.org but it's only updated
manually in irregular intervals.

> When I use rpm comand to install binutils and egcs, they work fine.
> 	rpm -i binutils-mips-linux-2.8.1-1-i386.rpm
> 	rpm -i egcs-mips-linux-1.0.3a-2.i386.rpm
> 
> However, as I intsall the glibc with the rpm command:
> 	rpm -i glibc-2.1.95.1.mips.rpm
> 
> I got a confliction with glibc-common-2.2.4-13, since my native glibc is
> 2.2.4-13. Thus I cannot install glibc.
> 
> Can anybody show me how to install the cross-compiler correctly? (what is
> the correct rpm command?)

Rpm just saved your system.  If you're installing this MIPS glibc into a
crosscompiler machine as it seems then keep your CDROM at hand for
reinstallation.  You will need it ...

> More questions:
> If I have native glibc, can I install another glibc for cross-compiler?

Sure, they have nothing in common.

> Can I install the binutils-mips-linux-2.8.1-1 to a specific path?  How?
> ( when I install them with rpm -i command, the executable files will go to
> /usr/bin as default. Can I change that?)

Only very few packages support that; these packages don't.

You will not be able to build a kernel with binutils 2.8.x or egcs 1.0.x.
The absolute minimum required to build a kernel is egcs 1.1.2 and
binutils 2.13.1 which you can download from ftp.linux-mips.org.  Cross-
compiling a kernel does not require the installation of a MIPS glibc on
the crosscompilation host.  If you're going to crosscompile application
software you'll need a much more recent gcc even.

  Ralf
