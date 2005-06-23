Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2005 02:00:09 +0100 (BST)
Received: from ntfw.echelon.com ([IPv6:::ffff:205.229.50.10]:2285 "EHLO
	[205.229.50.10]") by linux-mips.org with ESMTP id <S8225438AbVFWA7x>;
	Thu, 23 Jun 2005 01:59:53 +0100
Received: from miles.echelon.com by [205.229.50.10]
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with ESMTP; Wed, 22 Jun 2005 17:58:52 -0700
Received: by miles.echelon.echcorp.com with Internet Mail Service (5.5.2653.19)
	id <MTDG270W>; Wed, 22 Jun 2005 17:58:49 -0700
Message-ID: <5375D9FB1CC3994D9DCBC47C344EEB5905FA4345@miles.echelon.echcorp.com>
From:	Prashant Viswanathan <vprashant@echelon.com>
To:	'rolf liu' <rolfliu@gmail.com>, linux-mips@linux-mips.org
Subject: RE: booting error on db1550 for kernel 2.4.31
Date:	Wed, 22 Jun 2005 17:58:48 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Return-Path: <vprashant@echelon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8148
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vprashant@echelon.com
Precedence: bulk
X-list: linux-mips

> I compiled the kernel 2.4.31 using sde tools. Download linux to db1550
> through yamon. but the kernel can't find the NFS root. I tried the NFS
> system from other linux box, and the NFS is ok. Who met this same
> problem?
> 
> Looking up port of RPC 100003/2 on 10.200.0.198
> RPC: sendmsg returned error 128
> portmap: RPC call returned error 128
> Root-NFS: Unable to get nfsd port number from server, using default
> Looking up port of RPC 100005/1 on 10.200.0.198
> RPC: sendmsg returned error 128
> portmap: RPC call returned error 128
> Root-NFS: Unable to get mountd port number from server, using default
> RPC: sendmsg returned error 128
> mount: RPC call returned error 128
> Root-NFS: Server returned error -128 while mounting /nfsroot/mipsel
> VFS: Unable to mount root fs via NFS, trying floppy.
> kmod: failed to exec /sbin/modprobe -s -k block-major-2, errno = 2
> VFS: Cannot open root device "" or 02:00
> Please append a correct "root=" boot option
> Kernel panic: VFS: Unable to mount root fs on 02:00


You might need to specify the kernel bootline options from yamon correctly.
Perhaps you are missing the "root=/dev/nfs" option.

Something like
go . nfsroot=a.b.c.d:/mnt/rootfs root=/dev/nfs

should do the trick.
