Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Oct 2010 16:25:55 +0200 (CEST)
Received: from bitwagon.com ([74.82.39.175]:39577 "HELO bitwagon.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S1491140Ab0JXOZv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 24 Oct 2010 16:25:51 +0200
Received: from f11-64.local ([67.171.188.169]) by bitwagon.com for <linux-mips@linux-mips.org>; Sun, 24 Oct 2010 07:25:39 -0700
Message-ID: <4CC441C9.8070206@bitwagon.com>
Date:   Sun, 24 Oct 2010 07:25:13 -0700
From:   John Reiser <jreiser@bitwagon.com>
Organization: -
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc11 Thunderbird/3.0.4
MIME-Version: 1.0
To:     wu zhangjin <wuzhangjin@gmail.com>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [RFC 2/2] ftrace/MIPS: Add support for C version of recordmcount
References: <AANLkTinwXjLAYACUfhLYaocHD_vBbiErLN3NjwN8JqSy@mail.gmail.com>
In-Reply-To: <AANLkTinwXjLAYACUfhLYaocHD_vBbiErLN3NjwN8JqSy@mail.gmail.com>
X-Enigmail-Version: 1.0.1
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <jreiser@bitwagon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28218
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jreiser@bitwagon.com
Precedence: bulk
X-list: linux-mips

Hi, here is the diagnosis for SIGSEGV in recordmcount.c on MIPS64:

On 10/23/2010, wu zhangjin wrote:
>   CC      init/main.o
> /bin/sh: line 1: 21835 Segmentation fault     scripts/recordmcount "init/main.o"
> make[1]: *** [init/main.o] Error 139
> make: *** [init] Error 2
> 
> I traced the problem and found it was triggered by the 201 line of
> scripts/recordmcount.h:
> 
> 198                 if (!mcountsym) {
> 199                         Elf_Sym const *const symp =
> 200                                 &sym0[ELF_R_SYM(_w(relp->r_info))];
> *201                         char const *symname = &str0[w(symp->st_name)];*
> 202
> 203                         if ('.' == symname[0])
> 204                                 ++symname;  /* ppc64 hack */
> 
> Exactly, it was triggered by: symp->st_name, symp is normal address,
> i.e. 0xa01831f0, but perhaps the content pointed by this address may
> not exist or is not allocated before?
> 
> Did I miss something for MIPS specific support?

The layout of a MIPS structure Elf64_Rela is not described correctly
by the macros ELF64_R_SYM and ELF64_R_TYPE of <elf.h>:
-----
#define ELF64_R_SYM(i)                  ((i) >> 32)
#define ELF64_R_TYPE(i)                 ((i) & 0xffffffff)
-----

"readelf main.o" says:
-----
Relocation section '.rela.text' at offset 0x5b68 contains 59 entries:
  Offset          Info           Type           Sym. Value    Sym. Name + Addend
000000000020  004200000004 R_MIPS_26         0000000000000000 _mcount + 0
                    Type2: R_MIPS_NONE
                    Type3: R_MIPS_NONE
-----

The actual bytes are [performed on a little-endian machine,
which is the same as main.o, namely ELFDATA2LSB]:
-----
$ od -Ax -tx8 -j0x5b68 main.o  |  sed 2q
005b68 0000000000000020 0400000000000042
005b78 0000000000000000
-----

So it looks like the data actually corresponds to:
-----
#define MIPS_ELF64_R_TYPE(i)  (0xff & ((i)>>56))
#define MIPS_ELF64_R_TYPE2(i) (0xff & ((i)>>48))
#define MIPS_ELF64_R_TYPE3(i) (0xff & ((i)>>40))
#define MIPS_ELF64_R_SYM(i)   (0xffffffff & (i))  /* perhaps 40 bits? */
-----

What this means for recordmcount.c is that ELF_R_SYM and ELF_R_TYPE
should become pointers to functions with default bodies given by
the macros in <elf.h>, and which EM_MIPS overrides.


> for kernel:
>     #     14:   0c000000        jal     0
>     #                    14: R_MIPS_26   _mcount

> for module:
>     #       c:  3c030000        lui     v1,0x0
>     #                   c: R_MIPS_HI16  _mcount

I suggest that the argv command line for recordcmount.c have an
optional flag -m or --module, such that the correct reltype can
be chosen when .e_machine is decoded.

> (Note: The above patch is not enough, for the modules with
> -mlong-calls, the reltype should be R_MIPS_HI16, and we may also need
> to add our specific code for sift_rel_mcount() to get the right
> location of the _mcount calling site)

"-mlong-calls" must set .e_flags, or otherwise provide enough
description to that the correct reltype can be chosen at the time
when .e_machine is decoded.  Adjusting the address for the location
of the call to _mcount should be another function pointer that is
overridden for EM_MIPS.

Regards,

-- 
John Reiser, jreiser@BitWagon.com
