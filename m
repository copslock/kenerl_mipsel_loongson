Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 17:24:58 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:26754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816069AbaE2PYxYZuoK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 May 2014 17:24:53 +0200
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s4TFNemC013320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 May 2014 11:23:41 -0400
Received: from yakj.usersys.redhat.com (ovpn-112-34.ams2.redhat.com [10.36.112.34])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s4TFNatp028431;
        Thu, 29 May 2014 11:23:37 -0400
Message-ID: <538750F8.7040202@redhat.com>
Date:   Thu, 29 May 2014 17:23:36 +0200
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
References: <1401355005-20370-1-git-send-email-james.hogan@imgtec.com> <53870DAD.7050900@redhat.com> <53874719.5070604@imgtec.com>
In-Reply-To: <53874719.5070604@imgtec.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40358
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

Il 29/05/2014 16:41, James Hogan ha scritto:
> +
> +    /* If VM clock stopped then state was already saved when it was stopped */
> +    if (runstate_is_running()) {
> +        ret = kvm_mips_save_count(cs);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +    }
> +

You're expecting that calls to kvm_mips_get_cp0_registers and 
kvm_mips_put_cp0_registers are balanced and not nested.  Perhaps you 
should add an assert about it.

> +    if (!(count_ctl & KVM_REG_MIPS_COUNT_CTL_DC)) {
> +        count_ctl |= KVM_REG_MIPS_COUNT_CTL_DC;
> +        ret = kvm_mips_put_one_reg64(cs, KVM_REG_MIPS_COUNT_CTL, &count_ctl);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +    }

Would it make sense to return directly if the master disable bit is set? 
  The rest of this function is idempotent.

Also, perhaps this bit in kvm_mips_restore_count is unnecessary, and so 
is env->count_save_time in general:

> +        /* find time to resume the saved timer at */
> +        now = get_clock();
> +        count_resume = now - (cpu_get_clock_at(now) - env->count_save_time);

Is the COUNT_RESUME write necessary if the VM is running?  Does the 
master disable bit just latch the values, or does it really stop the 
timer?  (My reading of the code is the former, since writing 
COUNT_RESUME only modifies the bias: no write => no bias change => timer 
runs).

And if the VM is not running, you have timer_state.cpu_ticks_enabled == 
false, so cpu_get_clock_at() always returns timers_state.cpu_clock_offset.

So, if the COUNT_RESUME write is not necessary for a running VM, you can 
then just write get_clock() to COUNT_RESUME, which seems to make sense 
to me.

Paolo
