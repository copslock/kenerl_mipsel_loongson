Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 May 2010 12:29:22 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:38439 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491167Ab0ENK3T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 May 2010 12:29:19 +0200
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o4EAT89n011583;
        Fri, 14 May 2010 03:29:11 -0700 (PDT)
Received: from [128.224.161.192] ([128.224.161.192]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
         Fri, 14 May 2010 03:29:07 -0700
Message-ID: <4BED25F3.4010809@windriver.com>
Date:   Fri, 14 May 2010 18:29:07 +0800
From:   Yang Shi <yang.shi@windriver.com>
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [Bug report] Got bus error when loading kernel module on SB1250 Rev
 B2 board with 64 bit kernel
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 May 2010 10:29:07.0807 (UTC) FILETIME=[48D0FEF0:01CAF350]
Return-Path: <Yang.Shi@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yang.shi@windriver.com
Precedence: bulk
X-list: linux-mips

Hi experts,

I'm running 2.6.34-rc7 mainline kernel on SB1250 (Rev B2) board. And, I
use the default sb1250 kernel config (sb1250-swarm_defconfig). So, 64
bit kernel is used. During kernel loading module got bus error, see
below log:

root@bcm1250a-1:/root> insmod firmware_class.ko
DBE physical address: 0080e87020
Data bus error, epc == ffffffff801053e0, ra == ffffffff801725d0
Oops[#1]:
Cpu 0
$ 0 : 0000000000000000 0000000014001fe0 ffffffff8051d308 0000000000000000
$ 4 : a800000080e97000 0000000000000000 0000000000000000 0000000000000002
$ 8 : ffffffff80515868 0000000000000000 0000000000000001 a80000000fb0c030
$12 : 0000000000000010 ffffffff804ab728 a80000000f81ba00 0000000000000001
$16 : 0000000000000001 ffffffffc0001950 0000000000000000 c000000000005000
$20 : 0000000000000000 a80000000faabd90 c000000000008d18 c000000000007e98
$24 : 0000000000000000 0000000010010598
$28 : a80000000faa8000 a80000000faabd50 ffffffffc0001968 ffffffff801725d0
Hi : ffffffffffffffff
Lo : fffffffffffffff0
epc : ffffffff801053e0 memcpy+0x0/0x4
Not tainted
ra : ffffffff801725d0 load_module+0x1240/0x1c30
Status: 14001fe3 KX SX UX KERNEL EXL IE
Cause : 0080801c
PrId : 01040102 (SiByte SB1)
Modules linked in:
Process insmod (pid: 1799, threadinfo=a80000000faa8000,
task=a80000000f898800, tls=00000000100a7480)
Stack : 0000000000000000 ffffffff80484190 ffffffffc0001738 ffffffff00000003
0000000000000000 0000000000000000 0000000000000000 0000000200000000
0000017f00000180 c000000000008d58 ffffffff803ec728 0000000000001cf8
ffffffff80515868 a80000000f8d14a0 0000000000001b60 0000000000000000
0000000000000029 000000000000002d 000000000000003b 000000000000003a
c00000000000c008 a80000000f92aa20 c000000000007bba c000000000008a98
ffffffffc0004d88 ffffffff803ec718 ffffffff803ec718 ffffffff801df1f8
00000000000076ce 00000000100a0ff8 00000000100a1008 ffffffff804b0000
000000007f9d0f11 0000000000000003 0000000000000000 00000000100d0bc0
0000000000000000 ffffffff80173048 00000000100a0ff8 00000000000076ce
...
Call Trace:
[<ffffffff801053e0>] memcpy+0x0/0x4
[<ffffffff801725d0>] load_module+0x1240/0x1c30
[<ffffffff80173048>] SyS_init_module+0x88/0x230
[<ffffffff80102ec4>] handle_sysn32+0x44/0x9c


Code: 03e00008 00000000 00000000 <0080102d> cca00000 cc810000 2cca0008
30890007 cca00020
Disabling lock debugging due to kernel taint
Cache error exception on CPU 0:
Cache error exception on CPU 0:
c0_errorepc == 800000f0
c0_errctl == 40000000 dcache
c0_cerr_d == 88801000 fill/wb, multi-err data-DBE
c0_cerr_dpa == 0080e87000
Dcache index 0x1000 [Bank 2 Set 0x00] LRU > 1 2 0 3 > MRU
0 [PA 00004ad000] [state COH-SHD (0f)] raw tags: 1E724000-00000000004AC400
00-0000000000000000 9E-FFFFFFFFFFFFFED4 9E-FFFFFFFFFFFFFED4
4E-0000000000020002
1 [PA 000050f000] [state COH-SHD (0f)] raw tags: 1E724000-000000000050E400
EC-3E343C0A30207570 A7-203A202020302024 00-3030303030303030
00-3030303030303030
2 [PA 000f93d000] [state COH-SHD (0f)] raw tags: 1E724000-000000000F93C000
00-0000000000000000 00-FFFFFFFFFFFFFFFF 00-FFFFFFFFFFFFFFFF
00-FFFFFFFFFFFFFFFF
3 [PA 000f8db000] [state COH-E-C (16)] raw tags: 2C724000-000000000F8DA000
84-FFFFFFFF80504000 84-FFFFFFFF80504000 84-FFFFFFFF80504000
84-FFFFFFFF80504000
...didn't see indicated dcache problem
Bus watcher error counters: 00000000 00030000

Last recorded signature:
Request 00 from 0, answered by 7 with Dcode 4
Kernel panic - not syncing: unhandled cache error
Rebooting in 5 seconds..

It seems bus error occurs when copying module since the memcpy is called
by percpu_modcopy. I recalled that SB1250 prior C0 version has a TLB M3
workaround which caused kernel module loading fail, however, it seems
Ralf committed a patch to solve this issue. See git log:

commit 3d45285dd1ff4d4a1361b95e2d6508579a4402b5
Author: Ralf Baechle <ralf@linux-mips.org>
Date: Tue Mar 23 17:56:38 2010 +0100

MIPS: Sibyte: Fix M3 TLB exception handler workaround.

The M3 workaround needs to cmpare the region and VPN2 fields only.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

It seems this patch can't solve the issue, or this is another different bug?

Thanks,
Yang
