Received:  by oss.sgi.com id <S554261AbRBZSDl>;
	Mon, 26 Feb 2001 10:03:41 -0800
Received: from gatekeep.ti.com ([192.94.94.61]:43455 "EHLO gatekeep.ti.com")
	by oss.sgi.com with ESMTP id <S554258AbRBZSDc>;
	Mon, 26 Feb 2001 10:03:32 -0800
Received: from dlep8.itg.ti.com ([157.170.134.88])
	by gatekeep.ti.com (8.11.1/8.11.1) with ESMTP id f1QI3Pr00090;
	Mon, 26 Feb 2001 12:03:25 -0600 (CST)
Received: from dlep8.itg.ti.com (localhost [127.0.0.1])
	by dlep8.itg.ti.com (8.9.3/8.9.3) with ESMTP id MAA04640;
	Mon, 26 Feb 2001 12:03:25 -0600 (CST)
Received: from dlep3.itg.ti.com (dlep3-maint.itg.ti.com [157.170.133.16])
	by dlep8.itg.ti.com (8.9.3/8.9.3) with ESMTP id MAA04622;
	Mon, 26 Feb 2001 12:03:24 -0600 (CST)
Received: from ti.com (IDENT:bbrown@bbrowndt.sc.ti.com [158.218.100.126])
	by dlep3.itg.ti.com (8.9.3/8.9.3) with ESMTP id MAA06449;
	Mon, 26 Feb 2001 12:03:24 -0600 (CST)
Message-ID: <3A9A9B52.C990A581@ti.com>
Date:   Mon, 26 Feb 2001 11:07:15 -0700
From:   Brady Brown <bbrown@ti.com>
Organization: Texas Instruments
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Tom Appermont <tea@sonycom.com>
CC:     linux-mips@oss.sgi.com
Subject: Re: ELF header kernel module wrong?
References: <20010223151355.A9091@ginger.sonytel.be>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Tom Appermont wrote:

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

I think the final conclusion on this problem in the old thread was that the assembler is generating ELF files that are IRIX flavored with respect to the symbol table ordering and index. I discovered by playing around that the linker was creating
correct ELF symbol tables, so as a temporary work around until the assembler is tweaked I started to incrementally link my modules with the linker `ld -r <filename>` . This eliminated the immediate problem for me.

--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Brady Brown (bbrown@ti.com)       Work:(801)619-6103
Texas Instruments: Broadband Access Group
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
