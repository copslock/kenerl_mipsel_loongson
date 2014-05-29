Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 19:04:42 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:26893 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817913AbaE2REkLy652 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 May 2014 19:04:40 +0200
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s4TH3H0O015443
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 29 May 2014 13:03:17 -0400
Received: from yakj.usersys.redhat.com (ovpn-112-34.ams2.redhat.com [10.36.112.34])
        by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id s4TH3CYe007734;
        Thu, 29 May 2014 13:03:13 -0400
Message-ID: <53876850.20600@redhat.com>
Date:   Thu, 29 May 2014 19:03:12 +0200
From:   Paolo Bonzini <pbonzini@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: Re: [PATCH v2 00/23] MIPS: KVM: Fixes and guest timer rewrite
References: <1401355005-20370-1-git-send-email-james.hogan@imgtec.com> <53870DAD.7050900@redhat.com> <53874719.5070604@imgtec.com> <538750F8.7040202@redhat.com> <53875FEE.1020607@imgtec.com>
In-Reply-To: <53875FEE.1020607@imgtec.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40361
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pbonzini@redhat.com
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

Il 29/05/2014 18:27, James Hogan ha scritto:
> (although as it stands CP0_Count never represents the offset from the VM
> clock for KVM like it does with a running Count with TCG, so the vmstate
> is technically incompatible between TCG/KVM).

That can be fixed in cpu_save/cpu_load hooks, like

     if (kvm_enabled()) {
         uint32_t TCGlike_CP0_Count = ...
         qemu_put_sbe32s(f, &TCGlike_CP0_Count);
     } else {
         qemu_put_sbe32s(f, &env->CP0_Count);
     }

...

     if (kvm_enabled()) {
         uint32_t TCGlike_CP0_Count;
         qemu_get_sbe32s(f, &TCGlike_CP0_Count);
         env->CP0_Count = ...
     } else {
         qemu_get_sbe32s(f, &env->CP0_Count);
     }

>> Also, perhaps this bit in kvm_mips_restore_count is unnecessary, and so
>> is env->count_save_time in general:
>>
>>> +        /* find time to resume the saved timer at */
>>> +        now = get_clock();
>>> +        count_resume = now - (cpu_get_clock_at(now) -
>>> env->count_save_time);
>>
>> Is the COUNT_RESUME write necessary if the VM is running?
>
> Running at that instant or running continuously since the save?
>
> At this instant the VM is always running. Either it's just been started
> and other state isn't dirty, or the registers have been put while the VM
> is running.

The possible transitions are:

running, not dirty -> stopped
	need to freeze and load the registers

stopped -> running, not dirty
	will reload the registers, need to modify COUNT_RESUME

running, dirty -> stopped
	no need to do anything

stopped -> running, dirty
	will not reload the registers until put, will need to modify
	COUNT_RESUME on the next transition to "running, not dirty"

running, not dirty -> running, dirty
	need to freeze and load the registers

running, dirty -> running, not dirty
	need to modify COUNT_RESUME if the machine had been stopped
	in the meanwhile

The questions then is, can we skip tracking count_save_time and 
modifying COUNT_RESUME in kvm_mips_restore_count?  Then you can just 
write get_clock() to COUNT_RESUME in kvm_mips_update_state, like this:

     if (!running) {
         if (!cs->kvm_vcpu_dirty) {
             save;
         }
     else {
         write get_clock() to COUNT_RESUME;
         if (!cs->kvm_vcpu_dirty) {
             restore;
         }
     }

and even drop patch 1.  COUNT_RESUME is not even ever read by QEMU nor 
stored in CPUState, so.

The difference is that the guest "loses" the time between the "running, 
not dirty -> running, dirty" and "running, dirty -> stopped" 
transitions, while "gaining" the time between "stopped -> running, 
dirty" and "running, dirty -> running, not dirty".  If this is right, I 
think the difference does not matter in practice and the new/simpler 
code even explains the definition of COUNT_RESUME better in my eyes.

>> Does the
>> master disable bit just latch the values, or does it really stop the
>> timer?  (My reading of the code is the former, since writing
>> COUNT_RESUME only modifies the bias: no write => no bias change => timer
>> runs).
>
> It appears latched in the sense that starting it again will jump Count
> forward to the time it would have been had it not been disabled (with no
> loss of Compare interrupt in that time).

Yes, this is the important part because it means that the guest clock 
does not get progressively more skewed.  It also means that it is right 
to never write COUNT_RESUME except if you go through stop/continue.

Paolo
