Received:  by oss.sgi.com id <S305171AbQALQ6K>;
	Wed, 12 Jan 2000 08:58:10 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:38244 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305154AbQALQ5w>; Wed, 12 Jan 2000 08:57:52 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id JAA05433; Wed, 12 Jan 2000 09:01:27 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA04360
	for linux-list;
	Wed, 12 Jan 2000 08:28:09 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA40879
	for <linux@engr.sgi.com>;
	Wed, 12 Jan 2000 08:28:03 -0800 (PST)
	mail_from (weave@eng.umd.edu)
Received: from po4.glue.umd.edu (po4.glue.umd.edu [128.8.10.124]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA00135
	for <linux@engr.sgi.com>; Wed, 12 Jan 2000 08:27:48 -0800 (PST)
	mail_from (weave@eng.umd.edu)
Received: from z.glue.umd.edu (root@z.glue.umd.edu [128.8.10.71])
	by po4.glue.umd.edu (8.9.3/8.9.3) with ESMTP id LAA18092
	for <linux@engr.sgi.com>; Wed, 12 Jan 2000 11:27:42 -0500 (EST)
Received: from z.glue.umd.edu (sendmail@localhost [127.0.0.1])
	by z.glue.umd.edu (8.9.3/8.9.3) with SMTP id LAA14407
	for <linux@engr.sgi.com>; Wed, 12 Jan 2000 11:27:41 -0500 (EST)
Received: from localhost (weave@localhost)
	by z.glue.umd.edu (8.9.3/8.9.3) with ESMTP id LAA14403
	for <linux@engr.sgi.com>; Wed, 12 Jan 2000 11:27:41 -0500 (EST)
X-Authentication-Warning: z.glue.umd.edu: weave owned process doing -bs
Date:   Wed, 12 Jan 2000 11:27:41 -0500 (EST)
From:   Vince Weaver <weave@eng.umd.edu>
X-Sender: weave@z.glue.umd.edu
To:     linux@cthulhu.engr.sgi.com
Subject: cross-compile fails
Message-ID: <Pine.GSO.4.21.0001121124200.14194-100000@z.glue.umd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hello

I am trying to compile a kernel to boot on an Indigo2 I have access too.

I installed the rpm's of the mips cross-compile tools from oss.sgi.com, 
and got the latest CVS kernel [at about 10am EST today].

the compile fails at the end with this:

make[1]: Leaving directory `/home/vince/sgi/linux/arch/mips/lib'
mips-linux-ld -static -G 0 -N -T arch/mips/ld.script.little -Ttext 0x88002000 
arch/mips/kernel/head.o arch/mips/kernel/init_task.o init/main.o
init/version.o \
        --start-group \
        arch/mips/kernel/kernel.o arch/mips/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
        fs/filesystems.a \
        net/network.a \
        drivers/block/block.a drivers/char/char.o drivers/misc/misc.o
drivers/parport/parport.a drivers/net/net.a drivers/scsi/scsi.a
drivers/cdrom/cdrom.a drivers/sgi/sgi.a drivers/video/video.a \
        arch/mips/lib/lib.a /home/vince/sgi/linux/lib/lib.a
arch/mips/sgi/kernel/sgikern.a arch/mips/arc/arclib.a \
        --end-group \
        -o vmlinux
mips-linux-ld: arch/mips/kernel/head.o: compiled for a big endian system
and target is little endian
mips-linux-ld: arch/mips/kernel/init_task.o: compiled for a big endian
system and target is little endian
.......

and the last error repeats for a bunch of files

if I change in the config file from little-endian to big endian I get the
same error in reverse, a bunch of files compiled for a little endian
system and the target is big endian.

is there an easy fix to this? am I missing something obvious?

Vince

____________
\  /\  /\  /  Vince Weaver          
 \/__\/__\/   weave@eng.umd.edu     http://www.glue.umd.edu/~weave
