Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0GAqos22306
	for linux-mips-outgoing; Wed, 16 Jan 2002 02:52:50 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0GAqgP22303
	for <linux-mips@oss.sgi.com>; Wed, 16 Jan 2002 02:52:42 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id BAA06048
	for <linux-mips@oss.sgi.com>; Wed, 16 Jan 2002 01:52:35 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id BAA00016
	for <linux-mips@oss.sgi.com>; Wed, 16 Jan 2002 01:52:32 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g0G9qEA25493
	for <linux-mips@oss.sgi.com>; Wed, 16 Jan 2002 10:52:15 +0100 (MET)
Message-ID: <3C454D61.ACF98623@mips.com>
Date: Wed, 16 Jan 2002 10:52:33 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: fsck fails on latest 2.4 kernel
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I have checked out the latest 2.4 kernel sources and tried to run it on
my Malta board with an IDE disk, but fsck fails.
EPC points at __wake_up, which is called from __alloc_pages.

Has anyone encountered a similar problem ?


Checking root filesystem
/dev/hda1 was not cleanly unmounted, check forced.
Oops in fault.c:do_page_fault, line 204:
$0 : 00000000 9000fc00 00000000 00000000 0000001a 802b5d0c 83b72000
811e94e0
$8 : 00001000 00000001 801374c4 00000003 00000000 83b73ed0 00068db8
7fff7688
$16: 00000000 9000fc00 00000001 9000fc01 802c0078 802bc628 00000001
83ce23c0
$24: 00000000 0046a040                   83b72000 83b73df0 83b73df0
8011239c
Hi : 00000000
Lo : 00000000
epc  : 801123ec    Not tainted
Status: 9000fc02
Cause : 80800008
Process fsck.ext2 (pid: 50, stackpage=83b72000)
Stack: 83ce23c0 0000001f 00001000 83ce23c0 802c0a38 00000001 00000000
8115c320
       802c08dc 802c0a2c 000001d0 8115c260 80131278 810140e4 000889c5
00000000
       00001000 8115c260 80127928 00000002 81121b58 00000000 00000000
8115c320
       00088a3d 00000000 00001000 80130e70 81121978 810140c0 00000000
8115c320
       801285a0 8012847c 8025c1e0 00000001 802bf000 00000000 00000000
81163060
       ffffffea ...
Call Trace: [<80131278>] [<80127928>] [<80130e70>] [<801285a0>]
[<8012847c>] [<8
025c1e0>]
 [<80128a7c>] [<80128974>] [<80118c5c>] [<8013759c>] [<80137398>]
[<8010d368>]

Code: 12400004  00000000  8e100000 <5614ffcc> 8e05fffc  40016000
32730001  3421
0001  38210001
[/sbin/fsck.ext2 -- /] fsck.ext2 -a /dev/hda1
Warning... fsck.ext2 for device /dev/hda1 exited with signal 11.
[FAILED]


/Carsten


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
