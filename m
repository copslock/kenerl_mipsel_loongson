Received:  by oss.sgi.com id <S553978AbRAQAbU>;
	Tue, 16 Jan 2001 16:31:20 -0800
Received: from jester.ti.com ([192.94.94.1]:35986 "EHLO jester.ti.com")
	by oss.sgi.com with ESMTP id <S553776AbRAQAbK>;
	Tue, 16 Jan 2001 16:31:10 -0800
Received: from dlep8.itg.ti.com ([157.170.134.88])
	by jester.ti.com (8.11.1/8.11.1) with ESMTP id f0H0V3926022
	for <linux-mips@oss.sgi.com>; Tue, 16 Jan 2001 18:31:03 -0600 (CST)
Received: from dlep8.itg.ti.com (localhost [127.0.0.1])
	by dlep8.itg.ti.com (8.9.3/8.9.3) with ESMTP id SAA15419
	for <linux-mips@oss.sgi.com>; Tue, 16 Jan 2001 18:31:03 -0600 (CST)
Received: from dlep3.itg.ti.com (dlep3-maint.itg.ti.com [157.170.133.16])
	by dlep8.itg.ti.com (8.9.3/8.9.3) with ESMTP id SAA15410
	for <linux-mips@oss.sgi.com>; Tue, 16 Jan 2001 18:31:03 -0600 (CST)
Received: from ti.com (IDENT:bbrown@bbrowndt.sc.ti.com [158.218.100.126])
	by dlep3.itg.ti.com (8.9.3/8.9.3) with ESMTP id SAA11346
	for <linux-mips@oss.sgi.com>; Tue, 16 Jan 2001 18:31:01 -0600 (CST)
Message-ID: <3A64E875.193153C9@ti.com>
Date:   Tue, 16 Jan 2001 17:33:57 -0700
From:   Brady Brown <bbrown@ti.com>
Organization: Texas Instruments
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     SGI news group <linux-mips@oss.sgi.com>
Subject: egcs-1.1.2-3 problems
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

We recently updated our cross-compile tools from egcs-1.0.3a-2 to
egcs-1.1.2-3.
Our revs are now:
egcs-g77-mipsel-linux-1.1.2-3
egcs-c++-mipsel-linux-1.1.2-3
egcs-objc-mipsel-linux-1.1.2-3
binutils-mipsel-linux-2.8.1-1
egcs-mipsel-linux-1.1.2-3
egcs-libstdc++-mipsel-linux-2.9.0-2

With this tool chain kernel 2.4.0-test9 will build, but dies during
bootup.
>>>snip
INIT: version 2.74 booting
Activating swap partitions
Adding Swap: 66540k swap-space (priority -1)
hostname: mippy2
Checking root filesystems.
Parallelizing fsck version 1.10 (24-Apr-97)
[/sbin/fsck.ext2] fsck.ext2 -a /dev/sdb2
INIT: PANIC: segmentation violation! giving up..
<<<snip

I then tried to build some userland apps that we have set-up to
cross-compile with the old tools. Bash built fine, but Apache had a very
strange error.
>>>snip
mipsel-linux-gcc -c  -I../os/unix -I../include  -O2 -mcpu=r4600 -mips2
-DLINUX=2 `../apaci` alloc.c
mipsel-linux-gcc -c  -I../os/unix -I../include  -O2 -mcpu=r4600 -mips2
-DLINUX=2 `../apaci` buff.c
mipsel-linux-gcc -c  -I../os/unix -I../include  -O2 -mcpu=r4600 -mips2
-DLINUX=2 `../apaci` http_config.c
mipsel-linux-gcc -c  -I../os/unix -I../include  -O2 -mcpu=r4600 -mips2
-DLINUX=2 `../apaci` http_core.c
mipsel-linux-gcc -c  -I../os/unix -I../include  -O2 -mcpu=r4600 -mips2
-DLINUX=2 `../apaci` http_log.c
mipsel-linux-gcc -c  -I../os/unix -I../include  -O2 -mcpu=r4600 -mips2
-DLINUX=2 `../apaci` http_main.c
http_main.c: In function `find_child_by_pid':
http_main.c:2156: internal error--unrecognizable insn:
(insn 81 80 88 (set (reg:SI 89)
        (plus:SI (reg:SI 84)
            (const_int 49152))) -1 (insn_list 80 (nil))
    (expr_list:REG_DEAD (reg:SI 84)
        (nil)))
../../gcc/toplev.c:1367: Internal compiler error in function fatal_insn
make[3]: *** [http_main.o] Error 1
make[2]: *** [subdirs] Error 1
make[2]: Leaving directory `/home/BUILD/apache_1.3.3/src'
make[1]: *** [build-std] Error 2
make[1]: Leaving directory `/home/BUILD/apache_1.3.3'
make: *** [build] Error 2
Bad exit status from /var/tmp/rpm-tmp.24768 (%build)
<<<snip

Neither of these problems occur with the old tool rev. Any thoughts?

--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Brady Brown (bbrown@ti.com)
Texas Instruments: Broadband Access Group
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
