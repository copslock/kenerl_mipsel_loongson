Received:  by oss.sgi.com id <S553858AbQLPJTX>;
	Sat, 16 Dec 2000 01:19:23 -0800
Received: from web1.lanscape.net ([64.240.156.194]:15878 "EHLO
        web1.lanscape.net") by oss.sgi.com with ESMTP id <S553805AbQLPJSy>;
	Sat, 16 Dec 2000 01:18:54 -0800
Received: from sumpf.cyrius.com (IDENT:root@localhost [127.0.0.1])
	by web1.lanscape.net (8.9.3/8.9.3) with ESMTP id DAA04852
	for <linux-mips@oss.sgi.com>; Sat, 16 Dec 2000 03:18:25 -0600
Received: by sumpf.cyrius.com (Postfix, from userid 1000)
	id 73D4414ED7; Sat, 16 Dec 2000 08:56:03 +0100 (CET)
Date:   Sat, 16 Dec 2000 08:56:03 +0100
From:   Martin Michlmayr <tbm@cyrius.com>
To:     linux-mips@oss.sgi.com
Subject: Kernel Oops when booting on DECstation
Message-ID: <20001216085603.A514@sumpf.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

When I boot a Linux kernel on a DECstation/125, I get the following oops:

>>boot 3/rz2/vmlinux root=/dev/sda1 console=ttyS2 root=/dev/sda1
>> NetBSD/pmax Secondary Boot, Revision 1.0
>> (root@vlad, Sat Mar  4 14:34:30 EST 2000)
Boot: 3/rz2/vmlinux
1623360+151344=0x18c540
Starting at 0x80040584

This DECstation is a DS5000/1xx
Loading R[23]00 MMU routines.
CPU revision is: 00000230
Primary instruction cache 64kb, linesize 4 bytes
Primary data cache 64kb, linesize 4 bytes
Linux version 2.4.0-test11 (bunk@r063144.stusta.swh.mhn.de) (gcc version egcs-20
Determined physical RAM map:
 memory: 02000000 @ 00000000 (usable)
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS2 root=/dev/sda1
Calibrating delay loop... 24.77 BogoMIPS
Memory: 30224k/32768k available (1453k kernel code, 2544k reserved, 68k data, 6)
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)                   Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
Unable to handle kernel paging request at virtual address 00000004, epc == 80054
Oops in fault.c:do_page_fault, line 172:
$0 : 00000000 10002000 80720410 00000000 80720410 00000000 810884d4 10002000
$8 : 00000000 00000000 00000000 00000000 00bd0000 fffffff7 ffffffff 81097180
$16: 00010f00 81094000 00000000 80048000 30464354 a0002f88 fffffff4 00010f00
$24: 00000001 0000000a                   80720000 80720f58 80721090 80059b34
epc  : 80059b7c                                                                 Status: 10002004
Cause : 30000408
Process  (pid: 0, stackpage=80720000)
Stack: 8005f564 00000001 000000c0 8005f228 801c6c6c 800f191c 00000000 00000000
       00000000 80720f7c 80720f7c 00000023 00000000 00000000 00000000 80720f7c
       80720f7c 00000023 00010f00 00010000 00000000 80048000 30464354 a0002f88
       00000200 001200d2 40208a0a 8004e168 00000000 00000020 80720fe0 00000000
       8004b42c 0000261c 00010f00 00000000 80721090 0000261c 00bd0000 fffffff7
       00000000 ...
Call Trace: [<8005f564>] [<8005f228>] [<800f191c>] [<80048000>] [<8004e168>] [<]
Code: 24630010  8e2501d4  8e230218 <8ca20004> 00000000  0043102b  10400431  241

This is with a 2.4.0-test11 kernel image compiled by Adrian Bunk.  The
image works for him.  I get virtually the same problem when booting
with Flo's test-8-pre1 image from ftp.rfc822.org:

Linux version 2.4.0-test8-pre1 (flo@slimer.rfc822.org) (gcc version egcs-2.90.20
[...]
POSIX conformance testing by UNIFIX
Unable to handle kernel paging request at virtual address 00000004, epc == 8005c
Oops in fault.c:do_page_fault, line 158:
$0 : 00000000 10002000 80720370 00000000 00000000 00001098 10002000 0000003c
$8 : 00002000 ffff00ff 00000000 00000000 00000000 00000000 801a9d94 10002001
$16: 00000f00 81098000 80048000 a000fcf8 30464354 a0002f88 fffffff4 00000f00
$24: 00000000 00000000                   80720000 80720f58 80721090 8005999c
epc  : 800599f4
Status: 10002004
Cause : 30000408
Process  (pid: 0, stackpage=80720000)
Stack: 800d7054 81086200 800613a8 00000001 00000008 80061064 00000000 00000000
       00000000 80720f7c 80720f7c 801b6737 00000000 00000000 00000000 80720f7c
       80720f7c 801b6737 00000f00 00000000 80048000 a000fcf8 30464354 a0002f88
       00000200 001200d2 40208a0a 8004e934 00000000 00000020 80720fe0 0000000a
       8004b2cc 0000003c 00000f00 00000000 80721090 0000003c 801b6748 801a9d94
       00000000 ...
Call Trace: [<800d7054>] [<800613a8>] [<80061064>] [<80048000>] [<8004e934>] [<]
Code: ac6b0004  8e2401d0  8e230214 <8c820004> 00000000  0043102b  10400442  241

Any ideas?  (I hope and think that it has nothing to do with me
booting from a NetBSD partition.  I don't have ethernet on the machine
and thus have to boot the kernel from the existing FFS partition in
order to start Linux and then run delo.  NetBSD boots and works, btw.)
-- 
Martin Michlmayr
tbm@cyrius.com
