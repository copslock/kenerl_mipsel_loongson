Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2006 10:42:52 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.171]:32139 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20021285AbWJSJmu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Oct 2006 10:42:50 +0100
Received: by ug-out-1314.google.com with SMTP id 40so424163uga
        for <linux-mips@linux-mips.org>; Thu, 19 Oct 2006 02:42:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=F0Ret0BcwPu1mkU9lb5btgFQrINV+XjGXYbn9Nyr5t6Dg7EllFvLQvozE9bdqOMTX1pzHRSYL9mmg5K4YwKHPoI6s8woZ3qvc4vfcq4XnAUgOLD6O/gOnESI89xfUVRi6CNAMMVf1bppkXvIkZ0H+1WLscK8TwsZwWQKgQdHqWs=
Received: by 10.67.24.13 with SMTP id b13mr13456451ugj;
        Thu, 19 Oct 2006 02:42:49 -0700 (PDT)
Received: by 10.66.240.8 with HTTP; Thu, 19 Oct 2006 02:42:49 -0700 (PDT)
Message-ID: <417f1b740610190242h2a39da81l7f2763e79e457736@mail.gmail.com>
Date:	Thu, 19 Oct 2006 15:12:49 +0530
From:	"Pramod P K" <pra.engr@gmail.com>
To:	linux-mtd@lists.infradead.org, linux-mips@linux-mips.org
Subject: OOPS with JFFS2, MIPS
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_217232_6585938.1161250969461"
Return-Path: <pra.engr@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13020
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pra.engr@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_217232_6585938.1161250969461
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Iam using MIPS, Big Endian, with AMD/Fujitsu Spansion CFI flash.

I have Rootfs(jffs2) in flash, Linux-2.6.15 in RAM. Trying to mount Rootfs
(jffs2). but gives OOPS, and then kernel panic !!
I have traced the disassembled part of it. Got the location of OOPS but dont
know why

Please .. help me out.


MSP flash device "flash0": 0x00800000 at 0x1f800000
flash0: Found 1 x16 devices at 0x0 in 8-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
Using buffer write method
flash0: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
Creating 6 MTD partitions on "flash0":
0x00480000-0x007f0000 : " General partition"
mtd: Giving out device 0 to  General partition
0x00400000-0x00470000 : " pmon"
mtd: Giving out device 1 to  pmon
0x00470000-0x00480000 : " pmon script"
mtd: Giving out device 2 to  pmon script
0x00010000-0x00400000 : " Linux"
mtd: Giving out device 3 to  Linux
0x007f0000-0x00800000 : " Copyprotected space end"
mtd: Giving out device 4 to  Copyprotected space end
0x00000000-0x00010000 : " Copyprotected space start"
mtd: Giving out device 5 to  Copyprotected space start
MSP flash device "flash1": 0x00bf0000 at 0x1e000000
flash1: Found 1 x16 devices at 0x0 in 8-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
Using buffer write method
flash1: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
Creating 1 MTD partitions on "flash1":
0x00000000-0x00bf0000 : " Root Filesystem jffs2"
mtd: Giving out device 6 to  Root Filesystem jffs2

...........
..........
<skipped some statements here>
..........
..........

CPU 0 Unable to handle kernel paging request at virtual address 00000000,
epc == 80121f30, ra == 80121fe0
Oops[#1]:
Cpu 0
$ 0   : 00000000 00000000 00000003 00000000
$ 4   : 80490554 00000003 00000001 00000000
$ 8   : ffffffff 87e02488 00000000 00000008
$12   : 8048bb80 87e02480 ffffffff 00000010
$16   : 00000001 0000fff8 00000001 80490554
$20   : 00000000 00000000 00000003 80490500
$24   : 00000000 80298d08
$28   : 8048a000 8048ba98 8048ba98 80121fe0
Hi    : 00000000
Lo    : 000000bf
epc   : 80121f30 __wake_up_common+0x44/0xb8     Not tainted
ra    : 80121fe0 __wake_up+0x3c/0x98
Status: 11005802    KERNEL EXL
Cause : 80800008
BadVA : 00000000
PrId  : 00019522
Modules linked in:
Process swapper (pid: 1, threadinfo=8048a000, task=8049fbe8)
Stack : 00000000 00000000 80460000 87e04e00 00000001 0000fff8 00000000
811aa030
        80490538 00000000 00000008 8048bad0 80121fe0 8049fbe8 80121ecc
00000000
        00000000 804659de 00000000 00000035 80490538 00000008 802988ec
0000fff8
        0000fff8 811aa030 80490538 00000000 00000008 80490500 000023d0
80298fa8
        00000002 8048bc38 00000010 87fc8908 00000000 80490500 0000fff8
80490500
        ...
Call Trace:
 [<80121fe0>] __wake_up+0x3c/0x98
 [<80121ecc>] default_wake_function+0x0/0x20
 [<802988ec>] put_chip+0x7c/0x1fc
 [<80298fa8>] cfi_amdstd_read+0x2a0/0x3d8
 [<80203eec>] jffs2_fill_scan_buf+0x3c/0xc8
 [<801280d0>] printk+0x1c/0x28
 [<80204280>] jffs2_scan_medium+0x16c/0x19a8
 [<80170928>] __get_vm_area_node+0x25c/0x284
 [<80170de4>] __vmalloc_area_node+0x104/0x1bc
 [<80208f5c>] jffs2_do_mount_fs+0x1fc/0x9b0
 [<8020c578>] jffs2_do_fill_super+0x108/0x360
 [<801280d0>] printk+0x1c/0x28
 [<8020cd6c>] jffs2_get_sb_mtd+0x10c/0x1d4
 [<8020cc9c>] jffs2_get_sb_mtd+0x3c/0x1d4
 [<8018fb00>] path_release+0x18/0x48
 [<8020d084>] jffs2_get_sb+0x1a8/0x2a4
 [<801a5688>] mntput_no_expire+0x2c/0x140
 [<80191d98>] link_path_walk+0x114/0x2f4
 [<8012e9bc>] tasklet_action+0xa4/0x134
 [<801a4e6c>] alloc_vfsmnt+0xcc/0x10c
 [<801a4d58>] get_fs_type+0x220/0x268
 [<80186748>] do_kern_mount+0x68/0x180
 [<80186710>] do_kern_mount+0x30/0x180
 [<80192088>] path_lookup+0x110/0x3a0
 [<801a7524>] do_mount+0x5c4/0x7ec
 [<801a7068>] do_mount+0x108/0x7ec
 [<8013fdc0>] rcu_process_callbacks+0x24/0x48
 [<8012e9bc>] tasklet_action+0xa4/0x134
 [<80158420>] get_page_from_freelist+0x580/0x5a8
 [<8012e444>] __do_softirq+0x84/0x130
 [<80158420>] get_page_from_freelist+0x580/0x5a8
 [<8012e558>] do_softirq+0x68/0x80
 [<801584ac>] __alloc_pages+0x64/0x344
 [<8015d160>] cache_alloc_refill+0x27c/0x69c
 [<801587c8>] __get_free_pages+0x3c/0x88
 [<8015c918>] kmem_cache_alloc+0x6c/0x74
 [<8019de08>] dput+0x34/0x398
 [<801a6e78>] copy_mount_options+0x38/0x120
 [<8018f5b8>] getname+0x28/0x100
 [<801a7ca8>] sys_mount+0xac/0x108
 [<801a7c40>] sys_mount+0x44/0x108
 [<80194000>] sys_mknod+0x188/0x2ac
 [<80194e78>] sys_unlink+0x1cc/0x2c4
 [<8043ea10>] mount_block_root+0xe8/0x2dc
 [<8043e96c>] mount_block_root+0x44/0x2dc
 [<8013e65c>] flush_cpu_workqueue+0x388/0x390
 [<801773ec>] sys_access+0x7c/0x15c
 [<8043ee0c>] prepare_namespace+0x74/0x14c
 [<8013e690>] flush_workqueue+0x2c/0x38
 [<801002c0>] init+0x230/0x2e0
 [<80103dbc>] kernel_thread_helper+0x10/0x18
 [<80103dac>] kernel_thread_helper+0x0/0x18

Code: 00a0b021  00c09021  00e0a821 <10730010> 8c710000  2464fff4  8c820008
8c70fff4  02c02821
Kernel panic - not syncing: Attempted to kill init!



thanks,

pk

------=_Part_217232_6585938.1161250969461
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>&nbsp;</div>
<div>Iam using MIPS, Big Endian, with AMD/Fujitsu Spansion CFI flash.</div>
<div>&nbsp;</div>
<div>I have Rootfs(jffs2) in flash, Linux-2.6.15 in RAM. Trying to mount Rootfs (jffs2). but gives OOPS, and then kernel panic !!</div>
<div>I have traced the disassembled part of it. Got&nbsp;the location of OOPS but dont know why</div>
<div>&nbsp;</div>
<div>Please .. help me out.</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>MSP flash device &quot;flash0&quot;: 0x00800000 at 0x1f800000<br>flash0: Found 1 x16 devices at 0x0 in 8-bit bank<br>&nbsp;Amd/Fujitsu Extended Query Table at 0x0040<br>Using buffer write method<br>flash0: CFI does not contain boot bank location. Assuming top. 
<br>number of CFI chips: 1<br>cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.<br>Creating 6 MTD partitions on &quot;flash0&quot;:<br>0x00480000-0x007f0000 : &quot; General partition&quot;<br>mtd: Giving out device 0 to&nbsp; General partition 
<br>0x00400000-0x00470000 : &quot; pmon&quot;<br>mtd: Giving out device 1 to&nbsp; pmon<br>0x00470000-0x00480000 : &quot; pmon script&quot;<br>mtd: Giving out device 2 to&nbsp; pmon script<br>0x00010000-0x00400000 : &quot; Linux&quot; 
<br>mtd: Giving out device 3 to&nbsp; Linux<br>0x007f0000-0x00800000 : &quot; Copyprotected space end&quot;<br>mtd: Giving out device 4 to&nbsp; Copyprotected space end<br>0x00000000-0x00010000 : &quot; Copyprotected space start&quot; 
<br>mtd: Giving out device 5 to&nbsp; Copyprotected space start<br>MSP flash device &quot;flash1&quot;: 0x00bf0000 at 0x1e000000<br>flash1: Found 1 x16 devices at 0x0 in 8-bit bank<br>&nbsp;Amd/Fujitsu Extended Query Table at 0x0040 
<br>Using buffer write method<br>flash1: CFI does not contain boot bank location. Assuming top.<br>number of CFI chips: 1<br>cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.<br>Creating 1 MTD partitions on &quot;flash1&quot;: 
<br>0x00000000-0x00bf0000 : &quot; Root Filesystem jffs2&quot;<br>mtd: Giving out device 6 to&nbsp; Root Filesystem jffs2</div>
<div>&nbsp;</div>
<div>...........</div>
<div>..........</div>
<div>&lt;skipped some statements here&gt;</div>
<div>..........</div>
<div>..........</div>
<div>
<p>CPU 0 Unable to handle kernel paging request at virtual address 00000000, epc == 80121f30, ra == 80121fe0<br>Oops[#1]:<br>Cpu 0<br>$ 0&nbsp;&nbsp; : 00000000 00000000 00000003 00000000<br>$ 4&nbsp;&nbsp; : 80490554 00000003 00000001 00000000 
<br>$ 8&nbsp;&nbsp; : ffffffff 87e02488 00000000 00000008<br>$12&nbsp;&nbsp; : 8048bb80 87e02480 ffffffff 00000010<br>$16&nbsp;&nbsp; : 00000001 0000fff8 00000001 80490554<br>$20&nbsp;&nbsp; : 00000000 00000000 00000003 80490500<br>$24&nbsp;&nbsp; : 00000000 80298d08<br>
$28&nbsp;&nbsp; : 8048a000 8048ba98 8048ba98 80121fe0<br>Hi&nbsp;&nbsp;&nbsp; : 00000000<br>Lo&nbsp;&nbsp;&nbsp; : 000000bf<br>epc&nbsp;&nbsp; : 80121f30 __wake_up_common+0x44/0xb8&nbsp;&nbsp;&nbsp;&nbsp; Not tainted<br>ra&nbsp;&nbsp;&nbsp; : 80121fe0 __wake_up+0x3c/0x98<br>Status: 11005802&nbsp;&nbsp;&nbsp; KERNEL EXL<br>
Cause : 80800008<br>BadVA : 00000000<br>PrId&nbsp; : 00019522<br>Modules linked in:<br>Process swapper (pid: 1, threadinfo=8048a000, task=8049fbe8)<br>Stack : 00000000 00000000 80460000 87e04e00 00000001 0000fff8 00000000 811aa030 
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 80490538 00000000 00000008 8048bad0 80121fe0 8049fbe8 80121ecc 00000000<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00000000 804659de 00000000 00000035 80490538 00000008 802988ec 0000fff8<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000fff8 811aa030 80490538 00000000 00000008 80490500 000023d0 80298fa8 
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00000002 8048bc38 00000010 87fc8908 00000000 80490500 0000fff8 80490500<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ...<br>Call Trace:<br>&nbsp;[&lt;80121fe0&gt;] __wake_up+0x3c/0x98<br>&nbsp;[&lt;80121ecc&gt;] default_wake_function+0x0/0x20<br>&nbsp;[&lt;802988ec&gt;] put_chip+0x7c/0x1fc 
<br>&nbsp;[&lt;80298fa8&gt;] cfi_amdstd_read+0x2a0/0x3d8<br>&nbsp;[&lt;80203eec&gt;] jffs2_fill_scan_buf+0x3c/0xc8<br>&nbsp;[&lt;801280d0&gt;] printk+0x1c/0x28<br>&nbsp;[&lt;80204280&gt;] jffs2_scan_medium+0x16c/0x19a8<br>&nbsp;[&lt;80170928&gt;] __get_vm_area_node+0x25c/0x284 
<br>&nbsp;[&lt;80170de4&gt;] __vmalloc_area_node+0x104/0x1bc<br>&nbsp;[&lt;80208f5c&gt;] jffs2_do_mount_fs+0x1fc/0x9b0<br>&nbsp;[&lt;8020c578&gt;] jffs2_do_fill_super+0x108/0x360<br>&nbsp;[&lt;801280d0&gt;] printk+0x1c/0x28<br>&nbsp;[&lt;8020cd6c&gt;] jffs2_get_sb_mtd+0x10c/0x1d4 
<br>&nbsp;[&lt;8020cc9c&gt;] jffs2_get_sb_mtd+0x3c/0x1d4<br>&nbsp;[&lt;8018fb00&gt;] path_release+0x18/0x48<br>&nbsp;[&lt;8020d084&gt;] jffs2_get_sb+0x1a8/0x2a4<br>&nbsp;[&lt;801a5688&gt;] mntput_no_expire+0x2c/0x140<br>&nbsp;[&lt;80191d98&gt;] link_path_walk+0x114/0x2f4 
<br>&nbsp;[&lt;8012e9bc&gt;] tasklet_action+0xa4/0x134<br>&nbsp;[&lt;801a4e6c&gt;] alloc_vfsmnt+0xcc/0x10c<br>&nbsp;[&lt;801a4d58&gt;] get_fs_type+0x220/0x268<br>&nbsp;[&lt;80186748&gt;] do_kern_mount+0x68/0x180<br>&nbsp;[&lt;80186710&gt;] do_kern_mount+0x30/0x180 
<br>&nbsp;[&lt;80192088&gt;] path_lookup+0x110/0x3a0<br>&nbsp;[&lt;801a7524&gt;] do_mount+0x5c4/0x7ec<br>&nbsp;[&lt;801a7068&gt;] do_mount+0x108/0x7ec<br>&nbsp;[&lt;8013fdc0&gt;] rcu_process_callbacks+0x24/0x48<br>&nbsp;[&lt;8012e9bc&gt;] tasklet_action+0xa4/0x134 
<br>&nbsp;[&lt;80158420&gt;] get_page_from_freelist+0x580/0x5a8<br>&nbsp;[&lt;8012e444&gt;] __do_softirq+0x84/0x130<br>&nbsp;[&lt;80158420&gt;] get_page_from_freelist+0x580/0x5a8<br>&nbsp;[&lt;8012e558&gt;] do_softirq+0x68/0x80<br>&nbsp;[&lt;801584ac&gt;] __alloc_pages+0x64/0x344 
<br>&nbsp;[&lt;8015d160&gt;] cache_alloc_refill+0x27c/0x69c<br>&nbsp;[&lt;801587c8&gt;] __get_free_pages+0x3c/0x88<br>&nbsp;[&lt;8015c918&gt;] kmem_cache_alloc+0x6c/0x74<br>&nbsp;[&lt;8019de08&gt;] dput+0x34/0x398<br>&nbsp;[&lt;801a6e78&gt;] copy_mount_options+0x38/0x120 
<br>&nbsp;[&lt;8018f5b8&gt;] getname+0x28/0x100<br>&nbsp;[&lt;801a7ca8&gt;] sys_mount+0xac/0x108<br>&nbsp;[&lt;801a7c40&gt;] sys_mount+0x44/0x108<br>&nbsp;[&lt;80194000&gt;] sys_mknod+0x188/0x2ac<br>&nbsp;[&lt;80194e78&gt;] sys_unlink+0x1cc/0x2c4 
<br>&nbsp;[&lt;8043ea10&gt;] mount_block_root+0xe8/0x2dc<br>&nbsp;[&lt;8043e96c&gt;] mount_block_root+0x44/0x2dc<br>&nbsp;[&lt;8013e65c&gt;] flush_cpu_workqueue+0x388/0x390<br>&nbsp;[&lt;801773ec&gt;] sys_access+0x7c/0x15c<br>&nbsp;[&lt;8043ee0c&gt;] prepare_namespace+0x74/0x14c 
<br>&nbsp;[&lt;8013e690&gt;] flush_workqueue+0x2c/0x38<br>&nbsp;[&lt;801002c0&gt;] init+0x230/0x2e0<br>&nbsp;[&lt;80103dbc&gt;] kernel_thread_helper+0x10/0x18<br>&nbsp;[&lt;80103dac&gt;] kernel_thread_helper+0x0/0x18</p>
<p>Code: 00a0b021&nbsp; 00c09021&nbsp; 00e0a821 &lt;10730010&gt; 8c710000&nbsp; 2464fff4&nbsp; 8c820008&nbsp; 8c70fff4&nbsp; 02c02821<br>Kernel panic - not syncing: Attempted to kill init!<br></p>
<p>&nbsp;</p>
<p>thanks,</p>
<p>pk</p></div>

------=_Part_217232_6585938.1161250969461--
