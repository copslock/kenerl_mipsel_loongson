Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2015 14:37:50 +0100 (CET)
Received: from bastet.se.axis.com ([195.60.68.11]:44432 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011233AbbJ1NhskDkx5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Oct 2015 14:37:48 +0100
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 4046C1819A;
        Wed, 28 Oct 2015 14:37:42 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id omZQ5L9J5cw2; Wed, 28 Oct 2015 14:37:39 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bastet.se.axis.com (Postfix) with ESMTP id 22B041819E;
        Wed, 28 Oct 2015 14:37:38 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id 0B806DE;
        Wed, 28 Oct 2015 14:37:38 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
        by boulder.se.axis.com (Postfix) with ESMTP id F3357A5;
        Wed, 28 Oct 2015 14:37:37 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
        by thoth.se.axis.com (Postfix) with ESMTP id F002D134059;
        Wed, 28 Oct 2015 14:37:37 +0100 (CET)
Received: from [10.94.49.1] (10.94.49.1) by xmail2.se.axis.com (10.0.5.74)
 with Microsoft SMTP Server (TLS) id 8.3.342.0; Wed, 28 Oct 2015 14:37:37
 +0100
Message-ID: <5630CFA1.4080207@axis.com>
Date:   Wed, 28 Oct 2015 14:37:37 +0100
From:   Niklas Cassel <niklas.cassel@axis.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
MIME-Version: 1.0
To:     <markos.chandras@imgtec.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        <wuzhangjin@gmail.com>, <rostedt@goodmis.org>
Subject: mips ftrace_init splat
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <niklas.cassel@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49730
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: niklas.cassel@axis.com
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

Hello.

I get the following splat when booting a kernel with CONFIG_DYNAMIC_FTRACE on a mips
without a Coherency Manager.


[    0.111734] ------------[ cut here ]------------
[    0.116268] WARNING: CPU: 0 PID: 0 at kernel/smp.c:417 smp_call_function_many+0x124/0x370()
[    0.124550] Modules linked in:
[    0.127603] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.3.0-rc7 #10
[    0.133838] Stack : 00000000 00000000 8081663a 00000037 80810000 00000000 0000000b 00000000
	  8069a4e8 80739ac7 80739fc0 00000000 00000000 80804b40 8071de60 80736638
	  00000000 800909dc 8074832c 80748330 000001a1 00000000 806a2a40 8071dd6c
	  8071de60 80114824 00000000 800909dc 80810000 00000082 8071dd6c 8069a4e8
	  00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
	  ...
[    0.169252] Call Trace:
[    0.171700] [<80020394>] show_stack+0x94/0xb0
[    0.176049] [<8032c3a4>] dump_stack+0x64/0x90
[    0.180394] [<80041e7c>] warn_slowpath_common+0xa4/0xe0
[    0.185581] [<80041edc>] warn_slowpath_null+0x24/0x30
[    0.190615] [<800b9ea4>] smp_call_function_many+0x124/0x370
[    0.196172] [<8003c00c>] r4k_flush_icache_range+0x26c/0x274
[    0.201732] [<80025310>] ftrace_modify_code+0x30/0x50
[    0.206773] [<80799d88>] ftrace_dyn_arch_init+0x58/0x6c
[    0.211976] [<807a31e4>] ftrace_init+0x24/0x134
[    0.216481] [<80793cb0>] start_kernel+0x50c/0x530
[    0.221161] 
[    0.222700] ---[ end trace cb88537fdc8fa200 ]---
[    0.227370] ftrace: allocating 17221 entries in 34 pages


the splat started showing up after the following patch:

cccf34e9411c ("MIPS: c-r4k: Fix cache flushing for MT cores")

Looking at the call trace, the kernel has just started (only CPU0 running),
and ftrace_init is called.

ftrace_init -> local_irq_save -> ftrace_dyn_arch_init ->
ftrace_modify_code -> flush_icache_range -> r4k_flush_icache_range ->
r4k_on_each_cpu(local_r4k_flush_icache_range_ipi, &args);

r4k_on_each_cpu calls (since the patch above) smp_call_function_many,
with in turn has a WARN_ON_ONCE if irqs_disabled.


One could replace flush_icache_range with flush_icache_all in all
mips ftrace_modify_code variants, which would make the splat go away,
but is this performance decrease acceptable?

I also found an old mail mentioning this problem
http://www.linux-mips.org/archives/linux-mips/2010-08/msg00176.html


Interestingly, mips appears to be the only arch which implements
ftrace_dyn_arch_init, all others just "return 0", so mips is the only arch
that sends IPI:s in ftrace_dyn_arch_init.

I'm not sure, but I think that ftrace_init -> ftrace_process_locs
local_irq_save ->  ftrace_update_code -> __ftrace_replace_code ->
ftrace_make_nop -> ftrace_modify_code -> flush_icache_range
is also possible during start up,
so refactoring away ftrace_dyn_arch_init probably won't
make sure that we don't get the splat anymore.
