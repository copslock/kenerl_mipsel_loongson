Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Jun 2015 03:02:09 +0200 (CEST)
Received: from mail7.hitachi.co.jp ([133.145.228.42]:60309 "EHLO
        mail7.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009028AbbFZBCHcX2su (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Jun 2015 03:02:07 +0200
Received: from mlsv3.hitachi.co.jp (unknown [133.144.234.166])
        by mail7.hitachi.co.jp (Postfix) with ESMTP id 55ECDB1D386;
        Fri, 26 Jun 2015 10:02:04 +0900 (JST)
Received: from mfilter04.hitachi.co.jp by mlsv3.hitachi.co.jp (8.13.1/8.13.1) id t5Q124iu025424; Fri, 26 Jun 2015 10:02:04 +0900
Received: from vshuts02.hitachi.co.jp (vshuts02.hitachi.co.jp [10.201.6.84])
        by mfilter04.hitachi.co.jp (Switch-3.3.4/Switch-3.3.4) with ESMTP id t5Q123Rh012349;
        Fri, 26 Jun 2015 10:02:03 +0900
Received: from hsdlmain.sdl.hitachi.co.jp (unknown [133.144.14.194])
        by vshuts02.hitachi.co.jp (Postfix) with ESMTP id 1585B490041;
        Fri, 26 Jun 2015 10:02:02 +0900 (JST)
Received: from hsdlvgate2.sdl.hitachi.co.jp by hsdlmain.sdl.hitachi.co.jp (8.13.8/3.7W11021512) id t5Q1219h032007; Fri, 26 Jun 2015 10:02:01 +0900
X-AuditID: 85900ec0-9c3c7b9000001a57-88-558ca476f848
Received: from sdl99w.sdl.hitachi.co.jp (sdl99w.yrl.intra.hitachi.co.jp [133.144.14.250])
        by hsdlvgate2.sdl.hitachi.co.jp (Symantec Mail Security) with ESMTP id 5BBF3236561;
        Fri, 26 Jun 2015 10:01:42 +0900 (JST)
Received: from mailb.sdl.hitachi.co.jp (sdl99b.yrl.intra.hitachi.co.jp [133.144.14.197])
        by sdl99w.sdl.hitachi.co.jp (Postfix) with ESMTP id 8888D53C218;
        Fri, 26 Jun 2015 10:02:01 +0900 (JST)
Received: from [10.198.219.40] (unknown [10.198.219.40])
        by mailb.sdl.hitachi.co.jp (Postfix) with ESMTP id 5DCD3495B93;
        Fri, 26 Jun 2015 10:02:01 +0900 (JST)
Message-ID: <558CA488.4030400@hitachi.com>
Date:   Fri, 26 Jun 2015 10:02:00 +0900
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
References: <20150623140548.GA15591@fifo99.com> <558A53C0.5030700@hitachi.com> <20150624163141.GA20456@fifo99.com>
In-Reply-To: <20150624163141.GA20456@fifo99.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAA==
Return-Path: <hidehiro.kawai.ez@hitachi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48033
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

(2015/06/25 1:31), dwalker@fifo99.com wrote:
> On Wed, Jun 24, 2015 at 03:52:48PM +0900, Masami Hiramatsu wrote:
>> Hi,
>>
>> On 2015/06/23 23:05, dwalker@fifo99.com wrote:
>>>
>>> Hi,
>>>
>>> There was a commit in kernel/panic.c which altered when the kexec crash kernel is executed,
>>>
>>> commit f06e5153f4ae2e2f3b0300f0e260e40cb7fefd45
>>> Author: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
>>> Date:   Fri Jun 6 14:37:07 2014 -0700
>>>
>>>     kernel/panic.c: add "crash_kexec_post_notifiers" option for kdump after panic_notifers
>>>
>>>
>>> This made it possible for smp_send_stop() to be executed prior to calling the kexec crash
>>> kernel.
>>>
>>> The issue is that smp_send_stop() offlines the cores, and other code depend on the cores being online.
>>>
>>> In my case on Octeon here's an example,
>>>
>>> panic()
>>>  crash_kexec()
>>>   machine_crash_shutdown()
>>>    octeon_generic_shutdown()
>>>
>>> Inside octeon_generic_shutdown() the Octeon watchdog is shutdown for_each_online_cpu(), but since
>>> most of the cpu's already got offlined in smp_send_stop() it means the watchdog is still alive on
>>> those cores. This results in a reboot during the crash kernel execution.
>>
>> Ah, I see.
>>
>>> Another example seem to be in default_machine_crash_shutdown() where crash_kexec_prepare_cpus() depends
>>> on an IPI for saving the registers on different cores. However, the cpu's are all offlined with
>>> interrupts disabled so they won't be running those IPI's in this case.
>>>
>>> I'm looking for any advice on how this should be fixed, or if it's already fixed. I'm not going to be
>>> submitting a patch so if anyone wants to submit one feel free to do so.
>>
>> Hmm, IMHO, when the cpu goes to offline in appropriate way(smp_send_stop), it should stop
>> watchdog timer on the offlined cpu too.
>> Or, you can also register crash handler which stops all watchdogs, but it's a bit tricky.
>>
> 
> That doesn't really fix all the issue tho. As I was explaining generic MIPS code depends on the cpu's
> effectively being online for crash data collection (with an IPI). This issue may effect other architectures also,
> because smp_send_stop() offlines the cpu on other architectures also. I haven't surveyed the other architectures
> enough to know what issue could happen from this tho.
> 
> Is it possible to move the smp_send_stop() below the notifiers ? I'm just throwing out ideas.

No, that doesn't works.  Some notifiers assume that they run in
single core mode.

Another possible solution is to add notifiers just after
machine_crash_shutdown() like this:

void panic(const char *fmt, ...)
...
-	if (!crash_kexec_post_notifiers)
-		crash_kexec(NULL);
+	crash_kexec(NULL, buf);

  and

-void crash_kexec(struct pt_regs *regs)
+void crash_kexec(struct pt_regs *regs, char *msg)
 ...
 		if (kexec_crash_image) {
 			struct pt_regs fixed_regs;
 
 			crash_setup_regs(&fixed_regs, regs);
 			crash_save_vmcoreinfo();
 			machine_crash_shutdown(&fixed_regs);
+			if (crash_kexec_post_notifiers) {
+				kmsg_dump(KMSG_DUMP_PANIC);
+				atomic_notifier_call_chain(&panic_notifier_list, 0, msg);
+			}
                        machine_kexec(kexec_crash_image);

Most of archs stop other cores in machine_crash_shutdown(),
so it will work well.  Furthermore, it simplifies the special
case where crash_kexec() is called without entering panic().

However, we need some tweaks for sh and s390 cases.  As for sh,
it seems not to stop other cores in the crash_kexec() sequence
(kdump support is incompleted?).  For s390, smp_send_stop() is
called in machine_kexec() but not machine_crash_shutdown().

Regards,

-- 
Hidehiro Kawai
Hitachi, Ltd. Research & Development Group
