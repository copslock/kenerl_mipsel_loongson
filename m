Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 18:27:39 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48756 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822093AbaE2Q1fVOQ92 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 May 2014 18:27:35 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C90A97674869;
        Thu, 29 May 2014 17:27:24 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Thu, 29 May
 2014 17:27:27 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Thu, 29 May 2014 17:27:27 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 29 May
 2014 17:27:26 +0100
Message-ID: <53875FEE.1020607@imgtec.com>
Date:   Thu, 29 May 2014 17:27:26 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Gleb Natapov <gleb@kernel.org>, <kvm@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, David Daney <david.daney@cavium.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: Re: [PATCH v2 00/23] MIPS: KVM: Fixes and guest timer rewrite
References: <1401355005-20370-1-git-send-email-james.hogan@imgtec.com> <53870DAD.7050900@redhat.com> <53874719.5070604@imgtec.com> <538750F8.7040202@redhat.com>
In-Reply-To: <538750F8.7040202@redhat.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Hi Paolo,

On 29/05/14 16:23, Paolo Bonzini wrote:
> Il 29/05/2014 16:41, James Hogan ha scritto:
>> +
>> +    /* If VM clock stopped then state was already saved when it was
>> stopped */
>> +    if (runstate_is_running()) {
>> +        ret = kvm_mips_save_count(cs);
>> +        if (ret < 0) {
>> +            return ret;
>> +        }
>> +    }
>> +
> 
> You're expecting that calls to kvm_mips_get_cp0_registers and
> kvm_mips_put_cp0_registers are balanced and not nested.  Perhaps you
> should add an assert about it.

Yes and no. If you loadvm or do an incoming migration you get an extra
put without a prior get, so it has to handle that case (ensuring that
the timer is frozen in kvm_mips_restore_count). I don't think it should
ever do two kvm_mips_get_cp0_registers calls though, but it should still
handle it okay since the timer will already be frozen so it'd just read
the same values out.

(although as it stands CP0_Count never represents the offset from the VM
clock for KVM like it does with a running Count with TCG, so the vmstate
is technically incompatible between TCG/KVM).

>> +    if (!(count_ctl & KVM_REG_MIPS_COUNT_CTL_DC)) {
>> +        count_ctl |= KVM_REG_MIPS_COUNT_CTL_DC;
>> +        ret = kvm_mips_put_one_reg64(cs, KVM_REG_MIPS_COUNT_CTL,
>> &count_ctl);
>> +        if (ret < 0) {
>> +            return ret;
>> +        }
>> +    }
> 
> Would it make sense to return directly if the master disable bit is set?

It would probably indicate that kvm_mips_get_cp0_registers was called
twice, so yes it could do that, although it would probably be
unexpected/wrong if it did happen (maybe qemu modified the values while
the state was dirty).

>  The rest of this function is idempotent.
> 
> Also, perhaps this bit in kvm_mips_restore_count is unnecessary, and so
> is env->count_save_time in general:
> 
>> +        /* find time to resume the saved timer at */
>> +        now = get_clock();
>> +        count_resume = now - (cpu_get_clock_at(now) -
>> env->count_save_time);
> 
> Is the COUNT_RESUME write necessary if the VM is running?

Running at that instant or running continuously since the save?

At this instant the VM is always running. Either it's just been started
and other state isn't dirty, or the registers have been put while the VM
is running.

If the VM wasn't stopped since the context was saved, you're right that
it could skip modifying COUNT_RESUME, it won't have changed. It's there
for if the VM was stopped, e.g.:
stop vm - save
get regs
start vm
put regs - restore (e.g. before run vcpu)

in which case COUNT_RESUME must be altered for Count to keep a similar
offset against the vm clock (like hw/mips/cputimer.c ensures while count
is running - even when vm stopped).

> Does the
> master disable bit just latch the values, or does it really stop the
> timer?  (My reading of the code is the former, since writing
> COUNT_RESUME only modifies the bias: no write => no bias change => timer
> runs).

It appears latched in the sense that starting it again will jump Count
forward to the time it would have been had it not been disabled (with no
loss of Compare interrupt in that time).

However it does stop the timer and interrupts, so if you change Count it
will be as if you changed it exactly at the moment it was latched. If
you change COUNT_RESUME, Count will not change immediately, but the
monotonic time at which the (unchanged) Count value will appear to
resume counting will be changed. So in that sense it acts as a bias.
Increment it by 10ns and the Count will be 10ns behind when you resume
(as if it had been stopped for 10ns, so with no missed interrupts).

> And if the VM is not running, you have timer_state.cpu_ticks_enabled ==
> false, so cpu_get_clock_at() always returns timers_state.cpu_clock_offset.
> 
> So, if the COUNT_RESUME write is not necessary for a running VM, you can
> then just write get_clock() to COUNT_RESUME, which seems to make sense
> to me.

If the VM is stopped you probably wouldn't want to resume the timer yet
at all.

See above though, the VM is always running at this point
(restore_count), even if it has only just started (or may have been
stopped and started since the save).

Does that make sense? It's surprising hard to explain how it works
clearly without resorting to equations :)

Thanks
James
