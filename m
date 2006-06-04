Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Jun 2006 08:06:03 +0200 (CEST)
Received: from ug-out-1314.google.com ([66.249.92.170]:26319 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S8133515AbWFDGFz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 4 Jun 2006 08:05:55 +0200
Received: by ug-out-1314.google.com with SMTP id k3so1049925ugf
        for <linux-mips@linux-mips.org>; Sat, 03 Jun 2006 23:05:55 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HqQ6d2BleEleT8Ukz/90dNRwcOSXSWCPrwUCEtlOnTx53x5u1HWUsJW+6Ns5BCgft3nikr+fpDn7umbVRJxYeHzmSZKDzX3lLpR4xMCY6j+8tCuE1UOgdEWLB5BTOcfCAy7Kxbbb0jEDwVgsubPNo7QXLL0Etyd1JBJhIJVql8w=
Received: by 10.67.101.10 with SMTP id d10mr2236692ugm;
        Sat, 03 Jun 2006 23:05:55 -0700 (PDT)
Received: by 10.66.241.4 with HTTP; Sat, 3 Jun 2006 23:05:54 -0700 (PDT)
Message-ID: <50c9a2250606032305t12dd44d5y78ec28cc6067fa66@mail.gmail.com>
Date:	Sun, 4 Jun 2006 14:05:54 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: how to reused the initrd ram?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11658
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

my board has 64M sdram, when i boot nfs root, it show Mem total about 62M
and if i boot initrd and then switch to nfs root, it show mem total
about 54M,and freeramdisk does nothing to it.

my kernel commandline is
root=/dev/nfs init=/linuxrc rd_start=0x80a00000 rd_size=0x260000
ramdisk_size=8192 ip=bootp

and in my initrd, the linuxrc is
#!/bin/nash
mount -t proc /proc /proc
echo Mounting root filesystem
mount -o nolock,rsize=1024,wsize=1024 --ro -t nfs
10.10.10.2:/root/nfsroot/rootfs /sysroot
pivot_root /sysroot /sysroot/initrd
umount /initrd/proc

and in my nfs root, i type
$umount initrd
$freeramdisk /dev/ram0

it only flushed bufferd mem, and do nothing to the mem total.
i wonder how to reused the initrd mem?

BTW, if i change the kernel comandline to root=/dev/ram0 ...
it will show messages as
"Failed to execute /linuxrc.  Attempting defaults...
Kernel panic - not syncing: No init found.  Try passing init= option to kernel"


Thanks for any hints
Best Regards

zhuzhenhua
