Received:  by oss.sgi.com id <S553690AbQJUDLt>;
	Fri, 20 Oct 2000 20:11:49 -0700
Received: from u-247.karlsruhe.ipdial.viaginterkom.de ([62.180.21.247]:8977
        "EHLO u-247.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553673AbQJUDLW>; Fri, 20 Oct 2000 20:11:22 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870339AbQJUDLJ>;
        Sat, 21 Oct 2000 05:11:09 +0200
Date:   Sat, 21 Oct 2000 05:11:09 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: problems with insmod ...
Message-ID: <20001021051109.A30093@bacchus.dhis.org>
References: <39F1045B.21EF1851@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39F1045B.21EF1851@mvista.com>; from jsun@mvista.com on Fri, Oct 20, 2000 at 07:50:03PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Oct 20, 2000 at 07:50:03PM -0700, Jun Sun wrote:

> In obj/obj_mipsel.c arch_apply_relocation() function, the mips_hi16_list
> is not initialized to NULL before it is used as a list head.  So, later,
> insmod dies at trying to access 0x41.
> 
> (BTW, it seems horrible to me that arch_apply_relocation() remaps
> obj_file struct to a local mips_file struct, destroying the original ELF
> header struct.  Is this safe?)
> 
> I kind of hacked around this problem (I don't know the real fix), but I
> got some other problems.  This time it is at obj/obj_reloc.c:410 -
> sec->contents is 0x0.  It seems to me that this section should be
> included in load list at the first place.  Does somebody why it is
> there?  
> 
> I dumped the section info here :
> 
> (gdb) p/x *f->load_order->load_next->load_next
> $22 = {
>   header = {
>     sh_name = 0x36,
>     sh_type = 0x70000006,
>     sh_flags = 0x2,
>     sh_addr = 0xc00000e0,
>     sh_offset = 0xd0,
>     sh_size = 0x18,
>     sh_link = 0x0,
>     sh_info = 0x0,
>     sh_addralign = 0x4,
>     sh_entsize = 0x1
>   },
>   name = 0x1001bf26,
>   contents = 0x0,
>   load_next = 0x1001bd88,
>   idx = 0x5
> }

This is a .reginfo section.  MIPS specific and guaranteed to be useless.
The ABI says we should load it but they're useless, so inside the kernel
simply ignore it.

> BTW, I seem to remember someone said the modutils 2.1.121 is not good
> MIPS.  Which version is good?

There are patched versions of 2.1.121 available which are usable.  I've
uploaded source and binaries of 2.1.131 and Keith Owen's latest version
into oss.sgi.com:/pub/linux/mips/modutils.

  Ralf
