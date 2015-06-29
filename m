Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jun 2015 11:53:37 +0200 (CEST)
Received: from mail7.hitachi.co.jp ([133.145.228.42]:54805 "EHLO
        mail7.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009455AbbF2JxfREntz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Jun 2015 11:53:35 +0200
Received: from mlsv4.hitachi.co.jp (unknown [133.144.234.166])
        by mail7.hitachi.co.jp (Postfix) with ESMTP id E8FA2B1D384;
        Mon, 29 Jun 2015 18:53:31 +0900 (JST)
Received: from mfilter05.hitachi.co.jp by mlsv4.hitachi.co.jp (8.13.1/8.13.1) id t5T9rVSS026986; Mon, 29 Jun 2015 18:53:31 +0900
Received: from vshuts04.hitachi.co.jp (vshuts04.hitachi.co.jp [10.201.6.86])
        by mfilter05.hitachi.co.jp (Switch-3.3.4/Switch-3.3.4) with ESMTP id t5T9rUj8012101;
        Mon, 29 Jun 2015 18:53:31 +0900
Received: from hsdlmain.sdl.hitachi.co.jp (unknown [133.144.14.194])
        by vshuts04.hitachi.co.jp (Postfix) with ESMTP id 72546140043;
        Mon, 29 Jun 2015 18:53:30 +0900 (JST)
Received: from hsdlvgate2.sdl.hitachi.co.jp by hsdlmain.sdl.hitachi.co.jp (8.13.8/3.7W11021512) id t5T9rUaI008047; Mon, 29 Jun 2015 18:53:30 +0900
X-AuditID: 85900ec0-9d7c9b9000001a57-32-55911585120c
Received: from sdl99w.sdl.hitachi.co.jp (sdl99w.yrl.intra.hitachi.co.jp [133.144.14.250])
        by hsdlvgate2.sdl.hitachi.co.jp (Symantec Mail Security) with ESMTP id BFE97236561;
        Mon, 29 Jun 2015 18:53:09 +0900 (JST)
Received: from mailb.sdl.hitachi.co.jp (sdl99b.yrl.intra.hitachi.co.jp [133.144.14.197])
        by sdl99w.sdl.hitachi.co.jp (Postfix) with ESMTP id 0493E53C218;
        Mon, 29 Jun 2015 18:53:30 +0900 (JST)
Received: from [10.198.219.44] (unknown [10.198.219.44])
        by mailb.sdl.hitachi.co.jp (Postfix) with ESMTP id CFDCE495B7E;
        Mon, 29 Jun 2015 18:53:29 +0900 (JST)
Message-ID: <55911599.3030607@hitachi.com>
Date:   Mon, 29 Jun 2015 18:53:29 +0900
From:   Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:13.0) Gecko/20120604 Thunderbird/13.0
MIME-Version: 1.0
To:     dwalker@fifo99.com
CC:     Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        david.daney@cavium.com, d.hatayama@jp.fujitsu.com,
        vgoyal@redhat.com, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
Subject: Re: kexec crash kernel running with watchdog enabled
References: <20150623140548.GA15591@fifo99.com> <558A53C0.5030700@hitachi.com> <20150624163141.GA20456@fifo99.com> <558CA488.4030400@hitachi.com> <20150626183302.GA26853@fifo99.com>
In-Reply-To: <20150626183302.GA26853@fifo99.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAA==
Return-Path: <hidehiro.kawai.ez@hitachi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hidehiro.kawai.ez@hitachi.com
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

(2015/06/27 3:33), dwalker@fifo99.com wrote:> On Fri, Jun 26, 2015 at 10:02:00AM +0900, Hidehiro Kawai wrote:
>> Hi,
>>
>> (2015/06/25 1:31), dwalker@fifo99.com wrote:
>>> On Wed, Jun 24, 2015 at 03:52:48PM +0900, Masami Hiramatsu wrote:
>>>> Hi,
>>>>
>>>> On 2015/06/23 23:05, dwalker@fifo99.com wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> There was a commit in kernel/panic.c which altered when the kexec crash kernel is executed,
>>>>>
>>>>> commit f06e5153f4ae2e2f3b0300f0e260e40cb7fefd45
>>>>> Author: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
>>>>> Date:   Fri Jun 6 14:37:07 2014 -0700
>>>>>
>>>>>     kernel/panic.c: add "crash_kexec_post_notifiers" option for kdump after panic_notifers
>>>>>
>>>>>
>>>>> This made it possible for smp_send_stop() to be executed prior to calling the kexec crash
>>>>> kernel.
>>>>>
>>>>> The issue is that smp_send_stop() offlines the cores, and other code depend on the cores being online.
>>>>>
>>>>> In my case on Octeon here's an example,
>>>>>
>>>>> panic()
>>>>>  crash_kexec()
>>>>>   machine_crash_shutdown()
>>>>>    octeon_generic_shutdown()
>>>>>
>>>>> Inside octeon_generic_shutdown() the Octeon watchdog is shutdown for_each_online_cpu(), but since
>>>>> most of the cpu's already got offlined in smp_send_stop() it means the watchdog is still alive on
>>>>> those cores. This results in a reboot during the crash kernel execution.
>>>>
>>>> Ah, I see.
>>>>
>>>>> Another example seem to be in default_machine_crash_shutdown() where crash_kexec_prepare_cpus() depends
>>>>> on an IPI for saving the registers on different cores. However, the cpu's are all offlined with
>>>>> interrupts disabled so they won't be running those IPI's in this case.
>>>>>
>>>>> I'm looking for any advice on how this should be fixed, or if it's already fixed. I'm not going to be
>>>>> submitting a patch so if anyone wants to submit one feel free to do so.
>>>>
>>>> Hmm, IMHO, when the cpu goes to offline in appropriate way(smp_send_stop), it should stop
>>>> watchdog timer on the offlined cpu too.
>>>> Or, you can also register crash handler which stops all watchdogs, but it's a bit tricky.
>>>>
>>>
>>> That doesn't really fix all the issue tho. As I was explaining generic MIPS code depends on the cpu's
>>> effectively being online for crash data collection (with an IPI). This issue may effect other architectures also,
>>> because smp_send_stop() offlines the cpu on other architectures also. I haven't surveyed the other architectures
>>> enough to know what issue could happen from this tho.
>>>
>>> Is it possible to move the smp_send_stop() below the notifiers ? I'm just throwing out ideas.
>>
>> No, that doesn't works.  Some notifiers assume that they run in
>> single core mode.
>>
>> Another possible solution is to add notifiers just after
>> machine_crash_shutdown() like this:
>>
>> void panic(const char *fmt, ...)
>> ...
>> -	if (!crash_kexec_post_notifiers)
>> -		crash_kexec(NULL);
>> +	crash_kexec(NULL, buf);
>>
>>   and
>>
>> -void crash_kexec(struct pt_regs *regs)
>> +void crash_kexec(struct pt_regs *regs, char *msg)
>>  ...
>>  		if (kexec_crash_image) {
>>  			struct pt_regs fixed_regs;
>>  
>>  			crash_setup_regs(&fixed_regs, regs);
>>  			crash_save_vmcoreinfo();
>>  			machine_crash_shutdown(&fixed_regs);
>> +			if (crash_kexec_post_notifiers) {
>> +				kmsg_dump(KMSG_DUMP_PANIC);
>> +				atomic_notifier_call_chain(&panic_notifier_list, 0, msg);
>> +			}
>>                         machine_kexec(kexec_crash_image);
>>
>> Most of archs stop other cores in machine_crash_shutdown(),
>> so it will work well.  Furthermore, it simplifies the special
>> case where crash_kexec() is called without entering panic().
>>
>> However, we need some tweaks for sh and s390 cases.  As for sh,
>> it seems not to stop other cores in the crash_kexec() sequence
>> (kdump support is incompleted?).  For s390, smp_send_stop() is
>> called in machine_kexec() but not machine_crash_shutdown().
> 
> You could add an ifdef into the __setup() to filter out s390 and sh, until we figure out what
> to do there. So the "crash_kexec_post_notifiers" wouldn't be available for those platforms.

I agree on disabling the "crash_kexec_post_notifiers" feature for
s390 and sh at this time.  Also, we should make this feature effective
only if CONFIG_CRASH_DUMP=y.  Otherwise, it makes no sense.

I'll prepare the bug fix patch.  Please wait a moment.

Regards,
-- 
Hidehiro Kawai
Hitachi, Ltd. Research & Development Group
