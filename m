Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Apr 2017 01:14:10 +0200 (CEST)
Received: from hall.aurel32.net ([IPv6:2001:bc8:30d7:100::1]:35666 "EHLO
        hall.aurel32.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993859AbdDUXODhY0SZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 22 Apr 2017 01:14:03 +0200
Received: from ohm.aurel32.net ([2001:bc8:30d7:111::1000])
        by hall.aurel32.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <aurelien@aurel32.net>)
        id 1d1hkY-0004OW-2k
        for linux-mips@linux-mips.org; Sat, 22 Apr 2017 01:14:02 +0200
Received: from aurel32 by ohm.aurel32.net with local (Exim 4.89)
        (envelope-from <aurelien@aurel32.net>)
        id 1d1hkU-0006DC-PO
        for linux-mips@linux-mips.org; Sat, 22 Apr 2017 01:13:58 +0200
Date:   Sat, 22 Apr 2017 01:13:58 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     linux-mips@linux-mips.org
Subject: Loongson 3 kernel crashes with PAGE_EXTENSION and PAGE_POISONING
Message-ID: <20170421231358.yszzvk3qzvbpxcrs@aurel32.net>
Mail-Followup-To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57764
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
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

Hi all,

The Debian kernel recently enabled the PAGE_EXTENSION and PAGE_POISONING
options. Unfortunately this causes a kernel crash very early during the
boot on Loongson 3 machines:

  [    0.941596] pci 0000:00:13.2: Device 1002:4396, irq 6
  [    0.946664] pci 0000:00:14.1: Device 1002:439c, irq 0
  [    0.951730] pci 0000:00:14.2: Device 1002:4383, irq 5
  [    0.956796] pci 0000:00:14.5: Device 1002:4399, irq 6
  [    0.961843] pci 0000:01:05.0: Device 1002:9615, irq 6
  [    0.966907] pci 0000:07:00.0: Device 10ec:8168, irq 5
  [    0.973196] clocksource: Switched to clocksource MIPS
  [    0.997909] Unhandled kernel unaligned access[#1]:
  [    1.002567] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.9.0-0.bpo.2-loongson-3 #1 Debian 4.9.18-1~bpo8+1
  [    1.012074] task: 980000027e1c2ba0 task.stack: 980000027e154000
  [    1.018005] $ 0   : 0000000000000000 ffffffff802082e4 0000000000000000 0000000000000000
  [    1.026032] $ 4   : 0000000000000002 ffffffff80431288 0000000000000000 8e75000000000016
  [    1.034061] $ 8   : ffffffffffffffff ffffffff809837fe 0000000000000001 78616d5f79746972
  [    1.042090] $12   : 980000027e157a28 000000001000001e 0000000000000000 0000000000000000
  [    1.050119] $16   : 980000027e157a30 ffffffff80431284 ffffffff80a20000 0000000000000000
  [    1.058148] $20   : ffffffff8e020018 8e75000000000016 ffffffff80431258 ffffffff80b56ee8
  [    1.066177] $24   : 0000000000000020 0000000000000000                                  
  [    1.074206] $28   : 980000027e154000 980000027e1579d0 ffffffff80a80000 ffffffff802082e4
  [    1.082236] Hi    : 0000000000000004
  [    1.085814] Lo    : ccccccccccccccd1
  [    1.089406] epc   : ffffffff80212300 do_ade+0x220/0x900
  [    1.094637] ra    : ffffffff802082e4 resume_userspace_check+0x0/0x10
  [    1.100999] Status: 9400cce3 KX SX UX KERNEL EXL IE 
  [    1.105975] Cause : 00000010 (ExcCode 04)
  [    1.109988] BadVA : 8e75000000000019
  [    1.113568] PrId  : 00006305 (ICT Loongson-3)
  [    1.117930] Modules linked in:
  [    1.120988] Process swapper/0 (pid: 1, threadinfo=980000027e154000, task=980000027e1c2ba0, tls=0000000000000000)
  [    1.131196] Stack : 0000000000000000 0000000000040912 00000000024040d0 8e74fffffffffffe
  [    1.139224]         ffffffffd6eb8e8c 980000027e157c18 980000027c0f9440 980000027c0f9440
  [    1.147253]         0000000000000000 ffffffff80a5ec30 ffffffff80b56ee8 ffffffff802082e4
  [    1.155282]         0000000000000000 ffffffff80431258 fffffffffffffffe 980000027e1c2ba0
  [    1.163311]         980000027c0f9440 980000027e157c18 0000000000000000 0000000000000000
  [    1.171340]         ffffffffffffffff ffffffff809837fe 0000000000000001 78616d5f79746972
  [    1.179369]         0000000000000000 ffffffff80581584 0000000000000000 0000000000000000
  [    1.187398]         8e74fffffffffffe ffffffffd6eb8e8c 980000027e157c18 980000027c0f9440
  [    1.195427]         980000027c0f9440 0000000000000000 ffffffff80a5ec30 ffffffff80b56ee8
  [    1.203457]         0000000000000020 0000000000000000 000000000000001d 0000000000400000
  [    1.211486]         ...
  [    1.213931] Call Trace:
  [    1.216378] [<ffffffff80212300>] do_ade+0x220/0x900
  [    1.221272] [<ffffffff802082e4>] resume_userspace_check+0x0/0x10
  [    1.227290] [<ffffffff80431284>] __d_lookup+0x8c/0x190
  [    1.232436] [<ffffffff804313d8>] d_lookup+0x50/0x88
  [    1.237326] [<ffffffff8041e418>] lookup_dcache+0x30/0xb8
  [    1.242649] [<ffffffff80421e38>] __lookup_hash+0x30/0xb8
  [    1.247971] [<ffffffff80422010>] lookup_one_len+0x150/0x1d0
  [    1.253559] [<ffffffff804b615c>] start_creating+0x84/0x110
  [    1.259055] [<ffffffff804b6760>] tracefs_create_file+0x48/0x130
  [    1.264998] [<ffffffff8032ae7c>] trace_create_file+0x1c/0x58
  [    1.270672] [<ffffffff8033a8b0>] event_create_dir+0x118/0x568
  [    1.276435] [<ffffffff80b2dc1c>] event_trace_init+0x298/0x348
  [    1.282182] [<ffffffff80200600>] do_one_initcall+0x60/0x190
  [    1.287770] [<ffffffff80b1cefc>] kernel_init_freeable+0x200/0x2d8
  [    1.293884] [<ffffffff808664a0>] kernel_init+0x20/0x130
  [    1.299114] [<ffffffff802083c4>] ret_from_kernel_thread+0x14/0x1c
  [    1.305225] Code: 00431024  1440ffeb  00200825 <8ab70003> 9ab70000  24150000  16a00022  0200202d  8e020120 
  [    1.314991] 
  [    1.316540] ---[ end trace c4de331138101c00 ]---
  [    1.321224] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
  [    1.321224] 
  [    1.330294] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
  [    1.330294] 

Adding page_poison=0 to the command line improves the things a bit, the
kernel is able to boot, but crashes a bit later in different ways:

  [  214.317350] Call Trace:
  [  214.319810] [<ffffffff802122e8>] do_ade+0x718/0x900
  [  214.324721] [<ffffffff80207de4>] resume_userspace_check+0x0/0x10
  [  214.330777] [<ffffffff804317bc>] __d_lookup+0x8c/0x198
  [  214.335944] [<ffffffff80431918>] d_lookup+0x50/0x88
  [  214.340865] [<ffffffff8049b8e0>] proc_flush_task+0xb0/0x1d0
  [  214.346470] [<ffffffff802415b0>] release_task+0xb0/0x4d0
  [  214.351810] [<ffffffff80242054>] wait_consider_task+0x684/0xc80
  [  214.357761] [<ffffffff8024276c>] do_wait+0x11c/0x328
  [  214.362753] [<ffffffff80243cec>] SyS_wait4+0xac/0x130
  [  214.367849] [<ffffffff802ee110>] compat_SyS_wait4+0xf8/0x108
  [  214.373551] [<ffffffff8021e244>] syscall_common+0x18/0x3c
  
  [  327.510496] Call Trace:
  [  327.512969] [<ffffffff802122e8>] do_ade+0x718/0x900
  [  327.517887] [<ffffffff80207de4>] resume_userspace_check+0x0/0x10
  [  327.523945] [<ffffffff80430f84>] __d_lookup_rcu+0xac/0x230
  [  327.529462] [<ffffffff80421d10>] lookup_fast+0x78/0x380
  [  327.534715] [<ffffffff804223cc>] walk_component+0x54/0x3b0
  [  327.540230] [<ffffffff80422dd4>] path_lookupat+0x9c/0x1a0
  [  327.545663] [<ffffffff80424e1c>] filename_lookup+0x94/0x140
  [  327.551276] [<ffffffff80418238>] vfs_fstatat+0x88/0xf8
  [  327.556445] [<ffffffff804184bc>] SyS_newstat+0x44/0x80
  [  327.561625] [<ffffffff8021e244>] syscall_common+0x18/0x3c
  
  [  136.167237] Call Trace:
  [  136.167244] [<ffffffff802122e8>] do_ade+0x718/0x900
  [  136.167258] [<ffffffff80207de4>] resume_userspace_check+0x0/0x10
  [  136.167281] [<ffffffff804316cc>] __d_lookup+0x8c/0x198
  [  136.167289] [<ffffffff80421d80>] lookup_fast+0x1d8/0x380
  [  136.167296] [<ffffffff804237d4>] path_openat+0x1cc/0x1140
  [  136.167305] [<ffffffff80425c24>] do_filp_open+0xe4/0x130
  [  136.167328] [<ffffffff8040fb34>] do_sys_open+0x194/0x268
  [  136.167348] [<ffffffff8021e244>] syscall_common+0x18/0x3c

Note that the malta and octeon flavours are not affected by this bug, so
it looks like Loongson 3 specific. Any help to find the root cause would
be appreciated.

Thanks,
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
