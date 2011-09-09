Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Sep 2011 18:59:17 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9569 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491050Ab1IIQ7M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Sep 2011 18:59:12 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e6a46260000>; Fri, 09 Sep 2011 10:00:22 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 9 Sep 2011 09:59:09 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 9 Sep 2011 09:59:09 -0700
Message-ID: <4E6A45D9.6090706@cavium.com>
Date:   Fri, 09 Sep 2011 09:59:05 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Cosmin Ratiu <cratiu@ixiacom.com>
CC:     linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: Re: Octeon crash in virt_to_page(&core0_stack_variable)
References: <201109091623.29000.cratiu@ixiacom.com>
In-Reply-To: <201109091623.29000.cratiu@ixiacom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2011 16:59:09.0459 (UTC) FILETIME=[CACEF630:01CC6F11]
X-archive-position: 31055
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4945

On 09/09/2011 06:23 AM, Cosmin Ratiu wrote:
> Hello,
>
> I've been investigating a strange crash and I wanted to ask for your help.
> The crash happens when virt_to_page is called with an address from the softirq
> stack of core 0 on Cavium Octeon. It may happen on other MIPS processors as
> well, but I'm not sure.
>
> I've attached a simple kernel module to demonstrate the problem and the output
> of dmesg + the crash. Two seconds after inserting the module, the kernel
> should crash.
>
>  From what I've dug up in the kernel sources, it seems the stack for the first
> idle task resides in the data segment (mapped in kseg2) while the rest are
> allocated with kmalloc in __cpu_up() and reside in a different area (CAC_BASE
> upwards).
> It seems virt_to_phys produces bogus results for kseg2 and after that,
> virt_to_page crashes trying to access invalid memory.
>
> This problem was discovered when doing BGP traffic with the TCP MD5 option
> activated, where the following call chain caused a crash:
>
>   * tcp_v4_rcv
>   *  tcp_v4_timewait_ack
>   *   tcp_v4_send_ack ->  follow stack variable rep.th
>   *    tcp_v4_md5_hash_hdr
>   *     tcp_md5_hash_header
>   *      sg_init_one
>   *       sg_set_buf
>   *        virt_to_page
>
> I noticed that tcp_v4_send_reset uses a similar stack variable and also calls
> tcp_v4_md5_hash_hdr, so it has the same problem.
>
> I don't fully understand octeon mm details, so I wanted to bring up this issue
> in order to find a proper fix.
> To avoid the problem, I've implemented a quick hack to declare those variables
> percpu instead of on the stack, so they would also reside in CAC_BASE upwards.
> I've attached a patch against 2.6.32 for reference.
>
> Cosmin.
>
>
[...]
> [ 2040.300/0] Call Trace:
> [ 2040.300/0] [<ffffffffc123a054>] vcrash+0x54/0x80 [vcrash]
> [ 2040.300/0] [<ffffffffc0065f28>] run_timer_softirq+0x198/0x23c
> [ 2040.300/0] [<ffffffffc00609e0>] __do_softirq+0xd8/0x188

                   ^^^^^^^^^ CKSEG2 addresses detected!

You are using the out-of-tree mapped kernel patch which mucks about with 
the implementation of virt_to_phys().

Can you reproduce the TCP related crash in an unpatched kernel?

If not, then it would point to problems in the out-of-tree patches you 
have applied.

David Daney
