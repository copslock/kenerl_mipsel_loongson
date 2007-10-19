Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Oct 2007 12:59:39 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:30357 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20044194AbXJSL7b (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Oct 2007 12:59:31 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 6D516400A4;
	Fri, 19 Oct 2007 13:59:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id TwylKxGsnR4r; Fri, 19 Oct 2007 13:59:26 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 3712540083;
	Fri, 19 Oct 2007 13:59:26 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9JBxS6G027334;
	Fri, 19 Oct 2007 13:59:28 +0200
Date:	Fri, 19 Oct 2007 12:59:25 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [RFC] Add __initbss section
In-Reply-To: <4717C1FB.4030602@gmail.com>
Message-ID: <Pine.LNX.4.64N.0710191239490.13279@blysk.ds.pg.gda.pl>
References: <470DF25E.60009@gmail.com> <Pine.LNX.4.64N.0710111307180.16370@blysk.ds.pg.gda.pl>
 <4712738A.5000703@gmail.com> <Pine.LNX.4.64N.0710151311350.16262@blysk.ds.pg.gda.pl>
 <4713C840.8080206@gmail.com> <Pine.LNX.4.64N.0710161123110.22596@blysk.ds.pg.gda.pl>
 <4717C1FB.4030602@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4545/Wed Oct 17 23:05:57 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17129
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 18 Oct 2007, Franck Bui-Huu wrote:

> So it seems there is no way from a linker script to specify that a
> section has the nobits type, is it ?

 Well, you cannot switch section types in a linker script at all in 
general.  The place to do it is always in the assembler, which is the tool 
which actually emits this data.

> After spending some fun time trying several different configurations
> with gcc and ld, I noticed that gcc makes a section with @nobits
> attribute if the section name starts with .bss.*

 Exactly how GCC sets section flags is mostly determined by 
default_section_type_flags() in gcc/varasm.c; some flags are set elsewhere 
too.  This is with HEAD of GCC.

> Another test I did is to put .init.bss (not .bss.init) section right
> before .bss section in order to have only one segment to load. And it
> makes magically ld do the right thing. I must admit that I don't
> understand why, and the lack of documentation doesn't help...

 Hmm, isn't what `info ld' says enough?  I think a look at what the SysV 
ABI documents say about ELF could clarify some matters too.  Also have a 
look at how sections are mapped to segments as after the final link it is 
segments that matter -- `readelf -l' will do.

> Unfortunately I don't know if we can rely on one of these
> behaviours. IOW if they're going to work with all supported versions
> of gcc/ld.

 Probably -- I guess you only need to check what GCC 3.2 did.  Or you 
could use a hack with __attribute__((section())) like one I did for 
merging strings -- unlike with SECTION_BSS I think there is no way to 
request (SECTION_MERGE | SECTION_STRINGS) in an implicit way anyhow.

  Maciej
