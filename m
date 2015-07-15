Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jul 2015 05:09:20 +0200 (CEST)
Received: from mail7.hitachi.co.jp ([133.145.228.42]:44308 "EHLO
        mail7.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006508AbbGODJSZ6PWU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jul 2015 05:09:18 +0200
Received: from mlsv4.hitachi.co.jp (unknown [133.144.234.166])
        by mail7.hitachi.co.jp (Postfix) with ESMTP id 86C23B1D385;
        Wed, 15 Jul 2015 12:09:14 +0900 (JST)
Received: from mfilter05.hitachi.co.jp by mlsv4.hitachi.co.jp (8.13.1/8.13.1) id t6F39EKq026964; Wed, 15 Jul 2015 12:09:14 +0900
Received: from vshuts02.hitachi.co.jp (vshuts02.hitachi.co.jp [10.201.6.84])
        by mfilter05.hitachi.co.jp (Switch-3.3.4/Switch-3.3.4) with ESMTP id t6F39Cda008508;
        Wed, 15 Jul 2015 12:09:13 +0900
Received: from gxml20a.ad.clb.hitachi.co.jp (unknown [158.213.157.160])
        by vshuts02.hitachi.co.jp (Postfix) with ESMTP id 5DC9449004D;
        Wed, 15 Jul 2015 12:09:12 +0900 (JST)
Received: from [10.198.220.34] by gxml20a.ad.clb.hitachi.co.jp (Switch-3.1.10/Switch-3.1.9) id 76F309BF9000093FC; Wed, 15 Jul 2015 12:09:11 +0900
Message-ID: <55A5CED4.7050400@hitachi.com>
Date:   Wed, 15 Jul 2015 12:09:08 +0900
From:   Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Organization: Hitachi, Ltd., Japan
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Vivek Goyal <vgoyal@redhat.com>,
        Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-mips@linux-mips.org, Baoquan He <bhe@redhat.com>,
        linux-sh@vger.kernel.org, linux-s390@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
        Daniel Walker <dwalker@fifo99.com>,
        linuxppc-dev@lists.ozlabs.org, linux-metag@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: Re: [PATCH 3/3] kexec: Change the timing of callbacks related
 to "crash_kexec_post_notifiers" boot option
References: <20150710113331.4368.10495.stgit@softrs> <20150710113331.4368.77050.stgit@softrs> <20150714144248.GC10792@redhat.com>
In-Reply-To: <20150714144248.GC10792@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <masami.hiramatsu.pt@hitachi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48300
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

On 2015/07/14 23:42, Vivek Goyal wrote:
> On Fri, Jul 10, 2015 at 08:33:31PM +0900, Hidehiro Kawai wrote:
>> This patch fixes problems reported by Daniel Walker
>> (https://lkml.org/lkml/2015/6/24/44), and also replaces the bug fix
>> commits 5375b70 and f45d85f.
>>
>> If "crash_kexec_post_notifiers" boot option is specified,
>> other cpus are stopped by smp_send_stop() before entering
>> crash_kexec(), while usually machine_crash_shutdown() called by
>> crash_kexec() does that.  This behavior change leads two problems.
>>
>>  Problem 1:
>>  Some function in the crash_kexec() path depend on other cpus being
>>  still online.  If other cpus have been offlined already, they
>>  doesn't work properly.
>>
>>   Example:
>>    panic()
>>     crash_kexec()
>>      machine_crash_shutdown()
>>       octeon_generic_shutdown() // shutdown watchdog for ONLINE cpus
>>      machine_kexec()
>>
>>  Problem 2:
>>  Most of architectures stop other cpus in the machine_crash_shutdown()
>>  path and save register information at the same time.  However, if
>>  smp_send_stop() is called before that, we can't save the register
>>  information.
>>
>> To solve these problems, this patch changes the timing of calling
>> the callbacks instead of changing the timing of crash_kexec() if
>> crash_kexec_post_notifiers boot option is specified.
>>
>>  Before:
>>   if (!crash_kexec_post_notifiers)
>>       crash_kexec()
>>
>>   smp_send_stop()
>>   atomic_notifier_call_chain()
>>   kmsg_dump()
>>
>>   if (crash_kexec_post_notifiers)
>>       crash_kexec()
>>
>>  After:
>>   crash_kexec()
>>       machine_crash_shutdown()
>>       if (crash_kexec_post_notifiers) {
>>           atomic_notifier_call_chain()
>>           kmsg_dump()
>>       }
>>       machine_kexec()
>>
>>   smp_send_stop()
>>   if (!crash_kexec_post_notifiers) {
>>       atomic_notifier_call_chain()
>>       kmsg_dump()
>>   }
>>
> 
> I think this new code flow looks bad. Now we are calling kmsg_dump()
> and atomic_notifier_call_chain() from inside the crash_kexec() as well
> as from inside panic(). This is bad.
> 
> So basic problem seems to be that cpus need to be stopped once (with
> or without panic notifiers. So why don't we look into desiginig a 
> function which stops cpus, saves register states first and then does
> rest of the processing.
> 
> Something like.
> 
> stop_cpus_save_register_state;
> 
> if (!crash_kexec_post_notifiers)
> 	crash_kexec()
> 
> atomic_notifier_call_chain()
> kmsg_dump()
> 
> Here crash_kexec() will have to be modified and it will assume that cpus
> have already been stopped and register states have already been saved.

Ah, nice! I like this idea :)

> 
> IOW, is there a reason that we can't get rid of smp_send_stop() and
> use the mechanism crash_kexec() is using to stop cpus after panic()?

I think there is no reason why we don't do so. smp_send_stop() just
stops other cpus, but crash's one does more (collect registers and
stop watchdogs if needed, etc.). why don't we just replace(improve) it?

Thank you!


-- 
Masami HIRAMATSU
Linux Technology Research Center, System Productivity Research Dept.
Center for Technology Innovation - Systems Engineering
Hitachi, Ltd., Research & Development Group
E-mail: masami.hiramatsu.pt@hitachi.com
