Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jul 2005 21:19:01 +0100 (BST)
Received: from pasta.sw.starentnetworks.com ([IPv6:::ffff:12.33.234.10]:6340
	"EHLO pasta.sw.starentnetworks.com") by linux-mips.org with ESMTP
	id <S8225787AbVG2USl>; Fri, 29 Jul 2005 21:18:41 +0100
Received: from cortez.sw.starentnetworks.com (cortez.sw.starentnetworks.com [12.33.233.12])
	by pasta.sw.starentnetworks.com (Postfix) with ESMTP id 8331F149713
	for <linux-mips@linux-mips.org>; Fri, 29 Jul 2005 16:21:19 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17130.36799.356429.894451@cortez.sw.starentnetworks.com>
Date:	Fri, 29 Jul 2005 16:21:19 -0400
From:	Dave Johnson <djohnson+linuxmips@sw.starentnetworks.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH] memory leak in sys_sendmsg()/sys_recvmsg() with MSG_CMSG_COMPAT
X-Mailer: VM 7.07 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Return-Path: <djohnson@sw.starentnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8662
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: djohnson+linuxmips@sw.starentnetworks.com
Precedence: bulk
X-list: linux-mips


sendmsg()/recvmsg() syscalls from o32/n32 apps to a 64bit kernel will
cause a kernel memory leak if iov_len > UIO_FASTIOV for each syscall!

This is because both sys_sendmsg() and verify_compat_iovec() kmalloc a
new iovec structure.  Only the one from sys_sendmsg() is free'ed.

I wrote a simple test program to confirm this after identifying the
problem:

http://davej.org/programs/testsendmsg.c


Running it shows the leak in the slab:

$ grep '^size-256 ' /proc/slabinfo
size-256           55972  55972    280   14    1 : tunables   32   16    8 : slabdata   3998   3998      0 : globalstat   58914  55972  4001    3    0    0   46    0 : cpustat 3806737   4480 3755027    240
$ ./testsendmsg
iterations=100 vec_size=16 block_size=256
$ grep '^size-256 ' /proc/slabinfo
size-256           56168  56168    280   14    1 : tunables   32   16    8 : slabdata   4012   4012      0 : globalstat   59110  56168  4015    3    0    0   46    0 : cpustat 3853259   4494 3801362    240
$ ./testsendmsg
iterations=100 vec_size=16 block_size=256
$ grep '^size-256 ' /proc/slabinfo
size-256           56378  56378    280   14    1 : tunables   32   16    8 : slabdata   4027   4027      0 : globalstat   59320  56378  4030    3    0    0   46    0 : cpustat 3853910   4509 3801828    240
$ ./testsendmsg
iterations=100 vec_size=16 block_size=256
$ grep '^size-256 ' /proc/slabinfo
size-256           56574  56574    280   14    1 : tunables   32   16    8 : slabdata   4041   4041      0 : globalstat   59516  56574  4044    3    0    0   46    0 : cpustat 3854888   4523 3802620    240
$ ./testsendmsg
iterations=100 vec_size=16 block_size=256
$ grep '^size-256 ' /proc/slabinfo
size-256           56756  56756    280   14    1 : tunables   32   16    8 : slabdata   4054   4054      0 : globalstat   59698  56756  4057    3    0    0   46    0 : cpustat 3856397   4536 3803942    240
$ ./testsendmsg
iterations=100 vec_size=16 block_size=256
$ grep '^size-256 ' /proc/slabinfo
size-256           56966  56966    280   14    1 : tunables   32   16    8 : slabdata   4069   4069      0 : globalstat   59908  56966  4072    3    0    0   46    0 : cpustat 3858528   4551 3805888    240
$ ./testsendmsg
iterations=100 vec_size=16 block_size=256
$ grep '^size-256 ' /proc/slabinfo
size-256           57176  57176    280   14    1 : tunables   32   16    8 : slabdata   4084   4084      0 : globalstat   60118  57176  4087    3    0    0   46    0 : cpustat 3863987   4566 3811162    240
$ ./testsendmsg
iterations=100 vec_size=16 block_size=256
$ grep '^size-256 ' /proc/slabinfo
size-256           57358  57358    280   14    1 : tunables   32   16    8 : slabdata   4097   4097      0 : globalstat   60300  57358  4100    3    0    0   46    0 : cpustat 3864397   4579 3811385    240


Note that the below fix will break solaris_sendmsg()/solaris_recvmsg()
as it also calls verify_compat_iovec() but expects it to malloc
internally.

-- 
Dave Johnson
Starent Networks

=========================

diff -Nru a/net/compat.c b/net/compat.c
--- a/net/compat.c	2005-07-29 16:12:39 -04:00
+++ b/net/compat.c	2005-07-29 16:12:39 -04:00
@@ -91,20 +91,11 @@
 	} else
 		kern_msg->msg_name = NULL;
 
-	if(kern_msg->msg_iovlen > UIO_FASTIOV) {
-		kern_iov = kmalloc(kern_msg->msg_iovlen * sizeof(struct iovec),
-				   GFP_KERNEL);
-		if(!kern_iov)
-			return -ENOMEM;
-	}
-
 	tot_len = iov_from_user_compat_to_kern(kern_iov,
 					  (struct compat_iovec __user *)kern_msg->msg_iov,
 					  kern_msg->msg_iovlen);
 	if(tot_len >= 0)
 		kern_msg->msg_iov = kern_iov;
-	else if(kern_msg->msg_iovlen > UIO_FASTIOV)
-		kfree(kern_iov);
 
 	return tot_len;
 }
