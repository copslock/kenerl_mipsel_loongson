Received:  by oss.sgi.com id <S42336AbQITAAf>;
	Tue, 19 Sep 2000 17:00:35 -0700
Received: from gatekeep.ti.com ([192.94.94.61]:58111 "EHLO gatekeep.ti.com")
	by oss.sgi.com with ESMTP id <S42234AbQITAAV>;
	Tue, 19 Sep 2000 17:00:21 -0700
Received: from dlep6.itg.ti.com ([157.170.188.9])
	by gatekeep.ti.com (8.11.0/8.11.0) with ESMTP id e8K00FT17947
	for <linux-mips@oss.sgi.com>; Tue, 19 Sep 2000 19:00:15 -0500 (CDT)
Received: from dlep6.itg.ti.com (localhost [127.0.0.1])
	by dlep6.itg.ti.com (8.9.3/8.9.3) with ESMTP id TAA29292
	for <linux-mips@oss.sgi.com>; Tue, 19 Sep 2000 19:00:10 -0500 (CDT)
Received: from dlep3.itg.ti.com (dlep3.itg.ti.com [157.170.188.62])
	by dlep6.itg.ti.com (8.9.3/8.9.3) with ESMTP id TAA29288
	for <linux-mips@oss.sgi.com>; Tue, 19 Sep 2000 19:00:10 -0500 (CDT)
Received: from ti.com (IDENT:bbrown@bbrowndt.sc.ti.com [158.218.100.180])
	by dlep3.itg.ti.com (8.9.3/8.9.3) with ESMTP id TAA04155
	for <linux-mips@oss.sgi.com>; Tue, 19 Sep 2000 19:00:14 -0500 (CDT)
Message-ID: <39C7FEBC.5DB355A2@ti.com>
Date:   Tue, 19 Sep 2000 18:03:08 -0600
From:   Brady Brown <bbrown@ti.com>
Organization: Texas Instruments
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     SGI news group <linux-mips@oss.sgi.com>
Subject: ELF/Modutils problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I'm having trouble getting modutils 2.3.10 to work on a little endian
MIPS box running a 2.4.0-test3 kernel. I am cross compiling the kernel
and modules on an i386 using egcs1.0.3a-2 and binutils2.8.1-1. It
appears that the symbol table format in the ELF file created by
mipsel-linux-gcc during a module build is incorrect.

As I read the ELF 1.1 spec - all symbols with STB_LOCAL bindings should
precede all other symbols (weak and global) in the symbol table. Then
the symbol table section's sh_info section header member holds the
symbol table index for the first non-local symbol (and thus can then be
used to determine the number of local symbols). Using the readelf
utility on a generated module shows that the local symbols are not
grouped together before all other symbols but are intermixed though out
the symbol table, and the sh_info field in the header is not set to the
first non-local symbol index.

When insmod runs it malloc's memory equal to the sh_info field and then
begins to populate the local symbols into it. Because of the bad symbol
ordering and incorrect value in sh_info, the malloc'd memory is far to
small to hold all of the local symbols so memory gets blasted and the
module fails to load correctly.

As a side test I tried to incrementally link the module.o file using
mipsel-linux-ld -r module.o -o module. Viewing the ELF output from this
stage showed a correct symbol ordering and sh_info field so it appears
that the linker is generating the correct format for the symbol table
(problem with gcc only?). Has this problem been addressed/resolved? Any
suggestions?
