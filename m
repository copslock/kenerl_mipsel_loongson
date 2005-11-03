Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Nov 2005 01:35:03 +0000 (GMT)
Received: from xproxy.gmail.com ([66.249.82.198]:124 "EHLO xproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133833AbVKCBel convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 3 Nov 2005 01:34:41 +0000
Received: by xproxy.gmail.com with SMTP id h27so469539wxd
        for <linux-mips@linux-mips.org>; Wed, 02 Nov 2005 17:35:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ki005+7wK4toC89NsIUA2pjdj7r1w8vkTsM3Iwohnr7S7SfiOZ0AFrQjofNjqOGvKcKpmscO6/Ti9U0QWfdKx4XX3ZXUPAgnf1MzNUVRKsd8lKT5Z38HWT1pD4hAUiepW2jN+x4r9oMYX3HPqUUlS0bfQzphyiIAyklqonIvbqg=
Received: by 10.70.35.10 with SMTP id i10mr115788wxi;
        Wed, 02 Nov 2005 17:35:26 -0800 (PST)
Received: by 10.70.130.1 with HTTP; Wed, 2 Nov 2005 17:35:25 -0800 (PST)
Message-ID: <ecb4efd10511021735m24778203rb3e816a0d9a62833@mail.gmail.com>
Date:	Wed, 2 Nov 2005 20:35:25 -0500
From:	Clem Taylor <clem.taylor@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: 2.6.14 on Au1550 panics in free_hot_cold_page from init
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <clem.taylor@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9411
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clem.taylor@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I was wondering if anyone has gotten 2.6.14 to run on an Au1550. I had
2.6.14-rc2 mostly working (except for jffs2 writes) and was previously
using 2.6.13 (had a jffs2 sync problem on reboot) and 2.6.11 (seems
okay).

I tried out a linux-mips-git tree from this afternoon
(6e47ab8b0ad1ca7bddbc086e2ce7736632c18df4). 2.6.14 is panicing right
after the 'Freeing unused kernel memory' with:

Linux version 2.6.14 (ctaylor@gort) (gcc version 3.4.4) #5 Wed Nov 2
20:06:54 EST 2005
CPU revision is: 03030200
Aquila 1550 Network Processor Board
(PRId 03030200) @ 492MHZ
BCLK switching enabled!
Determined physical RAM map:
 memory: 04000000 @ 00000000 (usable)
Built 1 zonelists
Kernel command line: root=/dev/nfs ip=bootp console=ttyS1,115200
Primary instruction cache 16kB, physically tagged, 4-way, linesize 32 bytes.
Primary data cache 16kB, 4-way, linesize 32 bytes.
Synthesized TLB refill handler (17 instructions).
Synthesized TLB load handler fastpath (34 instructions).
Synthesized TLB store handler fastpath (34 instructions).
Synthesized TLB modify handler fastpath (33 instructions).
PID hash table entries: 512 (order: 9, 8192 bytes)
calculating r4koff... 000781e0(492000)
CPU frequency 492.00 MHz
warning: LCD clock too high (61500 KHz)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 61312k/65536k available (1896k kernel code, 4096k reserved,
275k data, 136k init, 0k highmem)
Mount-cache hash table entries: 512
Checking for 'wait' instruction...  unavailable.
NET: Registered protocol family 16
JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
Serial: Au1x00 driver
ttyS0 at I/O 0xb1100000 (irq = 0) is a AU1X00_UART
ttyS1 at I/O 0xb1200000 (irq = 8) is a AU1X00_UART
ttyS2 at I/O 0xb1400000 (irq = 9) is a AU1X00_UART
io scheduler noop registered
au1000eth version 1.5 Pete Popov <ppopov@embeddedalley.com>
eth0: Au1x Ethernet found at 0xb0500000, irq 27
eth0: AMD 79C874 10/100 BaseT PHY at phy address 31
eth0: Using AMD 79C874 10/100 BaseT PHY as default
eth1: Au1x Ethernet found at 0xb0510000, irq 28
eth1: Au1x No known MII transceivers found!
Aquila1550 Flash: probing 16-bit flash bus
Aquila1550 Flash: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
Aquila1550 Flash: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
Creating 6 MTD partitions on "Aquila1550 Flash":
0x00000000-0x00e00000 : "0xbe000000:image0"
0x00e00000-0x01c00000 : "0xbee00000:image1"
0x01c00000-0x01c80000 : "0xbfc00000:u-boot"
0x01c80000-0x01fc0000 : "0xbfc80000:params"
0x01fc0000-0x01fe0000 : "0xbffc0000:u-boot env"
0x01fe0000-0x02000000 : "0xbffe0000:u-boot envcpy"
i2c /dev entries driver
Au1550 I2C: initialized.
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 2, 16384 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
Sending BOOTP requests .<6>eth0: going to full duplex
. OK
IP-Config: Got BOOTP answer from 192.168.50.23, my address is 192.168.50.243
IP-Config: Complete:
      device=eth0, addr=192.168.50.243, mask=255.255.255.0, gw=192.168.50.1,
     host=192.168.50.243, domain=, nis-domain=(none),
     bootserver=192.168.50.23, rootserver=192.168.50.23,
rootpath=/aquilaroot-cgt
Looking up port of RPC 100003/2 on 192.168.50.23
Looking up port of RPC 100005/1 on 192.168.50.23
VFS: Mounted root (nfs filesystem) readonly.
Freeing unused kernel memory: 136k freed
Bad page state at free_hot_cold_page (in process 'init', page 81006c80)
flags:0x00000400 mapping:00000000 mapcount:0 count:0
Backtrace:
Call Trace:
 [<801510b0>] bad_page+0x70/0xb4
 [<801517c0>] free_hot_cold_page+0x84/0x1d8
 [<80161848>] do_wp_page+0x34c/0x7e0
 [<801619d8>] do_wp_page+0x4dc/0x7e0
 [<801695f8>] page_add_anon_rmap+0x0/0xe0
 [<8021d054>] uart_open+0x1d8/0xab4
 [<80331ee4>] vfs_caches_init_early+0x94/0xc0
 [<8033bd00>] ip_misc_proc_init+0x64/0xf8
 [<80162b4c>] __handle_mm_fault+0x920/0x1038
 [<8033bd3c>] ip_misc_proc_init+0xa0/0xf8
 [<80333a20>] ipc_init_ids+0x20/0xbc
 [<8017f598>] chrdev_open+0xa0/0x140
 [<80189130>] may_open+0x5c/0x290
 [<8033bd30>] ip_misc_proc_init+0x94/0xf8
 [<8033bd00>] ip_misc_proc_init+0x64/0xf8
 [<80331ee4>] vfs_caches_init_early+0x94/0xc0
 [<8010ebdc>] do_page_fault+0xfc/0x3d0
 [<8016da08>] nameidata_to_filp+0x30/0x64
 [<8018e1e4>] do_ioctl+0x54/0x90
 [<8018e420>] vfs_ioctl+0x200/0x3a4
 [<8016ddcc>] get_unused_fd+0x118/0x1cc
 [<8018e614>] sys_ioctl+0x50/0x9c
 [<8016dffc>] do_sys_open+0xe4/0xec
 [<8010f5e8>] tlb_do_page_fault_1+0x100/0x108
 [<8010404c>] work_resched+0x8/0x40

Trying to fix it up, but a reboot is needed
init started:  BusyBox v1.00 (2005.09.24-00:33+0000) multi-call binary
Break instruction in kernel code[#1]:
Cpu 0
$ 0   : 00000000 1000fc00 00000001 00000000
$ 4   : 81006c80 81006c80 00000000 00000000
$ 8   : 00000000 00000000 000000d8 0000d918
$12   : 80340000 81006c80 8032e590 2ab97a4c
$16   : 8112c008 80000000 00000590 004b2130
$20   : 803314ec 8033bd00 00000000 8032e590
$24   : 2ab926dc 2abb3834
$28   : 810a0000 810a1dd0 80350000 801626d8
Hi    : 00000000
Lo    : 0000012c
epc   : 801697c0 page_add_file_rmap+0xe8/0xf4     Tainted: G    B
ra    : 801626d8 __handle_mm_fault+0x4ac/0x1038
Status: 1000fc03    KERNEL EXL IE
Cause : 00800024
PrId  : 03030200
Process init (pid: 1, threadinfo=810a0000, task=8036bbe8)
Stack : 803772a0 80333998 01b42f73 00000004 810ad005 00001000 810a1ed0 810a1ed0
        00000000 00000000 00000000 00000000 000000d8 0000d918 000000d8 0000d918
        000000d8 0000d918 810a1f18 7f90fc00 80374aa8 803772a0 004ba000 8033bd00
        004b9000 00000401 00000001 00000000 8033bd30 8036bbe8 8033bd00 004b2130
        803314ec 810a1f30 00030000 00000000 004683f0 8010ebdc 8033f9f0 801bd9f0
        ...
Call Trace:
 [<80333998>] ipc_init_proc_interface+0x58/0xc0
 [<8033bd00>] ip_misc_proc_init+0x64/0xf8
 [<8033bd30>] ip_misc_proc_init+0x94/0xf8
 [<8033bd00>] ip_misc_proc_init+0x64/0xf8
 [<803314ec>] kmem_cache_init+0x1c8/0x58c
 [<8010ebdc>] do_page_fault+0xfc/0x3d0
 [<801bd9f0>] nfs_permission+0xf8/0x208
 [<80188018>] path_lookup+0xe0/0x3d0
 [<80184cd8>] getname+0x28/0xf8
 [<80333998>] ipc_init_proc_interface+0x58/0xc0
 [<8019430c>] dput+0x190/0x21c
 [<8033bd00>] ip_misc_proc_init+0x64/0xf8
 [<80185138>] path_release+0x18/0xd4
 [<8016cd30>] sys_access+0x15c/0x164
 [<80333998>] ipc_init_proc_interface+0x58/0xc0
 [<8033bd00>] ip_misc_proc_init+0x64/0xf8
 [<8016efcc>] sys_read+0x54/0xa0
 [<80167030>] sys_brk+0x118/0x15c
 [<8016dffc>] do_sys_open+0xe4/0xec
 [<8010f4e0>] tlb_do_page_fault_0+0x100/0x108
 [<8010d0c0>] stack_done+0x20/0x3c

Code: 0200000d  0805a5c4  3c028034 <0200000d> 0805a5bb  3c038035 
3c028034  8c4326e8  3c020002
Kernel panic - not syncing: Attempted to kill init!

This is without support for the PCI device. With support for the PCI
device it fails in a similar path, but from pci_scan_single_device.

Any ideas what might be going on? Is anyone working with 2.6.14 with
the Au1550 (or Au1xxx) processors?

                                 Thanks,
                                 Clem
