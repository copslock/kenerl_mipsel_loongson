Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2FCEqa25623
	for linux-mips-outgoing; Fri, 15 Mar 2002 04:14:52 -0800
Received: from i01sv4138.ids1.intelonline.com (i01sv4138-p.ids1.intelonline.com [147.208.166.9])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2FCEk925619
	for <linux-mips@oss.sgi.com>; Fri, 15 Mar 2002 04:14:46 -0800
Received: from i01sv0649 (unverified [10.81.26.33]) by i01sv4138.ids1.intelonline.com
 (Rockliffe SMTPRA 4.5.4) with SMTP id <B1516392835@i01sv4138.ids1.intelonline.com> for <linux-mips@oss.sgi.com>;
 Fri, 15 Mar 2002 12:16:08 +0000
Message-ID: <B1516392835@i01sv4138.ids1.intelonline.com>
From: Guo-Rong Koh <grk@start.com.au>
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
X-Originating-IP: [63.12.14.168]
Date: Fri, 15 Mar 2002 22:16:08 +1030
X-MSMail-Priority: Normal
X-mailer: AspMail 4.0 4.02 (SMT4DD4B4F)
Subject: DECStation kernel boot failure
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi all,

Still trying to get Linux on my DECStation 5000/25.
I have attached the boot (fail) log in case anyone can tell me what's
going (not) on.

Thanks,
Guo-Rong

--kernel boot dump starts here--
KN02-CA V2.0m   
>>boot 3/rz0/vmlinux - root=/dev/nfs nfsroot=192.168.2.145:/mips
ip=bootp

NetBSD/pmax 1.5.1 FFS Primary Bootstrap

NetBSD/pmax 1.5.2 Secondary Bootstrap, Revision 1.3
(root@medusa.thistledown.com.au, Aug 23 10:47:54 EST 2001)

Boot: 3/rz0/vmlinux
2224128+172576 [186+159728+155633]=0x296614
Starting at 0x80040464

This DECstation is a Personal DS5000/xx
CPU revision is: 00000230
FPU revision is: 00000340
Primary instruction cache 64kb, linesize 4 bytes
Primary data cache 64kb, linesize 4 bytes
Linux version 2.4.16 (root@elrond) (gcc version 2.96 20000731 (Red Hat
Linux 7.1 2.96-96.1)) #7 Sun Dec 23 14:57:24 MET 2001
Determined physical RAM map:
 memory: 01000000 @ 00000000 (usable)
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs nfsroot=192.168.2.145:/mips
ip=bootp
Calibrating delay loop... 24.87 BogoMIPS
Memory: 13520k/16384k available (2007k kernel code, 2864k reserved,
87k data, 76k init)
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Kernel panic: can't allocate root vfsmount
In idle task - not syncing
--kernel boot dump finishes here--


__________________________________________________________________
Get your free Australian email account at http://www.start.com.au
