Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Oct 2003 14:32:49 +0100 (BST)
Received: from [IPv6:::ffff:203.129.212.34] ([IPv6:::ffff:203.129.212.34]:41484
	"HELO mail.contechsoftware.com") by linux-mips.org with SMTP
	id <S8225447AbTJRNcR>; Sat, 18 Oct 2003 14:32:17 +0100
Received: (from prabhakar [200.1.1.48])
 by mail.contechsoftware.com (SAVSMTP 3.0.0.44) with SMTP id M2003101819102814240
 for <linux-mips@linux-mips.org>; Sat, 18 Oct 2003 19:10:29 +0530
Received: by localhost with Microsoft MAPI; Sat, 18 Oct 2003 19:12:32 -0000
Message-ID: <01C395AB.C7C9C020.prabhakark@contechsoftware.com>
From: Prabhakar <prabhakark@contechsoftware.com>
Reply-To: "prabhakark@contechsoftware.com" <prabhakark@contechsoftware.com>
To: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Root fs with NFS problem...
Date: Sat, 18 Oct 2003 19:12:30 -0000
Organization: Contech Software Limited.
X-Mailer: Microsoft Internet E-mail/MAPI - 8.0.0.4211
Encoding: 37 TEXT
Return-Path: <prabhakark@contechsoftware.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3451
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prabhakark@contechsoftware.com
Precedence: bulk
X-list: linux-mips

Hi all,

I'm trying to boot through NFS using rootfs,I'm got struck like...


au1000eth.c:1.4 ppopov@mvista.com
eth0: Au1x Ethernet found at 0xb1500000, irq 28
eth0: AMD 79C874 10/100 BaseT PHY at phy address 0
eth0: Using AMD 79C874 10/100 BaseT PHY as default
eth1: Au1x Ethernet found at 0xb1510000, irq 29
eth1: AMD 79C874 10/100 BaseT PHY at phy address 0
eth1: Using AMD 79C874 10/100 BaseT PHY as default
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
IP-Config: Incomplete network configuration information.
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Root-NFS: No NFS server available, giving up.
VFS: Unable to mount root fs via NFS, trying floppy.
kmod: failed to exec /sbin/modprobe -s -k block-major-2, errno = 2
VFS: Cannot open root device "nfs" or 02:00
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 02:00


I have created rootfs and configured NFS  from host end and Target but
i don't know where to put my kernel commandline parameters...

I'm doing something wrong in nfs setup, i couldn't find it out.

can anybody help me what are all configurations i have to do from host end and target end to get boot my target using rootfs by NFS.

It could be a great help for me,

Prabhakar
