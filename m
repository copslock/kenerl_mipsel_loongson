Received:  by oss.sgi.com id <S553678AbRCMQlp>;
	Tue, 13 Mar 2001 08:41:45 -0800
Received: from u-226-18.karlsruhe.ipdial.viaginterkom.de ([62.180.18.226]:7176
        "EHLO u-226-18.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553661AbRCMQlZ>; Tue, 13 Mar 2001 08:41:25 -0800
Received: from dea ([193.98.169.28]:4992 "EHLO dea.waldorf-gmbh.de")
	by bacchus.dhis.org with ESMTP id <S869415AbRCMOWy>;
	Tue, 13 Mar 2001 15:22:54 +0100
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f2DEMaG06514;
	Tue, 13 Mar 2001 15:22:36 +0100
Date:	Tue, 13 Mar 2001 15:22:36 +0100
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	K.H.C.vanHouten@kpn.com
Cc:	Adrian Bunk <bunk@fs.tum.de>, linux-mips@oss.sgi.com,
        K.H.C.vanHouten@research.kpn.com
Subject: Re: Compile error with current CVS kernel
Message-ID: <20010313152236.B1208@bacchus.dhis.org>
References: <20010313001520.A20673@bacchus.dhis.org> <200103130746.IAA07580@sparta.research.kpn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200103130746.IAA07580@sparta.research.kpn.com>; from K.H.C.vanHouten@research.kpn.com on Tue, Mar 13, 2001 at 08:46:43AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Mar 13, 2001 at 08:46:43AM +0100, Houten K.H.C. van (Karel) wrote:

> Hope this helps.

Against my low blood pressure - yes ...

>     LOAD off    0x0000000000000000 vaddr 0x0000000000001000 paddr 
> 0x0000000000001000 align 2**12
>          filesz 0x000000000000a184 memsz 0x000000000000a184 flags r--

This PT_LOAD entry shouldn't even exist ...

>     LOAD off    0x000000000000b000 vaddr 0xffffffff88002000 paddr 
> 0xffffffff88002000 align 2**12
>          filesz 0x00000000001acd10 memsz 0x00000000001d25a4 flags rwx


>  15 .kstrtab      00007c24  0000000000001b00  0000000000001b00  00000b00  2**2
>                   CONTENTS, ALLOC, LOAD, READONLY, DATA
>  16 __ksymtab     00001a60  0000000000009724  0000000000009724  00008724  2**2
>                   CONTENTS, ALLOC, LOAD, READONLY, DATA

That's scary - these sections are explicitly mentioned in the linker
script and yet ld places them near address zero.  Oh pleassure, oh
garbage.

This can probably be fixed by changing the ldscript; can experiment what
it takes to get your ld to place all sections with a LOAD attribute placed
next to each other?  My ld behaves fine.

  Ralf
