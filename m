Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Apr 2005 16:56:33 +0100 (BST)
Received: from dfpost.ru ([IPv6:::ffff:194.85.103.225]:39360 "EHLO
	mail.dfpost.ru") by linux-mips.org with ESMTP id <S8225355AbVD0P4S>;
	Wed, 27 Apr 2005 16:56:18 +0100
Received: by mail.dfpost.ru (Postfix, from userid 7897)
	id A112C3E4B1; Wed, 27 Apr 2005 19:54:15 +0400 (MSD)
Received: from toch.dfpost.ru (toch [192.168.7.60])
	by mail.dfpost.ru (Postfix) with SMTP id 199E23E4AE
	for <linux-mips@linux-mips.org>; Wed, 27 Apr 2005 19:54:15 +0400 (MSD)
Date:	Wed, 27 Apr 2005 19:55:52 +0400
From:	Dmitriy Tochansky <toch@dfpost.ru>
To:	linux-mips@linux-mips.org
Subject: ramfs
Message-Id: <20050427195552.41f92184.toch@dfpost.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.92.8
Return-Path: <toch@dfpost.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7802
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: toch@dfpost.ru
Precedence: bulk
X-list: linux-mips

Hello!

Im trying to use embedded ramdisk on boot.
The error is:

[4294668.794000] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1,0) 

In make menuconfig I pass to initrdfs directory with my root("/mips/root"),
there are no errors on make. 
Ramdisk size set to 7777k
([4294668.691000] RAMDISK driver initialized: 2 RAM disks of 7777K size 1024 blocksize)

populate_rootfs() works fine:


[4294667.502000] init/initramfs.c void __init populate_rootfs(void);
[4294668.313000] checking if image is initramfs... it is

then on do_mounts in void __init mount_block_root(char *name, int flags)
it tryes to mount initrd with no result. :( As final:


[4294668.794000] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1,0)

Any ideas?

Kernel from cvs(yesterday updated).

Which type of fs is initrd? AFAIK gen_init_cpio just generates cpio archive with my root. Seems like it unpacked fine but who did mkfs on /dev/ram0?


-- 
Dmitriy Tochansky
toch@dfpost.ru
JID: dtoch@jabber.ru
