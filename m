Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jan 2009 08:44:15 +0000 (GMT)
Received: from mail.bugwerft.de ([212.112.241.193]:5539 "EHLO mail.bugwerft.de")
	by ftp.linux-mips.org with ESMTP id S21366063AbZA0IoN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Jan 2009 08:44:13 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.bugwerft.de (Postfix) with ESMTP id D877E49400C
	for <linux-mips@linux-mips.org>; Tue, 27 Jan 2009 09:44:07 +0100 (CET)
Received: from mail.bugwerft.de ([127.0.0.1])
	by localhost (mail.bugwerft.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bbtM+o9PEzjX for <linux-mips@linux-mips.org>;
	Tue, 27 Jan 2009 09:44:07 +0100 (CET)
Received: from [10.1.1.26] (unknown [192.168.22.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bugwerft.de (Postfix) with ESMTP id 9BD4949400B
	for <linux-mips@linux-mips.org>; Tue, 27 Jan 2009 09:44:06 +0100 (CET)
Subject: AU1550 Kernel bug detected[#1]  clockevents_register_device
From:	Frank Neuber <linux-mips@kernelport.de>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Date:	Tue, 27 Jan 2009 09:44:02 +0100
Message-Id: <1233045842.28527.459.camel@t60p>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.1 
Content-Transfer-Encoding: 8bit
Return-Path: <linux-mips@kernelport.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21826
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux-mips@kernelport.de
Precedence: bulk
X-list: linux-mips

Hi,
to find my PCI problem I want to use git to find the last working
version.
I just start with head and found a compile error:
arch/mips/alchemy/common/time.c:93: error: incompatible types in
initialization
I comment this line ".cpumask        = CPU_MASK_ALL,"
and build again.
This is the result. Somethig is wrong with the timer ...

<5>Linux version 2.6.29-rc2-00351-g5ee8100-dirty (neuber@t60p) (gcc
version 4.0.0 (DENX ELDK 4.1 4.0.0)) #2 Tue Jan 27 09:03:59 CET 2009
<6>CPU revision is: 03030200 (Au1550)
<6>(PRId 03030200) @ 336.00 MHz
<6>AMD Alchemy Au1550/Db1550 Board
<6>Determined physical RAM map:
<6> memory: 08000000 @ 00000000 (usable)
<4>Zone PFN ranges:
<4>  Normal   0x00000000 -> 0x00008000
<4>Movable zone start PFN for each node
<4>early_node_map[1] active PFN ranges
<4>    0: 0x00000000 -> 0x00008000
<7>On node 0 totalpages: 32768
<7>free_area_init_node: node 0, pgdat 804c5b00, node_mem_map 81000000
<7>  Normal zone: 256 pages used for memmap
<7>  Normal zone: 0 pages reserved
<7>  Normal zone: 32512 pages, LIFO batch:7
<4>Built 1 zonelists in Zone order, mobility grouping on.  Total pages:
32512
<5>Kernel command line: console=ttyS0,115200n8 panic=1
ip=192.168.100.101::192.168.100.100:255.255.255.0:tc:eth0:off
root=/dev/mtdblock0 rw rootfstype=jffs2
<4>Primary instruction cache 16kB, VIPT, 4-way, linesize 32 bytes.
<4>Primary data cache 16kB, 4-way, VIPT, no aliases, linesize 32 bytes
<4>PID hash table entries: 512 (order: 9, 2048 bytes)
<4>Kernel bug detected[#1]:
<4>Cpu 0
<4>$ 0   : 00000000 00032954 00000000 00000001
<4>$ 4   : 804ab750 00000000 0003b9ad 00000000
<4>$ 8   : 000225c1 00000000 000225c1 00000000
<4>$12   : 00000000 00000000 3b9aca00 804ab6e0
<4>$16   : 804ab750 804ab750 804f0000 804f0000
<4>$20   : 00ff0000 87fb4298 00000002 00000000
<4>$24   : 804a9d00 8011d8fc                  
<4>$28   : 804a8000 804a9f58 87ff7ab0 804c9814
<4>Hi    : 00000008
<4>Lo    : 00000000
<4>epc   : 8015e554 clockevents_register_device+0x34/0x110
<4>    Not tainted
<4>ra    : 804c9814 plat_time_init+0x1ac/0x26c
<4>Status: 10003c02    KERNEL EXL 
<4>Cause : 00808034
<4>PrId  : 03030200 (Au1550)
<4>Modules linked in:
<4>Process swapper (pid: 0, threadinfo=804a8000, task=804aa000,
tls=00000000)
<4>Stack : 804ab6e0 8015d1ec 804c9634 87fb4298 804ab750 804ee585
804f0000 804f0000
<4>        00ff0000 804c9814 804e7914 804ee585 804f0000 804f0000
804e7914 804c87f4
<4>        00000000 804e7914 00000316 00000316 804c82cc 00000000
804ee500 00000000
<4>        20000000 00000000 00000000 ff000000 87ff17b8 00000000
00000000 00000000
<4>        00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000
<4>        ...
<4>Call Trace:
<4>[<8015e554>] clockevents_register_device+0x34/0x110
<4>[<804c9814>] plat_time_init+0x1ac/0x26c
<4>[<804c87f4>] start_kernel+0x1f8/0x3e4
<4>
<4>
<4>Code: 00028036  8c830020  2c630001 <00038036> 8c820010  1040002c
24020001  3c10804b  8e03e558 
<0>Kernel panic - not syncing: Attempted to kill the idle task!
<0>Rebooting in 1 seconds..<5>
<4>** Resetting Integrated �
