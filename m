Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Nov 2004 17:16:40 +0000 (GMT)
Received: from mproxy.gmail.com ([IPv6:::ffff:216.239.56.245]:42885 "EHLO
	mproxy.gmail.com") by linux-mips.org with ESMTP id <S8224859AbUKJRQe>;
	Wed, 10 Nov 2004 17:16:34 +0000
Received: by mproxy.gmail.com with SMTP id x71so221410cwb
        for <linux-mips@linux-mips.org>; Wed, 10 Nov 2004 09:16:28 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=NSZn+5RIGnm7h92SL3iqcdCHMJU3O6AWyRBFHzMDexGWyfwMy0jEMUX6Ns2DAeLPvX65L9hpUqW61wxo4KuCN6Raec5l//DDevOZ9fhM75Oc7Pips8WnOcyxx8eLPIKqAHvmJnZn7+kyOFBzeulIlesE5PdvqJE8bBJVF162TRo=
Received: by 10.11.100.47 with SMTP id x47mr246778cwb;
        Wed, 10 Nov 2004 09:16:28 -0800 (PST)
Received: by 10.11.98.17 with HTTP; Wed, 10 Nov 2004 09:16:28 -0800 (PST)
Message-ID: <8498a8b00411100916544a804e@mail.gmail.com>
Date: Wed, 10 Nov 2004 12:16:28 -0500
From: Kang <huangyk@gmail.com>
Reply-To: Kang <huangyk@gmail.com>
To: linux-mips@linux-mips.org
Subject: Problem caused by changing PAGE_OFFSET from 0x80000000 to 0x91000000
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <huangyk@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: huangyk@gmail.com
Precedence: bulk
X-list: linux-mips

Hello buddies,

I am working on linux-2.4.20 support for a MIPS4Kc based reference
design board. For some reason, I need to load and execute kernel at a
non-standard address
0x91xxxxxx instead of 0x80xxxxxx. 

Regarding the memory management/paging stuff, I tried changing the
PAGE_OFFSET variable to 0x91000000 in page.h, the UNCAC_BASE variable
was changed to 0xb1000000 at the same time.

So far the physical RAM map looks fine to me, the memory
initialization works fine. The RAMDISK seems like to be loaded to
correct address and the size is correct. But I got a "length error"
when the kernel tried to decompress the RAMDISK, the original length
seemed to be corrupted. The bytes_out value matched with the size of
uncompressed RAMDISK size. Then I got a "Reserved instruction in
kernel code in traps.c::do_ri, line 652:" kernel panic.

I don't know whether it is the PAGE_OFFSET change caused this problem.
Probably some page alignment issue. In addition to the PAGE_OFFSET
value change, any other place I should change to fix this problem? Can
anybody enlighten me?

The log message is attched.

Thanks a lot.

Leo

****************************************************************
Determined physical RAM map:
 memory: 00001000 @ 11000000 (reserved)
 memory: 000ef000 @ 11001000 (ROM data)
 memory: 00010000 @ 110f0000 (ROM data)
 memory: 001ac000 @ 11100000 (reserved)
 memory: 03d54000 @ 112ac000 (usable)

Initial ramdisk at: 0x912ac000 (1002027 bytes)

On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.

Kernel command line: console=ttyS0,38400
calculating r4koff... 000f422a(999978)
CPU frequency 200.00 MHz
Calibrating delay loop... 199.47 BogoMIPS
Memory: 61108k/62800k available (1376k kernel code, 1692k reserved,
92k data, 72k init, 0k highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Checking for 'wait' instruction...  available.
POSIX conformance testing by UNIFIX
Autoconfig PCI channel 0x91286db0

......................................

RAMDISK: Compressed image found at block 0
orig_len: ff74a400
bytes_out: 74a400

Freeing initrd memory: 978k freed
VFS: Mounted root (ext2 filesystem) readonly.
Freeing prom memory: 1020kb freed
Freeing unused kernel memory: 72k freed

Reserved instruction in kernel code in traps.c::do_ri, line 652:

$0 : 00000000 1050ff00 2ab07ff8 2ab07ff8 2ab05748 00000000 000008f8 000008f8
$8 : 00000038 2ab05fc8 2ab05708 00001000 00000005 00000080 913abb70 000008fa
$16: 2ab05000 913abc70 00000080 2ab05708 913d61a0 00000001 2ab05730 2aac0000
$24: 00000000 00000080                   913aa000 913abbb0 913abcd4 91156384
Hi : 00000000
Lo : 00000180
epc  : 91230d34    Not tainted
Status: 1050ff03
Cause : 30800028
  
 
The kernel hung just after the interrupt was first time opened, after
sti(), before calibrate_delay() in init/main.c. It was weird that I
didn't see any problem if I put interrupt vector to location
0x80000200 while all other exception vectors to 0x91xxxxxx.

Was interrupt vector location hardcode to the address 0x80000200? Or
some other place I need to change to walk around it. Any idea?

Thanks a bunch for your help.

Leo
