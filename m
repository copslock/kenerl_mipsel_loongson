Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jun 2006 04:50:47 +0200 (CEST)
Received: from ug-out-1314.google.com ([66.249.92.172]:61374 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S8126497AbWFBCuj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Jun 2006 04:50:39 +0200
Received: by ug-out-1314.google.com with SMTP id k3so399964ugf
        for <linux-mips@linux-mips.org>; Thu, 01 Jun 2006 19:50:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S6d731p7kceQ9eBSauhBr8lHGz2rn8yZLHwXeb4oN3wGN0NiTtMosH5jQt3W1C/IoU6Ui66lE86s+cZZAKcP21Lr1b0/u23grhI+DPEqOJ5Tz5hXZsUax3aboofT1Xl+AQT5BklzVn2WFz1w7mkRtYpPB9+mLybL0boClQfPtLA=
Received: by 10.67.106.3 with SMTP id i3mr339040ugm;
        Thu, 01 Jun 2006 19:50:35 -0700 (PDT)
Received: by 10.66.241.4 with HTTP; Thu, 1 Jun 2006 19:50:35 -0700 (PDT)
Message-ID: <50c9a2250606011950h7669c9a7w375e54cf513dcee@mail.gmail.com>
Date:	Fri, 2 Jun 2006 10:50:35 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	"Nigel Stephens" <nigel@mips.com>
Subject: Re: BFD: Warning: Writing section `.text' to huge (ie negative) file offset 0xa1ffff10
Cc:	"Thiemo Seufer" <ths@networkno.de>,
	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <50c9a2250606011749r7f89fbben2c61edd43c7ec0a6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <50c9a2250605312319v7480f2el36d9c0a052c85d5f@mail.gmail.com>
	 <20060601092413.GL1717@networkno.de>
	 <50c9a2250606010356s63f6d6e7j255c77660d6f472a@mail.gmail.com>
	 <447EE274.7060207@mips.com>
	 <50c9a2250606011749r7f89fbben2c61edd43c7ec0a6@mail.gmail.com>
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

On 6/2/06, zhuzhenhua <zzh.hust@gmail.com> wrote:
> On 6/1/06, Nigel Stephens <nigel@mips.com> wrote:
> >
> >
> > zhuzhenhua wrote:
> > > On 6/1/06, Thiemo Seufer <ths@networkno.de> wrote:
> > >> zhuzhenhua wrote:
> > >> > i have write a code to link at 0xa2000000(uncached address)
> > >> > but when link i get the error as
> > >> > "BFD: Warning: Writing section `.text' to huge (ie negative) file
> > >> > offset 0xa1ffff10.
> > >> > BFD: Warning: Writing section `.data' to huge (ie negative) file
> > >> > offset 0xa200b050.
> > >> > BFD: Warning: Writing section `.reginfo' to huge (ie negative) file
> > >> > offset 0xa200c980.
> > >> > mipsel-linux-objcopy: /root/project/brec_flash/release/brec_flash.bin:
> > >> > File truncated
> > >> > make: *** [brec_flash] Error 1"
> > >> >
> > >> > my link.xn as follow:
> > >> >
> > >> > OUTPUT_ARCH(mips)
> > >> > ENTRY(brec_flash_entry)
> > >> > SECTIONS
> > >> > {
> > >> > .text 0xa2000000 :
> > >>
> > >> Use
> > >>
> > >>  . = 0xa2000000;
> > >>  .text :
> > >>
> > >> instead. "info ld" explains the subtle difference.
> > >>
> > >>
> > >> Thiemo
> > >>
> > >
> > > do you mean use
> > > . = 0xa2000000;
> > > .text :
> > > to replace
> > > .text 0xa2000000 :
> > > ?
> > > i modify as that, and it still get the same message
> > >
> >
> > I think the problem is not with the linker, but in your use of objcopy
> > to convert your ELF file to a raw binary file.
> >
> > 1) What arguments are you giving to mipsel-linux-objcopy?
> i use objcopy as follow(the brec_flash is elf file)
>         mipsel-linux-objcopy -O binary brec_flash brec_flash.bin
> >
> > 2) What is the output from mipsel-linux-objdump -h run on your
> > intermediate ELF object file?
> i use mipsel-linux-objdump -h brec_flash and get messages as follow
>
>
> brec_flash:     file format elf32-tradlittlemips
>
> Sections:
> Idx Name          Size      VMA       LMA       File off  Algn
>   0 .text         0000b140  72000000  72000000  00010000  2**4
>                   CONTENTS, ALLOC, LOAD, READONLY, CODE
>   1 .data         00001080  7200b140  7200b140  0001b140  2**4
>                   CONTENTS, ALLOC, LOAD, DATA
>   2 .sbss         00000010  7200c1c0  7200c1c0  0001c1c0  2**2
>                   ALLOC
>   3 .bss          000008a0  7200c1d0  7200c1d0  0001c1c0  2**4
>                   ALLOC
>   4 .reginfo      00000018  7200ca70  7200ca70  0001ca70  2**2
>                   CONTENTS, ALLOC, LOAD, READONLY, DATA, LINK_ONCE_SAME_SIZE
>   5 .pdr          000011a0  00000000  00000000  0001ca88  2**2
>                   CONTENTS, READONLY
>   6 .mdebug.abi32 00000000  00000000  00000000  0001dc28  2**0
>                   CONTENTS, READONLY
>   7 .comment      000000ea  00000000  00000000  0001dc28  2**0
>                   CONTENTS, READONLY
>   8 .rodata       00000190  000000f0  000000f0  000000f0  2**4
>                   CONTENTS, ALLOC, LOAD, READONLY, DATA
>   9 .rodata.str1.4 000005fe  00000280  00000280  00000280  2**2
>                   CONTENTS, ALLOC, LOAD, READONLY, DATA

the 0x72xxxxxx should be 0xa2xxxxxx, because i can't pass by set
0xa2000000,so i change the .text to 0x72000000, and it can get the
.bin correctly.
>
> >
> >
> > Nigel
> >
> > --
> > Nigel Stephens            e. nigel@mips.com
> > MIPS Technologies         p. +44 1223 203110
> > Building 7200             f. +44 1223 203181
> > Cambridge Research Park   m. +44 7976 686470
> > Beach Road, Waterbeach    w. http://www.mips.com
> > Cambridge CB5 9TL, UK
> >
> >
>
