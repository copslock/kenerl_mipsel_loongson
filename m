Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 22:45:02 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:65267 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822134AbaE2UoxzaaAx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 May 2014 22:44:53 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id DB772C5218F00;
        Thu, 29 May 2014 21:44:42 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Thu, 29 May 2014 21:44:46 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 29 May
 2014 21:44:46 +0100
Message-ID: <53879C3E.3040102@imgtec.com>
Date:   Thu, 29 May 2014 21:44:46 +0100
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
References: <1401355005-20370-1-git-send-email-james.hogan@imgtec.com> <53870DAD.7050900@redhat.com> <53874719.5070604@imgtec.com> <538750F8.7040202@redhat.com> <53875FEE.1020607@imgtec.com> <53876850.20600@redhat.com>
In-Reply-To: <53876850.20600@redhat.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40367
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

On 29/05/14 18:03, Paolo Bonzini wrote:
>>> Also, perhaps this bit in kvm_mips_restore_count is unnecessary, and so
>>> is env->count_save_time in general:
>>>
>>>> +        /* find time to resume the saved timer at */
>>>> +        now = get_clock();
>>>> +        count_resume = now - (cpu_get_clock_at(now) -
>>>> env->count_save_time);
>>>
>>> Is the COUNT_RESUME write necessary if the VM is running?
>>
>> Running at that instant or running continuously since the save?
>>
>> At this instant the VM is always running. Either it's just been started
>> and other state isn't dirty, or the registers have been put while the VM
>> is running.
> 
> The possible transitions are:
> 
> running, not dirty -> stopped
>     need to freeze and load the registers
> 
> stopped -> running, not dirty
>     will reload the registers, need to modify COUNT_RESUME
> 
> running, dirty -> stopped
>     no need to do anything
> 
> stopped -> running, dirty
>     will not reload the registers until put, will need to modify
>     COUNT_RESUME on the next transition to "running, not dirty"
> 
> running, not dirty -> running, dirty
>     need to freeze and load the registers
> 
> running, dirty -> running, not dirty
>     need to modify COUNT_RESUME if the machine had been stopped
>     in the meanwhile
> 
> The questions then is, can we skip tracking count_save_time and
> modifying COUNT_RESUME in kvm_mips_restore_count?  Then you can just
> write get_clock() to COUNT_RESUME in kvm_mips_update_state, like this:
> 
>     if (!running) {
>         if (!cs->kvm_vcpu_dirty) {
>             save;
>         }
>     else {
>         write get_clock() to COUNT_RESUME;
>         if (!cs->kvm_vcpu_dirty) {
>             restore;
>         }
>     }
> 
> and even drop patch 1.  COUNT_RESUME is not even ever read by QEMU nor
> stored in CPUState, so.
> 
> The difference is that the guest "loses" the time between the "running,
> not dirty -> running, dirty" and "running, dirty -> stopped"
> transitions, while "gaining" the time between "stopped -> running,
> dirty" and "running, dirty -> running, not dirty".  If this is right, I
> think the difference does not matter in practice and the new/simpler
> code even explains the definition of COUNT_RESUME better in my eyes.

Yes, I agree with your analysis and had considered something like this,
although it doesn't particularly appeal to my sense of perfectionism :).
It would be race free though, and if you're stopping the VM at all you
expect to lose some time anyway.

> 
>>> Does the
>>> master disable bit just latch the values, or does it really stop the
>>> timer?  (My reading of the code is the former, since writing
>>> COUNT_RESUME only modifies the bias: no write => no bias change => timer
>>> runs).
>>
>> It appears latched in the sense that starting it again will jump Count
>> forward to the time it would have been had it not been disabled (with no
>> loss of Compare interrupt in that time).
> 
> Yes, this is the important part because it means that the guest clock
> does not get progressively more skewed.  It also means that it is right
> to never write COUNT_RESUME except if you go through stop/continue.

Yes, if the VM hasn't been stopped the value written is unchanged from
that originally read (see below), so it could skip it in that case.

save:
  count_save_time = cpu_clock_offset + COUNT_RESUME
restore:
  COUNT_RESUME = get_clock() - (cpu_clock_offset + get_clock() -
count_save_time)
		= count_save_time - cpu_clock_offset
		= COUNT_RESUME

Cheers
James
