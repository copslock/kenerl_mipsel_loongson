Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 May 2003 14:03:49 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:42687 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225211AbTEFNDr>; Tue, 6 May 2003 14:03:47 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA07473;
	Tue, 6 May 2003 15:04:18 +0200 (MET DST)
Date: Tue, 6 May 2003 15:04:18 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Guo Michael <michael_e_guo@hotmail.com>
cc: linux-mips@linux-mips.org
Subject: Re: Which compiler should I use to make mips64 kernel
In-Reply-To: <BAY8-F125H3IhA1qfT700013d0f@hotmail.com>
Message-ID: <Pine.GSO.3.96.1030506144654.5097B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 6 May 2003, Guo Michael wrote:

> Hello, I want to build mips64el kernel and downloaded the mips64el 
> toolchain from ftp://ftp.ds2.pg.gda.pl/pub/macro/ (Maciej W. Rozycki's 
> site) and I got following errors:

 My 64-bit binutils package has `ld' that assumes output is to be 64-bit
ELF.  When fed with 32-bit ELF objects such as these created by `as -32'
(as invoked when building the kernel) it should convert them to 64-bit on
the fly, but it wasn't really ever tested and doesn't work.  There are two
immediate ways to deal with that: 

1. Add "-m elf32ltsmip" or "-m elf32btsmip" (depending on the endianness) 
to `ld' invocation (there is a commented-out example how to do this in
arch/mips64/Makefile).  This is probably the simplest and safest way to
deal with the problem.  It could probably be added to the CVS to avoid
confusion. 

2. Build all objects as 64-bit.  This will enlarge the kernel noticeably
and possibly reveal bugs.  I have a patch (or maybe a hack) to enable such
a setup if you were really interested. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
