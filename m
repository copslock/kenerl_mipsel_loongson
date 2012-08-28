Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Aug 2012 03:43:07 +0200 (CEST)
Received: from [124.207.24.138] ([124.207.24.138]:40153 "EHLO
        mail.ss.pku.edu.cn" rhost-flags-FAIL-FAIL-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903726Ab2H1BnA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Aug 2012 03:43:00 +0200
Received: from mail-iy0-f177.google.com (mail-iy0-f177.google.com [209.85.210.177])
        (Authenticated sender: mlin@ss.pku.edu.cn)
        by mail.ss.pku.edu.cn (Postfix) with ESMTPA id 55466DBC0C
        for <linux-mips@linux-mips.org>; Tue, 28 Aug 2012 09:42:53 +0800 (CST)
Received: by iaai1 with SMTP id i1so9969405iaa.36
        for <linux-mips@linux-mips.org>; Mon, 27 Aug 2012 18:42:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.50.186.165 with SMTP id fl5mr12082360igc.47.1346118171081;
 Mon, 27 Aug 2012 18:42:51 -0700 (PDT)
Received: by 10.50.84.104 with HTTP; Mon, 27 Aug 2012 18:42:51 -0700 (PDT)
Date:   Tue, 28 Aug 2012 09:42:51 +0800
Message-ID: <CAF1ivSYqNpzZD5U6Ne_FL_gDmPC0aETb7Gt3uyWZzNp9tTMP5Q@mail.gmail.com>
Subject: panic in hrtimer_run_queues
From:   Lin Ming <mlin@ss.pku.edu.cn>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 34366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlin@ss.pku.edu.cn
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Status: A

Hi list,

I'm working on a board running 2.6.30 kernel.
The panic log is attached in the end.

8002c098:       0c00aeaa        jal     8002baa8 <__remove_hrtimer>
8002c09c:       00003821        move    a3,zero
8002c0a0:       8e220020        lw      v0,32(s1)
8002c0a4:       0040f809        jalr    v0
8002c0a8:       02202021        move    a0,s1
8002c0ac:       02002821        move    a1,s0
------> panic happens here.
But this instruction just move data between registers.
How could it cause memory access panic?

8002c0b0:       10400003        beqz    v0,8002c0c0 <hrtimer_run_queues+0x174>
8002c0b4:       02202021        move    a0,s1
8002c0b8:       0c00ae7b        jal     8002b9ec <enqueue_hrtimer>


CPU 0 Unable to handle kernel paging request at virtual address
00000000, epc 00000000, ra 8002c0ac
Oops[#1]:
Cpu 0
$ 0 : 00000000 10000400 00000000 000004d7
$ 4 : 83217788 00000000 00000002 00000000
$ 8 : 00000000 803033d0 000004d7 1017df82
$12 : 00000000 042c1d80 00000057 ffffffff
$16 : 00000000 83217788 803031a8 00000001
$20 : 00000000 80303180 83010000 8330fd38
$24 : 00000001 801f90f8
$28 : 83308000 8330f958 00000001 8002c0ac
Hi : 00000000
Lo : 00000000
epc : 00000000 (null)
Not tainted
ra : 8002c0ac hrtimer_run_queues+0x160/0x1bc
Status: 10000400
Cause : 00000008
BadVA : 00000000
PrId : 0000dc02 (<NULL>)
Process clinkd (pid: 100, threadinfo=83308000, task=832e9c90, tls=00000000)
Stack : 503645f7 16a65700 00000000 80301938 5036461d 042c1d80 afc9beba 0bebc202
afc9beba 0bebc202 00000000 832e9c90 80301790 0000000d 00000000 8330fd20
8001ccd4 00002000 00000001 80300000 80301790 0000000d 8001cd10 80119fd0
80301790 0000000d 00000000 8330fd20 80300000 0000000d 800337cc 00000018
83ac02c0 00000000 00000000 0000000b 80301790 80033800 83010000 8330fd38
...
Call Trace:
[<8001ccd4>] run_local_timers+0x10/0x20
[<8001cd10>] update_process_times+0x2c/0x70
[<80119fd0>] rtl8192cd_bcnProc+0x23c/0x6dc
[<800337cc>] tick_periodic+0xb4/0xc4
[<80033800>] tick_handle_periodic+0x24/0x13c
[<8000a640>] rlx_timer_interrupt+0x84/0x98
[<80034db0>] handle_IRQ_event+0x68/0x178
[<80036fcc>] handle_percpu_irq+0x48/0x94
[<80000b6a>] handle_ades+0x2a/0xcc
[<8019fc28>] Clnk_MBX_wqt_condition+0x0/0x24
[<80000424>] ret_from_irq+0x0/0x4
[<8000470c>] schedule+0x10/0x30
[<801f90f8>] tcp_poll+0x0/0x1c4
[<801a03b0>] Clnk_MBX_SendRcvMsg+0x1b0/0x1d8
[<801a070c>] clnk_cmd_msg_send_recv+0xec/0x104
[<800027d0>] __copy_user+0x4c/0x29c
[<801b181c>] skb_release_all+0x14/0x28
[<8019f414>] clnkioc_mbox_cmd_request+0xc4/0x160
[<8019f3c0>] clnkioc_mbox_cmd_request+0x70/0x160
[<8019f20c>] clnkioc_mem_read+0x100/0x128
[<80174630>] act_gmac_do_ioctl+0x240/0x300
[<8006956c>] core_sys_select+0x238/0x320
[<801bd948>] dev_ifsioc+0x35c/0x380
[<801b96c0>] dev_load+0x10/0x2c
[<801be000>] dev_ioctl+0x694/0x730
[<800e2afc>] do_output_char+0xb0/0x204
[<8000d520>] task_tick_fair+0x80/0x98
[<8000d4d4>] task_tick_fair+0x34/0x98
[<801ab780>] sock_ioctl+0x260/0x288
[<80067534>] vfs_ioctl+0x30/0x7c
[<80068178>] do_vfs_ioctl+0x60c/0x634
[<80068d98>] poll_select_copy_remaining+0x64/0x16c
[<8002b604>] ktime_get_ts+0x40/0x9c
[<8000cdb0>] set_next_entity+0x28/0x60
[<8002f33c>] do_gettimeofday+0x18/0x54
[<8006974c>] sys_select+0xf8/0x138
[<800681f0>] sys_ioctl+0x50/0x88
[<800174ac>] sys_gettimeofday+0x28/0xb0
[<80001374>] stack_done+0x20/0x3c
[<80000424>] ret_from_irq+0x0/0x4
Code: 00000000 00000000 00000000 <401a4000> 3c1b8037 8f7b0000 001ad582
001ad080 037ad821
Disabling lock debugging due to kernel taint
Kernel panic - not syncing: Fatal exception in interrupt
