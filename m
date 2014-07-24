Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jul 2014 09:40:45 +0200 (CEST)
Received: from hall.aurel32.net ([195.154.112.97]:33851 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816022AbaGXHkmnSMuU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 Jul 2014 09:40:42 +0200
Received: from aurel32 by hall.aurel32.net with local (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1XADdg-0007zY-6E; Thu, 24 Jul 2014 09:40:32 +0200
Date:   Thu, 24 Jul 2014 09:40:32 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Andreas Barth <aba@ayous.org>
Subject: Re: SMP IPI issues on Loongson 3A based machines
Message-ID: <20140724074032.GC18817@hall.aurel32.net>
References: <tencent_17A6D3544BFB28F65D92C62E@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_17A6D3544BFB28F65D92C62E@qq.com>
X-Mailer: Mutt 1.5.21 (2010-09-15)
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41556
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

On Thu, Jul 24, 2014 at 07:47:02AM +0800, 陈华才 wrote:
> Hi, Aurelien

Hi,

> Could you please attachment your config file? It seems you didn't use
> the default one.

Please fine it attached. That said thanks for your idea about using the
default config file, I built a 3.15.6 kernel with it, and it doesn't 
crash with it. I'll try to "bisect" the config file to see what is
causing the issue, and I'll keep you updated.

> And, which version of mysql do you use? We will debug this problem as
> soon as possible.

We have been able to reproduce both mysql 5.5 and 5.6.

> BTW, you can try the master branch of
> http://dev.lemote.com/cgit/linux-official.git/, because the upstream
> kernel has only basic support for loongson now.

I'll try it once I have identified the config option causing the issue.

Thanks,
Aurelien

> ------------------ Original ------------------
> From: "Aurelien Jarno"<aurelien@aurel32.net>
> Date: Thu, Jul 24, 2014 06:03 AM
> To: "linux-mips"<linux-mips@linux-mips.org>;
> Cc: "Huacai Chen"<chenhc@lemote.com>;"Andreas Barth"<aba@ayous.org>;
> Subject: SMP IPI issues on Loongson 3A based machines
> 
> 
> Hi all,
> 
> Debian is using Loongson 3A based machines as build daemons. We
> experience a few stability issues from time to time, with the machine
> freezing completely, sometimes outputing a backtrace on the serial
> console:
> 
> | ------------[ cut here ]------------
> | [158285.176000] WARNING: CPU: 3 PID: 4162 at /build/kernel/linux-3.15.5/kernel/smp.c:338 smp_call_function_many+0x120/0x388()
> | [158285.176000] Modules linked in: radeon drm_kms_helper ttm drm dm_mod ehci_pci ata_generic ohci_pci ohci_hcd ehci_hcd usbcore usb_common
> | [158285.176000] CPU: 3 PID: 4162 Comm: mysqld Not tainted 3.15-trunk-loongson-3 #1 Debian 3.15.5-1~exp1+rs780e
> | [158285.176000] Stack : ffffffff80920000 ffffffff80290fec ffffffff80a00000 ffffffff80291808
> |           0000000000000000 0000000000000000 ffffffff809e0000 ffffffff809e0000
> |           ffffffff8085f188 ffffffff80914ff7 ffffffff809de068 98000000fab16e58
> |           0000000000001042 0000000000000003 0000000000000003 0000000000000001
> |           ffffffff8090e688 ffffffff80768cfc 980000014c323c08 ffffffff80234f2c
> |           ffffffff8090e688 ffffffff80293180 98000000fab169b0 ffffffff8085f188
> |           0000000000000003 0000000000001042 0000000000000000 0000000000000000
> |           0000000000000000 980000014c323b50 0000000000000000 ffffffff8076bdb0
> |           0000000000000000 0000000000000000 0000000000000000 ffffffff802b2300
> |           0000000000000152 ffffffff8020acd0 0000000000000009 ffffffff8076bdb0
> |           ...
> | [158285.280000] Call Trace:
> | [158285.280000] [<ffffffff8020acd0>] show_stack+0x68/0x80
> | [158285.280000] [<ffffffff8076bdb0>] dump_stack+0x6c/0x8c
> | [158285.280000] [<ffffffff80235088>] warn_slowpath_common+0x88/0xb8
> | [158285.280000] [<ffffffff802b2328>] smp_call_function_many+0x120/0x388
> | [158285.280000] [<ffffffff802b25bc>] smp_call_function+0x2c/0x40
> | [158285.280000] [<ffffffff80223b18>] r4k_flush_data_cache_page+0x38/0x70
> | [158285.280000] [<ffffffff803c89b0>] aio_complete+0x170/0x338
> | [158285.280000] [<ffffffff803c9bb0>] do_io_submit+0x378/0x768
> | [158285.280000] [<ffffffff80218fe8>] handle_sys+0x128/0x14c
> | [158285.280000]
> | [158285.280000] ---[ end trace 97d7fd09bd30b5b9 ]---
> 
> We noticed this happens on various CPU. The CPU is stuck in this part of
> the smp_call_function_many function:
> 
> |         if (wait) {
> |                 for_each_cpu(cpu, cfd->cpumask) {
> |                         struct call_single_data *csd;
> | 
> |                         csd = per_cpu_ptr(cfd->csd, cpu);
> |                         csd_lock_wait(csd);
> |                 }
> |         }
> 
> and more precisely in the csd_lock_wait() part. From time to time (it
> *seems* when the initial issue happens on a different CPU than #0), we
> get this kind of additional backtrace a few seconds after, sometimes
> repeating regularly on the other CPUs:
> 
> | [158313.196000] INFO: rcu_sched self-detected stall on CPU { 2}  (t=5250 jiffies g=661863 c=661862 q=4)
> | [158313.196000] CPU: 2 PID: 4217 Comm: mysqld Tainted: G        W     3.15-trunk-loongson-3 #1 Debian 3.15.5-1~exp1+rs780e
> | [158313.196000] Stack : ffffffff80920000 ffffffff80290fec ffffffff80a00000 ffffffff80291808
> |           0000000000000000 0000000000000000 ffffffff809e0000 ffffffff809e0000
> |           ffffffff8085f188 ffffffff80914ff7 ffffffff809de068 98000000029b73e0
> |           0000000000001079 0000000000000002 ffffffff80910000 0000000000000010
> |           9800000008d4cbe0 ffffffff80768cfc 98000001305d3858 ffffffff80234e94
> |           9800000008d51230 ffffffff80293180 98000000029b6f38 ffffffff8085f188
> |           0000000000000002 0000000000001079 0000000000000000 0000000000000000
> |           0000000000000000 98000001305d37a0 0000000000000000 ffffffff8076bdb0
> |           0000000000000000 0000000000000000 0000000000000000 ffffffff80790000
> |           ffffffff80920c40 ffffffff8020acd0 ffffffff80920c40 ffffffff8076bdb0
> |           ...
> | [158313.196000] Call Trace:
> | [158313.196000] [<ffffffff8020acd0>] show_stack+0x68/0x80
> | [158313.196000] [<ffffffff8076bdb0>] dump_stack+0x6c/0x8c
> | [158313.196000] [<ffffffff8029ff60>] rcu_check_callbacks+0x4d8/0x878
> | [158313.196000] [<ffffffff80245418>] update_process_times+0x48/0x88
> | [158313.196000] [<ffffffff802ac178>] tick_sched_handle.isra.15+0x20/0x80
> | [158313.196000] [<ffffffff802ac218>] tick_sched_timer+0x40/0x70
> | [158313.196000] [<ffffffff8025f050>] __run_hrtimer+0xa8/0x240
> | [158313.196000] [<ffffffff8025fc08>] hrtimer_interrupt+0x130/0x2f8
> | [158313.196000] [<ffffffff8020d754>] c0_compare_interrupt+0x54/0x90
> | [158313.196000] [<ffffffff80293eb8>] handle_irq_event_percpu+0x68/0x248
> | [158313.196000] [<ffffffff802984fc>] handle_percpu_irq+0x8c/0xc0
> | [158313.196000] [<ffffffff802933bc>] generic_handle_irq+0x3c/0x58
> | [158313.196000] [<ffffffff80207608>] do_IRQ+0x18/0x30
> | [158313.196000] [<ffffffff80205428>] ret_from_irq+0x0/0x4
> | [158313.196000] [<ffffffff802b2500>] smp_call_function_many+0x2f8/0x388
> | [158313.196000] [<ffffffff802b25bc>] smp_call_function+0x2c/0x40
> | [158313.196000] [<ffffffff8020f8a0>] flush_tlb_mm+0x50/0x108
> | [158313.196000] [<ffffffff80335a5c>] tlb_finish_mmu+0x74/0x88
> | [158313.196000] [<ffffffff8033fef0>] unmap_region+0xc8/0x118
> | [158313.196000] [<ffffffff803422c4>] do_munmap+0x264/0x440
> | [158313.196000] [<ffffffff803424e4>] vm_munmap+0x44/0x70
> | [158313.196000] [<ffffffff8034353c>] SyS_munmap+0x24/0x38
> | [158313.196000] [<ffffffff80218fe8>] handle_sys+0x128/0x14c
> | [158313.196000]
> | [158340.156000] BUG: soft lockup - CPU#2 stuck for 22s! [mysqld:4217]
> | [158340.156000] Modules linked in: radeon drm_kms_helper ttm drm dm_mod ehci_pci ata_generic ohci_pci ohci_hcd ehci_hcd usbcore usb_common
> 
> Any idea about the problem or how to debug that further?
> 
> The problem happens with both Lemote and Loongson machines, and we have
> finally found a way to reproduce it all the time, by running the mysql 
> testsuite with 4 threads. This means we can now easily reproduce the
> issue to debug it further. If someone is interested, I think I can
> package a chroot with all the needed files in a tarball so that the
> issue can be reproduce more easily.
> 
> Thanks,
> Aurelien
> 
> -- 
> Aurelien Jarno                          GPG: 4096R/1DDD8C9B
> aurelien@aurel32.net                 http://www.aurel32.net

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
