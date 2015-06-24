Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jun 2015 08:52:59 +0200 (CEST)
Received: from mail9.hitachi.co.jp ([133.145.228.44]:39142 "EHLO
        mail9.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006697AbbFXGw5zwnZp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Jun 2015 08:52:57 +0200
Received: from mlsv6.hitachi.co.jp (unknown [133.144.234.166])
        by mail9.hitachi.co.jp (Postfix) with ESMTP id 72A07109BD82;
        Wed, 24 Jun 2015 15:52:54 +0900 (JST)
Received: from mfilter06.hitachi.co.jp by mlsv6.hitachi.co.jp (8.13.1/8.13.1) id t5O6qs6K017874; Wed, 24 Jun 2015 15:52:54 +0900
Received: from vshuts04.hitachi.co.jp (vshuts04.hitachi.co.jp [10.201.6.86])
        by mfilter06.hitachi.co.jp (Switch-3.3.4/Switch-3.3.4) with ESMTP id t5O6qrS4015990;
        Wed, 24 Jun 2015 15:52:53 +0900
Received: from gxml20a.ad.clb.hitachi.co.jp (unknown [158.213.157.160])
        by vshuts04.hitachi.co.jp (Postfix) with ESMTP id B490114003B;
        Wed, 24 Jun 2015 15:52:52 +0900 (JST)
Received: from [10.198.219.41] by gxml20a.ad.clb.hitachi.co.jp (Switch-3.1.10/Switch-3.1.9) id 75O63GGVY00004FE8; Wed, 24 Jun 2015 15:52:52 +0900
Message-ID: <558A53C0.5030700@hitachi.com>
Date:   Wed, 24 Jun 2015 15:52:48 +0900
From:   Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Organization: Hitachi, Ltd., Japan
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     dwalker@fifo99.com, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, david.daney@cavium.com
CC:     d.hatayama@jp.fujitsu.com, vgoyal@redhat.com,
        hidehiro.kawai.ez@hitachi.com, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
Subject: Re: kexec crash kernel running with watchdog enabled
References: <20150623140548.GA15591@fifo99.com>
In-Reply-To: <20150623140548.GA15591@fifo99.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <masami.hiramatsu.pt@hitachi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48016
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: masami.hiramatsu.pt@hitachi.com
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

Hi,

On 2015/06/23 23:05, dwalker@fifo99.com wrote:
> 
> Hi,
> 
> There was a commit in kernel/panic.c which altered when the kexec crash kernel is executed,
> 
> commit f06e5153f4ae2e2f3b0300f0e260e40cb7fefd45
> Author: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> Date:   Fri Jun 6 14:37:07 2014 -0700
> 
>     kernel/panic.c: add "crash_kexec_post_notifiers" option for kdump after panic_notifers
> 
> 
> This made it possible for smp_send_stop() to be executed prior to calling the kexec crash
> kernel.
> 
> The issue is that smp_send_stop() offlines the cores, and other code depend on the cores being online.
> 
> In my case on Octeon here's an example,
> 
> panic()
>  crash_kexec()
>   machine_crash_shutdown()
>    octeon_generic_shutdown()
> 
> Inside octeon_generic_shutdown() the Octeon watchdog is shutdown for_each_online_cpu(), but since
> most of the cpu's already got offlined in smp_send_stop() it means the watchdog is still alive on
> those cores. This results in a reboot during the crash kernel execution.

Ah, I see.

> Another example seem to be in default_machine_crash_shutdown() where crash_kexec_prepare_cpus() depends
> on an IPI for saving the registers on different cores. However, the cpu's are all offlined with
> interrupts disabled so they won't be running those IPI's in this case.
> 
> I'm looking for any advice on how this should be fixed, or if it's already fixed. I'm not going to be
> submitting a patch so if anyone wants to submit one feel free to do so.

Hmm, IMHO, when the cpu goes to offline in appropriate way(smp_send_stop), it should stop
watchdog timer on the offlined cpu too.
Or, you can also register crash handler which stops all watchdogs, but it's a bit tricky.

Thank you,

-- 
Masami HIRAMATSU
Linux Technology Research Center, System Productivity Research Dept.
Center for Technology Innovation - Systems Engineering
Hitachi, Ltd., Research & Development Group
E-mail: masami.hiramatsu.pt@hitachi.com
