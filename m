Received:  by oss.sgi.com id <S42215AbQJFNwI>;
	Fri, 6 Oct 2000 06:52:08 -0700
Received: from ppp0.ocs.com.au ([203.34.97.3]:34828 "HELO mail.ocs.com.au")
	by oss.sgi.com with SMTP id <S42201AbQJFNv5>;
	Fri, 6 Oct 2000 06:51:57 -0700
Received: (qmail 5773 invoked from network); 6 Oct 2000 13:51:53 -0000
Received: from ocs3.ocs-net (192.168.255.3)
  by mail.ocs.com.au with SMTP; 6 Oct 2000 13:51:53 -0000
X-Mailer: exmh version 2.1.1 10/15/1999
From:   Keith Owens <kaos@ocs.com.au>
To:     Gordon McNutt <gmcnutt@ridgerun.com>
cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: insmod hates RELA? 
In-reply-to: Your message of "Fri, 06 Oct 2000 07:22:14 MDT."
             <39DDD206.19443FAB@ridgerun.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Sat, 07 Oct 2000 00:51:52 +1100
Message-ID: <23467.970840312@ocs3.ocs-net>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

>But I'm not there yet. insmod (2.3.9) now complains about a relocation
>overflow on all of the kernel symbols.

modutils 2.3.9 is quite old, the released version is up to 2.3.17.
ftp.<country>.kernel.org/pub/linux/kernel/utils/modutils/v2.3.

>I'm looking at the source for insmod
>now. At the moment I'm trying to figure out why insmod wants to relocate
>kernel symbols.

It does not relocate kernel symbols, they have fixed values.  What it
does is fix up references from modules to kernel symbols, the modules
have relocation references to external symbols and those external
symbols have to be filled in.

>I've looked a little more since writing the above. The relocation errors are
>occurring in the .bss section, where it appears insmod is iterating over all
>references to a symbol and doing a relocation. The type of relocation done
>for all symbols is associated with the 'R_MIPS_26' #define (see linux/elf.h).
>Is this a bug in insmod?

Don't think so, rather it is appears to be gcc assuming that some
symbols can be accessed via $GP+26 bits.  I don't have a MIPS ELF
manual handy at the moment so I am guessing that you need -mlong-calls
for modules.
