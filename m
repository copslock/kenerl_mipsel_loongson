Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Nov 2009 01:21:31 +0100 (CET)
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:42481 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493832AbZKQAVY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 17 Nov 2009 01:21:24 +0100
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 42BD2C141C;
	Mon, 16 Nov 2009 19:21:21 -0500 (EST)
Received: from web8.messagingengine.com ([10.202.2.217])
  by compute1.internal (MEProxy); Mon, 16 Nov 2009 19:21:21 -0500
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:from:to:mime-version:content-transfer-encoding:content-type:in-reply-to:references:subject:date; s=smtpout; bh=2yrosiSKXyaieLsgykOLhuoMqA0=; b=iWXjgWCshGvEbnlOUtETXHV1S4pydw4wiEHFtC0a1LjkO6HFzQQTOHU5X597Q8GNZ9i6t7T9TS+HkVBc9XUwGrB9apdJP+3NTkVnnJl5cwj3CFAehG8+Cd9X7BR33bTM/rNMz94b1IPSUBPdSbUnBDYGhePQYtw2OyzbSQ6n1Ik=
Received: by web8.messagingengine.com (Postfix, from userid 99)
	id 1F966106EF0; Mon, 16 Nov 2009 19:21:21 -0500 (EST)
Message-Id: <1258417281.1921.1345554581@webmail.messagingengine.com>
X-Sasl-Enc: bvpGpm/8DHUaNNsGDMFTIrRViW7GfSnYa0KaYHMPfaxv 1258417281
From:	myuboot@fastmail.fm
To:	linux-kernel@vger.kernel.org,
	"linux-mips" <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: MessagingEngine.com Webmail Interface
In-Reply-To: <4AFA6B7F.10404@walsimou.com>
References: <1255735395.30097.1340523469@webmail.messagingengine.com>
 <4AD906D8.3020404@caviumnetworks.com>
 <1257898975.30125.1344591929@webmail.messagingengine.com>
 <4AFA6B7F.10404@walsimou.com>
Subject: problem bring up initramfs and busybox
Date:	Mon, 16 Nov 2009 18:21:21 -0600
Return-Path: <myuboot@fastmail.fm>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: myuboot@fastmail.fm
Precedence: bulk
X-list: linux-mips

I have been struggling to bring up a MIPS 32 board with busybox with or
without initramfs.
The kernel stucks there without the shell coming up.

[    1.153000] nf_conntrack version 0.5.0 (1024 buckets, 4096 max)
[    1.161000] ip_tables: (C) 2000-2006 Netfilter Core Team
[    1.167000] TCP cubic registered
[    1.170000] NET: Registered protocol family 17
[   25.971000] Freeing unused kernel memory: 1032k freed
[   39.969000] Algorithmics/MIPS FPU Emulator v1.5


What I tried here is to use initramfs with statically linked busybox.
The initramfs seems to be up, and runs the commands in the /init one by
one, and then it goes to a inifite loop in r4k_wait at
arch/mips/kernel/genex.S.

The following is the execution sequense when it runs /init. Can anyone
give me some idea what is wrong?

Thanks, Andrew


Breakpoint 2, do_execve (filename=0x9780a000 "/bin/sh", argv=0x4f73a4,
envp=0x4f73ac, regs=0x97997f30) at fs/exec.c:1293
1293            retval = unshare_files(&displaced);
(gdb) c
Continuing.

Breakpoint 2, do_execve (filename=0x9780a000 "/sbin/switch_root",
argv=0x4f7450, envp=0x4f7464, regs=0x97819f30) at fs/exec.c:1293
1293            retval = unshare_files(&displaced);
(gdb) c
Continuing.

Breakpoint 2, do_execve (filename=0x9780a000 "/usr/sbin/switch_root",
argv=0x4f7450, envp=0x4f7464, regs=0x97819f30) at fs/exec.c:1293
1293            retval = unshare_files(&displaced);
(gdb) c
Continuing.

Breakpoint 2, do_execve (filename=0x9780a000 "/bin/switch_root",
argv=0x4f7450, envp=0x4f7464, regs=0x97819f30) at fs/exec.c:1293
1293            retval = unshare_files(&displaced);
(gdb) c
Continuing.

Breakpoint 2, do_execve (filename=0x9780a000 "/usr/bin/switch_root",
argv=0x4f7450, envp=0x4f7464, regs=0x97819f30) at fs/exec.c:1293
1293            retval = unshare_files(&displaced);
(gdb) c
Continuing.
^C
Program received signal SIGSTOP, Stopped (signal).
r4k_wait () at arch/mips/kernel/genex.S:147
147             jr      ra

-- And here is the content of /init script - 
#!/bin/busybox sh

# Mount the /proc and /sys filesystems.
mount -t proc none /proc
mount -t sysfs none /sys

mdev -s
/bin/sh

# Do your stuff here.
echo "This script mounts rootfs and boots it up, nothing more!"

# Mount the root filesystem.
mount -o ro /dev/mtdblock4 /mnt/root

# Clean up.
umount /proc
umount /sys

# Boot the real thing.
exec switch_root /mnt/root /sbin/init
