Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Oct 2010 12:50:38 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52964 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491029Ab0J1Kud (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Oct 2010 12:50:33 +0200
Date:   Thu, 28 Oct 2010 11:50:33 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Camm Maguire <camm@maguirefamily.org>
cc:     David Daney <ddaney@caviumnetworks.com>,
        linux-mips <linux-mips@linux-mips.org>,
        debian-mips@lists.debian.org, gcl-devel@gnu.org
Subject: Re: [Gcl-devel] Re: gdb for mips64
In-Reply-To: <87vd4or9v9.fsf@maguirefamily.org>
Message-ID: <alpine.LFD.2.00.1010281109480.25426@eddie.linux-mips.org>
References: <E1OwbkA-0006gv-Bi@localhost.m.enhanced.com>        <4C93993E.7030008@caviumnetworks.com>        <8762y49k1k.fsf@maguirefamily.org>        <4C93D86D.5090201@caviumnetworks.com>        <87fwx4dwu5.fsf@maguirefamily.org>       
 <4C97D9A1.7050102@caviumnetworks.com>        <87lj6te9t1.fsf@maguirefamily.org>        <4C9A8BC9.1020605@caviumnetworks.com>        <4C9A9699.6080908@caviumnetworks.com>        <87pqvbs7oa.fsf@maguirefamily.org>        <4CB88D2C.8020900@caviumnetworks.com>
        <87r5fksxby.fsf_-_@maguirefamily.org>        <4CBF1B1E.6050804@caviumnetworks.com>        <8762wwlfen.fsf@maguirefamily.org>        <4CC06826.2070508@caviumnetworks.com>        <4CC0787C.2040902@caviumnetworks.com>        <878w1m3qmn.fsf_-_@maguirefamily.org>
        <4CC5FA72.6080005@caviumnetworks.com>        <87k4l52eqb.fsf@maguirefamily.org> <87vd4or9v9.fsf@maguirefamily.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28267
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 26 Oct 2010, Camm Maguire wrote:

> > Why doesn't _IO_getc get a stub on mips64, like say _setjmp?
> >
> > readelf -a saved_ansi_gcl |grep  IO_getc
> >   2812: 0000000000000000   472 FUNC    GLOBAL DEFAULT  UND _IO_getc@GLIBC_2.0 (2)
> >  15315: 0000000000000000   472 FUNC    GLOBAL DEFAULT  UND _IO_getc@@GLIBC_2.0
> > readelf -a saved_ansi_gcl |grep  setjmp
> >   2159: 00000001204b9b40    32 FUNC    GLOBAL DEFAULT  UND _setjmp@GLIBC_2.0 (2)
> >  15978: 00000001204b9b40    32 FUNC    GLOBAL DEFAULT  UND _setjmp@@GLIBC_2.0
> >  
> > Is there anything I can do about this?
> >
> 
> A little more info here.  Latest toolchain on the gcc compile farm
> does provide a stub, but the slightly older gentoo on a sicortex
> machine does not.  Clearly not too much to worry about unless you
> might know of an easy workaround.

 Can you quote what `ld --version' says on the affected system?

 It *might* be a linker bug, though the exact circumstances may be 
complicated as I have n64 MIPS64 binaries as old as from mid 2005 with a 
stub for _IO_getc() correctly installed.  Nobody should be using any older 
binutils, especially with the MIPS64 target as 64-bit support for MIPS was 
quite immature back then.  I suggest that you switch to binutils 2.20.1; 
version 2.21 is due out in a couple of weeks too.

 A legitimate cause for a stub to be omitted by the linker are pointer 
references to the function in question as in this case the symbol has to 
be fully resolved for pointer comparison to produce reliable results.  It 
could be that one version of GCC produces code that looks to the linker as 
if referring to the symbol this way (i.e. the object files presented to 
the linker contain relocations normally used for data references rather 
than function calls associated with the symbol in question).  You can 
determine if that is the case by running `objdump -r' on the program's 
object files used in the final link and checking if there are any GOT 
relocations (that'll be a part of their names, e.g. R_MIPS_GOT_PAGE) 
against _IO_getc.  Again, that *might* be a GCC bug then.

 That said the only impact from a missing stub is a small program startup 
performance penalty as lazy binding cannot be applied to this single 
symbol only and the symbol has to be fully resolved at startup.

  Maciej
