Received:  by oss.sgi.com id <S554169AbRBYJIS>;
	Sun, 25 Feb 2001 01:08:18 -0800
Received: from [194.90.113.98] ([194.90.113.98]:7428 "EHLO
        yes.home.krftech.com") by oss.sgi.com with ESMTP id <S554167AbRBYJIA>;
	Sun, 25 Feb 2001 01:08:00 -0800
Received: from jungo.com (michaels@kobie.home.krftech.com [199.204.71.69])
	by yes.home.krftech.com (8.8.7/8.8.7) with ESMTP id MAA13261;
	Sun, 25 Feb 2001 12:12:33 +0200
From:   michaels@jungo.com
Message-ID: <3A98CB15.CE4DE67D@jungo.com>
Date:   Sun, 25 Feb 2001 11:06:29 +0200
Organization: Jungo LTD
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-21mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Tom Appermont <tea@sonycom.com>, linux-mips@oss.sgi.com
Subject: Re: ELF header kernel module wrong?
References: <20010223151355.A9091@ginger.sonytel.be>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Tom, 

I have seen this problem too. My kernel is 2.2.14 though, using modutils
2.3.x.
I tried to do many things with modutils, tried even not to check the
boundary, but that caused crashes. The only solution that worked for me
was to step downwards to modutils 2.2.2. Even then, depmod segfaults
unless you put a remark on obj_free in some place... Hope you get a
better solution. 
I don't think that the reason for this is in modutils though. We have
one particularly complex (and thus big) module, written for DSL device,
which worked with these modutils without any problem. This module
however did not come from the kernel tree, but was compiled with the
same cross toolchain. Identical compilation flags were used in both
cases, but the sections inside ELF were named differently and their
order was slightly different.

More information can be provided upon request :-)

Tom Appermont wrote:
> 
> Greetings,
> 
> I'm trying to get modules to work on my R5000 little endian
> target, linux 2.4.1 + modutils 2.4.2 .
> 
> When I insmod a module, I get error messages like:
> 
> [root@192 /]# insmod dummy.o
> dummy.o: local symbol gcc2_compiled. with index 10 exceeds local_symtab_size 10
> dummy.o: local symbol __gnu_compiled_c with index 11 exceeds local_symtab_size 10
> dummy.o: local symbol __module_kernel_version with index 12 exceeds local_symtab_size 10
> dummy.o: local symbol set_multicast_list with index 13 exceeds local_symtab_size 10
> dummy.o: local symbol dummy_init with index 14 exceeds local_symtab_size 10
> dummy.o: local symbol dummy_xmit with index 15 exceeds local_symtab_size 10
> dummy.o: local symbol dummy_get_stats with index 18 exceeds local_symtab_size 10
> dummy.o: local symbol dummy_init_module with index 21 exceeds local_symtab_size 10
> dummy.o: local symbol dev_dummy with index 22 exceeds local_symtab_size 10
> dummy.o: local symbol dummy_cleanup_module with index 26 exceeds local_symtab_size 10
> [root@192 /]#
> 
> Looking at the source code of modutils, I suspect that there is
> something wrong with the ELF header of the module (the sh_info
> field of the SYMTAB section is 0xa while it should be 0x17 ??).
> ELF header is attached below. The command used to compile the
> module is :
> 
> mipsel-linux-gcc -I/usr/src/linux/include/asm/gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -G 0 -mno-abicalls -fno-pic -mcpu=r8000 -mips2 -Wa,--trap -pipe -DMODULE -mlong-calls
> 
> I use egcs 1.2.1 + binutils 2.9.5. Is this a problem with my
> binutils?
> 
> Tom

-- 
Sincerely yours,
Michael Shmulevich
______________________________________
Software Developer
Jungo - R&D 
email: michaels@jungo.com
web: http://www.jungo.com
Phone: 1-877-514-0537(USA)  +972-9-8859365(Worldwide) ext. 233
Fax:   1-877-514-0538(USA)  +972-9-8859366(Worldwide)
