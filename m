Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4F8l3nC020718
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 15 May 2002 01:47:03 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4F8l3wA020717
	for linux-mips-outgoing; Wed, 15 May 2002 01:47:03 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from brahma.intotoind.com ([202.56.196.162])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4F8kfnC020705
	for <linux-mips@oss.sgi.com>; Wed, 15 May 2002 01:46:46 -0700
Received: from localhost (rajeshbv@localhost)
	by brahma.intotoind.com (8.9.3/8.8.7) with ESMTP id OAA14608
	for <linux-mips@oss.sgi.com>; Wed, 15 May 2002 14:12:25 +0530
X-Authentication-Warning: brahma.intotoind.com: rajeshbv owned process doing -bs
Date: Wed, 15 May 2002 14:12:25 +0530 (IST)
From: Venkata Rajesh Bikkina <rajeshbv@intotoinc.com>
X-Sender: rajeshbv@brahma.intotoind.com
To: linux-mips@oss.sgi.com
Subject: RAMDISK problem on 79s334A board.
Message-ID: <Pine.LNX.4.10.10205151403260.14414-100000@brahma.intotoind.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi All,

I am working on 79s334A board with 32MB RAM and Linux 2.4.13 kernel. 
I have module to be inserted into kernel. The size of the module will be
around 1 MB.
I am using two file systems while building kernel image, one is NFS and
the other is RAMDISK.
When i work with NFS i do not have any problem.

But when i build RAMDISK image and insert the module, insmod is
doing fine. But after that i could not invoke any other application ( even
ps -ef is also giving segmentation fault.)
The RAMDISK size choosen is 10MB and the memory on board is 32MB.
When i did cat /proc/meminfo i found strange thing. All the figures are
corrupted.

The statistics before and after insmod are as follows:

# cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  29237248 15319040 13918208        0 10240000  2908160
Swap:        0        0        0
MemTotal:        28552 kB
MemFree:         13592 kB
MemShared:           0 kB
Buffers:         10000 kB
Cached:           2840 kB
Active:          12840 kB
Inact_dirty:         0 kB
Inact_clean:         0 kB
Inact_target:       44 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        28552 kB
LowFree:         13592 kB
SwapTotal:           0 kB
SwapFree:            0 kB
#
#
# cd /igateway
# /sbin/insmod igateway
Intoto Firewall Installed.
#
#
# /sbin/lsmod
Module                  Size  Used by
igateway              967056   0 (unused)
#
#
# cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  %8lu %8lu %8lu %8lu %8lu %8u
Swap: %8lu %8lu %8lu
MemTotal:     %8lu kB
MemFree:      %8lu kB
MemShared:    %8lu kB
Buffers:      %8lu kB
Cached:       %8u kB
Active:       %8u kB
Inact_dirty:  %8u kB
Inact_clean:  %8u kB
Inact_target: %8lu kB
HighTotal:    %8lu kB
HighFree:     %8lu kB
LowTotal:     %8lu kB
LowFree:      %8lu kB
SwapTotal:    %8lu kB
SwapFree:     %8lu kB
#
#
# ps -ef
  PID  Uid      Gid State Command
Segmentation fault
# 

Can anybody give hint what is happening. 

Thanks and Regards,
--Rajesh
