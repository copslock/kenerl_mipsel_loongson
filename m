Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 May 2006 10:33:31 +0200 (CEST)
Received: from wx-out-0102.google.com ([66.249.82.193]:23436 "EHLO
	wx-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S8133403AbWEWIdX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 23 May 2006 10:33:23 +0200
Received: by wx-out-0102.google.com with SMTP id t15so1047499wxc
        for <linux-mips@linux-mips.org>; Tue, 23 May 2006 01:33:22 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pw7lntzVMHz4hw4Xj8dgGVOC7ULVRxe3nub3puAYymMUIyMAMTanRN/HHE5Uw2XxFDqM/68Jua9kRDxYuRlS4QdNYsH9ZfSKjpx5du/EpfDBXOHgQUuk/lKyIhYdX7Fle+fYhdlf/Hq0xWZVFJhL25e4gsvPumSnSYRY4GhLmCA=
Received: by 10.70.11.20 with SMTP id 20mr6125764wxk;
        Tue, 23 May 2006 01:33:22 -0700 (PDT)
Received: by 10.70.124.7 with HTTP; Tue, 23 May 2006 01:33:22 -0700 (PDT)
Message-ID: <d096a3ee0605230133l60a8b5uc74fad7e479752e@mail.gmail.com>
Date:	Tue, 23 May 2006 14:03:22 +0530
From:	"Mayuresh Chitale" <mchitale@gmail.com>
To:	linux-mips@linux-mips.org
Subject: oprofile for mips
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <mchitale@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11522
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mchitale@gmail.com
Precedence: bulk
X-list: linux-mips

Hi All,

I am trying to cross compile oprofile for mips. I get an error:

configure: error: bfd library not found when configuring.

Has anyone faced a similar problem during cross compilation. ?

Thanks in advance,
Mayuresh.

mayuresh@89:~/malta/oprofile/oprofile-0.9.1-source >./configure
--host=mips-linux --target=mips-linux
--with-linux=/home/mayuresh/malta/oprofile/linux-2.6.16.12/
--with-kernel-support
--with-extra-libs=/home/mayuresh/malta/rootfs/lib/
configure: WARNING: If you wanted to set the --build type, don't use --host.
   If a cross compiler is detected then cross compile mode will be used.
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking for mips-linux-strip... mips-linux-strip
checking for mips-linux-ranlib... mips-linux-ranlib
checking for mips-linux-gcc... mips-linux-gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... yes
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether mips-linux-gcc accepts -g... yes
checking whether build environment is sane... yes
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking for mips-linux-strip... mips-linux-strip
checking for mips-linux-ranlib... mips-linux-ranlib
checking for mips-linux-gcc... mips-linux-gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... yes
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether mips-linux-gcc accepts -g... yes
checking for mips-linux-gcc option to accept ANSI C... none needed
checking for style of include used by make... GNU
checking dependency style of mips-linux-gcc... gcc3
checking how to run the C preprocessor... mips-linux-gcc -E
checking for mips-linux-g++... mips-linux-g++
checking whether we are using the GNU C++ compiler... yes
checking whether mips-linux-g++ accepts -g... yes
checking dependency style of mips-linux-g++... gcc3
checking for ld... ld
checking for kernel OProfile support... yes
checking whether malloc attribute is understood... yes
checking whether __builtin_expect is understood... yes
checking for sched_setaffinity... no
checking for perfmonctl... no
checking for poptGetContext in -lpopt... yes
checking for egrep... grep -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking libiberty.h usability... no
checking libiberty.h presence... no
checking for libiberty.h... no
checking for cplus_demangle in -liberty... yes
checking for xcalloc... yes
checking for xmemdup... yes
checking for dlopen in -ldl... yes
checking for main in -lintl... no
checking for bfd_openr in -lbfd... no
configure: error: bfd library not found
