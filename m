Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2007 18:23:48 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:146 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20031466AbXJWRXj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Oct 2007 18:23:39 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id D8D01400A5;
	Tue, 23 Oct 2007 19:23:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id lW3BEV73adwI; Tue, 23 Oct 2007 19:23:34 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 29FED40085;
	Tue, 23 Oct 2007 19:23:34 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9NHNcsi030602;
	Tue, 23 Oct 2007 19:23:39 +0200
Date:	Tue, 23 Oct 2007 18:23:33 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Sam Ravnborg <sam@ravnborg.org>
cc:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-arch@vger.kernel.org,
	linux-mips@linux-mips.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Discardable strings for init and exit sections
In-Reply-To: <20071012174507.GA21193@uranus.ravnborg.org>
Message-ID: <Pine.LNX.4.64N.0710231758070.8693@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0710121711120.21684@blysk.ds.pg.gda.pl>
 <20071012174507.GA21193@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4573/Tue Oct 23 14:01:01 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17188
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 12 Oct 2007, Sam Ravnborg wrote:

> What is the actual benefit here expressed in real numbers?
> For the __init/__exit notation that is yet only partially correct
> we often see corner cases where one ask if it is really worth it.
> Adding the discard functionality for strings seems like a logical extension
> but there is a benefit/pain ratio to consider.
> 
> So real numbers please.

 I have quoted some -- if you need more (I have left out all the 
non-allocatable sections for clarity):

$ mipsel-linux-readelf -S drivers/net/defxx.o
There are 26 section headers, starting at offset 0x3484:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 1] .text             PROGBITS        00000000 000040 0022a0 00  AX  0   0 16
  [ 3] .data             PROGBITS        00000000 0022e0 0000f0 00  WA  0   0 16
  [ 5] .bss              NOBITS          00000000 0023d0 000010 00  WA  0   0 16
  [ 6] .reginfo          MIPS_REGINFO    00000000 0023d0 000018 18   A  0   0  4
  [10] .exit.text        PROGBITS        00000000 002748 0000ec 00  AX  0   0  4
  [12] .init.text        PROGBITS        00000000 002834 000460 00  AX  0   0  4
  [14] .rodata.str1.4    PROGBITS        00000000 002c94 0004a4 01 AMS  0   0  4
  [15] .rodata           PROGBITS        00000000 003140 000080 00   A  0   0 16
  [17] .exitcall.exit    PROGBITS        00000000 0031c0 000004 00  WA  0   0  4
  [19] .initcall6.init   PROGBITS        00000000 0031c4 000004 00  WA  0   0  4
  [21] .init.str1        PROGBITS        00000000 0031c8 0001e0 01 AMS  0   0  4
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings)
  I (info), L (link order), G (group), x (unknown)
  O (extra OS processing required) o (OS specific), p (processor specific)

So with a quick calculation (`size' unfortunately gives confusing 
numbers): text is 10220 (init 1120, exit 236), data is 2044 and bss is 16 
bytes.  What you gain with this change is the space occupied by the 
.init.str1 section, worth 480 bytes, which would otherwise be resident.

> 1) We want to consolidate this in include/asm-generic/vmlinux*
> somehow and this should be doen as a separate step.

 Arguably all the existing linker scripts should be made more consistent I 
suppose.  Currently all the {init,exit} annotations are handled separately 
by each architecture, so this would be no exception.  If you have a 
proposal as to how to do it cleanly, people will certainly appreciate it.

> 2) If we introduce discardable strings then we shall in parallel
> add build time checks so we catch strings marked as discardable
> which is used outside a discardable compatible function.

 Well, `modpost' should already be taking care of this -- __init_begin and 
__init_end are defined for this purpose.

  Maciej
