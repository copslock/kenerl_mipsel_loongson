Received:  by oss.sgi.com id <S42333AbQFTRO5>;
	Tue, 20 Jun 2000 10:14:57 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:29741 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42328AbQFTROo>;
	Tue, 20 Jun 2000 10:14:44 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id KAA09917
	for <linux-mips@oss.sgi.com>; Tue, 20 Jun 2000 10:09:44 -0700 (PDT)
	mail_from (frank_rowand@mvista.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA95018
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 20 Jun 2000 10:14:11 -0700 (PDT)
	mail_from (frank_rowand@mvista.com)
Received: from hermes.mvista.com (gateway-490.mvista.com [63.192.220.206]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA09915
	for <linux@cthulhu.engr.sgi.com>; Tue, 20 Jun 2000 10:14:06 -0700 (PDT)
	mail_from (frank_rowand@mvista.com)
Received: from mvista.com (IDENT:frowand@mossi.mvista.com [10.0.0.71])
	by hermes.mvista.com (8.9.3/8.9.3) with ESMTP id KAA31112;
	Tue, 20 Jun 2000 10:11:46 -0700
Message-ID: <394FA5D1.DDAEA1F6@mvista.com>
Date:   Tue, 20 Jun 2000 10:11:45 -0700
From:   Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
Organization: Montavista Software, Inc
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
CC:     Linux kernel <linux-kernel@vger.rutgers.edu>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux/MIPS Development <linux@cthulhu.engr.sgi.com>
Subject: Re: Proposal: non-PC ISA bus support
References: <Pine.GSO.4.10.10006201254290.8592-100000@dandelion.sonytel.be>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Geert Uytterhoeven wrote:
> 
> The following patch fixes 2 problems related to ISA bus access on non-PC
> platforms:
> 
>  1. ISA I/O space is memory mapped on many platforms (e.g. PPC and MIPS). To
>     access it from user space, you cannot plainly use inb() and friends like on
>     PC, but you have to mmap() the correct region of /dev/mem first. This
>     region depends on the machine type and currently there's no simple way to
>     find out from user space.
> 
>  2. ISA memory is not located at physical address 0 on many platforms (e.g. PPC
>     and some MIPS boxes). This means you cannot e.g. use
>     request_mem_region(0xa0000, 65536) to request the legacy VGA region.
> 
> Solutions:
> 
>  1. Provide /proc/bus/isa/map, which contains the ISA I/O and memory space
>     mappings on machines where these are memory mapped.
> 
>     Example (on PPC CHRP LongTrail):
> 
>         callisto$ cat /proc/bus/isa/map
>         f8000000        01000000        IO
>         f7000000        01000000        MEM
>         callisto$
> 
>     The region marked `IO' is ISA (also PCI) I/O space, while the region marked
>     `MEM' is ISA memory space. Of course on a PC the first one is not
>     available because there are separate I/O and memory spaces on ia32.
> 
>  2. Provide new resource management functions for ISA memory space:
> 
>         isa_request_mem_region()
>         isa_check_mem_region()
>         isa_release_mem_region()
> 
>     On ia32, these are identical to the normal memory resource management
>     functions.
> 
>     [ Alternatively we could add tests to the *_mem_region() functions to test
>       whether the requested region is < 16 MB (and thus in ISA memory space)
>       and add the required offset. But this affects the common resource code
>       and may cause problems on machines where there is no ISA space in the
>       first 16 MB of memory space. ]
> 
> The patch contains support for ia32, PPC and MIPS (limited to DDB Vrc-5074).
> It was tested on PPC only.
> 
> Comments are welcomed!

Would it make sense to apply the same sort of fix to the following code in
__ioremap(), so that ISA space is handled consistently?:

        /*
         * If the address lies within the first 16 MB, assume it's in ISA
         * memory space
         */
        if (p < 16*1024*1024)
            p += _ISA_MEM_BASE;


< patch deleted >


> 
> Gr{oetje,eeting}s,
> 
>                                                 Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                                             -- Linus Torvalds
> 
> ** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

-Frank
-- 
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc
