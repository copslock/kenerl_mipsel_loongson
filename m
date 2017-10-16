Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Oct 2017 07:35:24 +0200 (CEST)
Received: from resqmta-ch2-05v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:37]:37190
        "EHLO resqmta-ch2-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990416AbdJPFfPmwGM4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Oct 2017 07:35:15 +0200
Received: from resomta-ch2-01v.sys.comcast.net ([69.252.207.97])
        by resqmta-ch2-05v.sys.comcast.net with ESMTP
        id 3y15elOvUSysd3y15eLjb4; Mon, 16 Oct 2017 05:32:43 +0000
Received: from [192.168.1.13] ([73.173.137.35])
        by resomta-ch2-01v.sys.comcast.net with SMTP
        id 3y14eYyax5JFS3y15ePYtr; Mon, 16 Oct 2017 05:32:43 +0000
Subject: Re: IP27: debugging RCU stalls under newer code
To:     linux-mips@linux-mips.org
References: <0642894b-8f7f-04c9-bebf-2aabccff779f@gentoo.org>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <d973a4ea-44d5-be22-1a7f-88ad99c62a6c@gentoo.org>
Date:   Mon, 16 Oct 2017 01:32:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <0642894b-8f7f-04c9-bebf-2aabccff779f@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDPFPeZUVKnqzw47anFPAS4eUAAfrKUBoMrB9j/2nEXMykuPQmXEjC+XIfVEw+MFqmFkHutcnSaZ7VJ/oq1h++je8DO/HSvcjhy1tV8nrioD2nqtBNjO
 NP99yh8N4F9dOQKHJHXahcSDmMezH4RMaH0KqDt8VOsrS2l51mvMcgG/Un9B31goK5lxO6u54TI4UQ==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 10/09/2017 20:39, Joshua Kinard wrote:
> Hi,
> 
> I am still trying to chase down bugs in the modified IP27 patchset I've been
> maintaining.  Getting a rather consistent RCU hang the last few kernel
> versions, but I have not had much luck figuring out why it's hanging.  I
> suspect the re-written interrupt code I did has a bug in it somewhere.
> 
> Here's the most common symptom on the Origin 200 machine that I have:
> 
> [    5.093177] NET: Registered protocol family 1
> [    5.145708] RPC: Registered named UNIX socket transport module.
> [    5.216044] RPC: Registered udp transport module.
> [    5.272604] RPC: Registered tcp transport module.
> [    5.329150] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [  128.087259] INFO: rcu_sched detected stalls on CPUs/tasks:
> [  128.151416]  (detected by 1, t=11887 jiffies, g=-261, c=-262, q=3)
> [  128.225797] All QSes seen, last rcu_sched kthread activity 11885 (4294949888-4294938003), jiffies_till_next_fqs=1, root ->qsmask 0x0
> [  128.369292] rcu_sched       R  running task        0     8      2 0x00100000
> [  128.411349] workingset: timestamp_bits=40 max_order=15 bucket_order=0
> [  128.531651] Stack : a800000000c2fe28 000000000000000a 000000000000000a a800000000c30232
> [  128.628013]         000000000000001d a800000000c30000 0000000000000000 0000000000000000
> [  128.724381]         0000000000000005 0000000000000000 000000000000000a a80000000008fe3c
> [  128.820749]         ffffffff94005ce0 0000000000000000 0000000000000000 a800000070195480
> [  128.917116]         a8000000007c0000 a8000000007c04f0 a8000000007c0000 0000000000000000
> [  129.013484]         a8000000007c0000 fffffffffffffefb 0000000000000000 0000000000000000
> [  129.109852]         0000000000000000 0000000000000000 0000000000000000 0000000000000000
> [  129.206220]         0000000000000000 a8000000700cfc20 0000000000000000 a8000000000a227c
> [  129.302587]         0000000000000000 0000000000000000 a800000070195480 a800000000072c00
> [  129.398954]         00000000ffff8d93 a800000000029350 a8000000007cf700 a8000000000a227c
> [  129.495322]         ...
> [  129.524655] Call Trace:
> [  129.554030] [<a800000000029350>] show_stack+0x70/0x9c
> [  129.614757] [<a8000000000a227c>] rcu_check_callbacks+0x85c/0x944
> [  129.687036] [<a8000000000a6644>] update_process_times+0x34/0x70
> [  129.758252] [<a8000000000b636c>] tick_sched_timer+0x3c/0x90
> [  129.825291] [<a8000000000a6c6c>] __hrtimer_run_queues+0x128/0x1c4
> [  129.898615] [<a8000000000a7654>] hrtimer_interrupt+0xf4/0x274
> [  129.967747] [<a80000000001e328>] ip27_hub_rt_compare_irq+0xa8/0xb8
> [  130.042120] [<a800000000092d7c>] __handle_irq_event_percpu+0xe0/0x1a4
> [  130.119630] [<a800000000092e60>] handle_irq_event_percpu+0x20/0x7c
> [  130.194007] [<a800000000097c34>] handle_percpu_irq+0xa8/0xd8
> [  130.262085] [<a800000000092198>] generic_handle_irq+0x28/0x38
> [  130.331218] [<a8000000000257f0>] do_IRQ+0x18/0x28
> [  130.387781] [<a8000000000237d0>] handle_int+0x160/0x16c
> [  130.450644] [<a8000000006294a8>] arch_local_irq_restore+0x18/0x20
> [  130.523964] [<a80000000062f8ac>] _raw_spin_unlock_irqrestore+0x2c/0x38
> [  130.602514] [<a8000000000a0418>] force_qs_rnp+0x12c/0x1e0
> [  130.667458] [<a8000000000a0dc0>] rcu_gp_kthread+0x8f4/0xa04
> [  130.734511] [<a800000000067b20>] kthread+0x178/0x180
> [  130.794204] [<a800000000023408>] ret_from_kernel_thread+0x14/0x1c
> [  130.867538] rcu_sched kthread starved for 11885 jiffies! g18446744073709551355 c18446744073709551354 f0x2 RCU_GP_DOING_FQS(4) ->state=0x0
> [  131.016256] rcu_sched       R  running task        0     8      2 0x00100000
> [  131.101100] Stack : a800000000c2fe28 000000000000000a 000000000000000a a800000000c30232
> [  131.197468]         000000000000001d a800000000c30000 0000000000000000 0000000000000000
> [  131.293835]         0000000000000005 0000000000000000 000000000000000a a80000000008fe3c
> [  131.390203]         ffffffff94005ce0 0000000000000000 0000000000000000 a800000070195480
> [  131.486570]         a8000000007c0000 a8000000007c04f0 a8000000007c0000 0000000000000000
> [  131.582937]         a8000000007c0000 fffffffffffffefb 0000000000000000 0000000000000000
> [  131.679305]         0000000000000000 0000000000000000 0000000000000000 0000000000000000
> [  131.775673]         0000000000000000 a8000000700cfc00 0000000000000000 a8000000000a2c3c
> [  131.872040]         0000000000000000 0000000000000000 a800000070195480 a800000000072c00
> [  131.968408]         fffffffffffffefa a800000000029350 a8000000007cf700 a8000000000a2c3c
> [  132.064776]         ...
> [  132.094106] Call Trace:
> [  132.123446] [<a800000000029350>] show_stack+0x70/0x9c
> [  132.184200] [<a8000000000a2c3c>] rcu_check_gp_kthread_starvation+0xdc/0x104
> [  132.267997] [<a8000000000a2110>] rcu_check_callbacks+0x6f0/0x944
> [  132.340276] [<a8000000000a6644>] update_process_times+0x34/0x70
> [  132.411500] [<a8000000000b636c>] tick_sched_timer+0x3c/0x90
> [  132.478541] [<a8000000000a6c6c>] __hrtimer_run_queues+0x128/0x1c4
> [  132.551865] [<a8000000000a7654>] hrtimer_interrupt+0xf4/0x274
> [  132.620996] [<a80000000001e328>] ip27_hub_rt_compare_irq+0xa8/0xb8
> [  132.695367] [<a800000000092d7c>] __handle_irq_event_percpu+0xe0/0x1a4
> [  132.772881] [<a800000000092e60>] handle_irq_event_percpu+0x20/0x7c
> [  132.847252] [<a800000000097c34>] handle_percpu_irq+0xa8/0xd8
> [  132.915336] [<a800000000092198>] generic_handle_irq+0x28/0x38
> [  132.984469] [<a8000000000257f0>] do_IRQ+0x18/0x28
> [  133.041033] [<a8000000000237d0>] handle_int+0x160/0x16c
> [  133.103882] [<a8000000006294a8>] arch_local_irq_restore+0x18/0x20
> [  133.177208] [<a80000000062f8ac>] _raw_spin_unlock_irqrestore+0x2c/0x38
> [  133.255764] [<a8000000000a0418>] force_qs_rnp+0x12c/0x1e0
> [  133.320709] [<a8000000000a0dc0>] rcu_gp_kthread+0x8f4/0xa04
> [  133.387749] [<a800000000067b20>] kthread+0x178/0x180
> [  133.447455] [<a800000000023408>] ret_from_kernel_thread+0x14/0x1c
> [  133.521008] zbud: loaded

After a fair bit of experimentation over the weekend, it does indeed look like
the culprit for these RCU stalls is the early console serial driver spamming
the IOC3 UART registers at a slow baud rate.  IP27 prints early PROM messages
at 9600bps at poweron, thus not changing the baud rate very often.  Booting
with 38400bps, plus enabling CONFIG_RCU_FAST_NO_HZ and CONFIG_RCU_NOCB_CPU
together appear to significantly reduce the issue.  My Origin 200 can now boot
to a netboot prompt in ~24-38 seconds, where it normally takes upwards of 3-5
minutes, if everything happens to work right.  Next, have to test the Onyx2 out...

Likely not the correct fix, but it works for now.  Octane could also trip up an
RCU stall under the right conditions, but I made some changes to the IRQ
handling that appears to have eliminated those.  IP27 is just a much more
fickle animal with its main console being over a serial line.  Probably buried
deep in the RCU code and docs is a function call that can be added to places w/
tight looping to allow RCU updates to happen periodically, but that's an
experiment for another day.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
