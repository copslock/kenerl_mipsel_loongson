Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id RAA03631 for <linux-archive@neteng.engr.sgi.com>; Tue, 2 Dec 1997 17:14:15 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA06578 for linux-list; Tue, 2 Dec 1997 17:09:42 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA06550 for <linux@engr.sgi.com>; Tue, 2 Dec 1997 17:09:34 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id RAA06105
	for <linux@engr.sgi.com>; Tue, 2 Dec 1997 17:09:32 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-14.uni-koblenz.de [141.26.249.14])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id CAA16383
	for <linux@engr.sgi.com>; Wed, 3 Dec 1997 02:09:30 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id UAA17799;
	Tue, 2 Dec 1997 20:01:47 +0100
Message-ID: <19971202200147.44637@uni-koblenz.de>
Date: Tue, 2 Dec 1997 20:01:47 +0100
To: Miguel de Icaza <miguel@nuclecu.unam.mx>
Cc: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
Subject: vmalloc hacks
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi Miguel,

building the CVS tree for the Indy breaks with

mips/kernel/head.o arch/mips/kernel/init_task.o init/main.o init/version.o \
        arch/mips/kernel/kernel.o arch/mips/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
        fs/filesystems.a \
        net/network.a \
        drivers/block/block.a drivers/char/char.a drivers/misc/misc.a drivers/net/net.a drivers/scsi/scsi.a drivers/cdrom/cdrom.a drivers/sgi/sgi.a \
        arch/mips/lib/lib.a /disk2/sgi/lib/lib.a arch/mips/sgi/kernel/sgikern.a arch/mips/sgi/prom/promlib.a arch/mips/lib/lib.a \
        -o vmlinux
kernel/kernel.o: In function `wake_up_process':
sched.c(__ksymtab+0x80): undefined reference to `vmalloc'
make: *** [vmlinux] Error 1

So you'll have to make vmalloc a real function again or you'll break the
binary compatibility with modules.  Ok, not very much an issue.

  Ralf
