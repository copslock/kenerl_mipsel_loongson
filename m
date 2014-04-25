Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2014 18:55:59 +0200 (CEST)
Received: from mail-ie0-f175.google.com ([209.85.223.175]:53485 "EHLO
        mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6843070AbaDYQz4xItTT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Apr 2014 18:55:56 +0200
Received: by mail-ie0-f175.google.com with SMTP id to1so3934536ieb.6
        for <multiple recipients>; Fri, 25 Apr 2014 09:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=pXB2beOqBkM//RRvuN7/0hEndtJCU984oWVsdxiY8qw=;
        b=PtAALrbkLswHgOiqyCc2LjVJQBloauP6CzDe8rRgy34F5fE+Ctwp59Yf9rVcu24EXm
         F+Jv0WghBMmMtJt6MhkqaBNPXY0ow8IzaVNQuTMV9p4xq59cC5j0u5A5xIa66mpguY5Q
         djsq+F/KTDc7c2pw+iEoQ2mc5OjkCr15fiUgypkDpuWSmiIxMQSI458BGU5fbHFrlJQp
         npYSQjBiiOsq8b2vzmx1kP9O1vQ1WQ4wcqHpPSvaKkjmDz92M2MwG7s0ji65yGEktn9H
         mDiOibPVcAFV6iYn1/MOCy58EJb5G9/Nw2J2MhiRLNhLcvEVC/g1VhGZxj8e/Lpi8iY0
         sITw==
X-Received: by 10.50.109.230 with SMTP id hv6mr6361155igb.9.1398444950414;
        Fri, 25 Apr 2014 09:55:50 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id p7sm9933369igg.15.2014.04.25.09.55.48
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 25 Apr 2014 09:55:49 -0700 (PDT)
Message-ID: <535A9393.9010907@gmail.com>
Date:   Fri, 25 Apr 2014 09:55:47 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: Re: [PATCH 09/21] MIPS: KVM: Fix timer race modifying guest CP0_Cause
References: <1398439204-26171-1-git-send-email-james.hogan@imgtec.com> <1398439204-26171-10-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1398439204-26171-10-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39949
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 04/25/2014 08:19 AM, James Hogan wrote:
> The hrtimer callback for guest timer timeouts sets the guest's
> CP0_Cause.TI bit to indicate to the guest that a timer interrupt is
> pending, however there is no mutual exclusion implemented to prevent
> this occurring while the guest's CP0_Cause register is being
> read-modify-written elsewhere.
>
> When this occurs the setting of the CP0_Cause.TI bit is undone and the
> guest misses the timer interrupt and doesn't reprogram the CP0_Compare
> register for the next timeout. Currently another timer interrupt will be
> triggered again in another 10ms anyway due to the way timers are
> emulated, but after the MIPS timer emulation is fixed this would result
> in Linux guest time standing still and the guest scheduler not being
> invoked until the guest CP0_Count has looped around again, which at
> 100MHz takes just under 43 seconds.
>
> Currently this is the only asynchronous modification of guest registers,
> therefore it is fixed by adjusting the implementations of the
> kvm_set_c0_guest_cause(), kvm_clear_c0_guest_cause(), and
> kvm_change_c0_guest_cause() macros which are used for modifying the
> guest CP0_Cause register to use ll/sc to ensure atomic modification.
> This should work in both UP and SMP cases without requiring interrupts
> to be disabled.
>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Gleb Natapov <gleb@kernel.org>
> Cc: kvm@vger.kernel.org
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: Sanjay Lal <sanjayl@kymasys.com>

NACK, I don't like the names of these functions.  They initially 
confused me too much...

> ---
>   arch/mips/include/asm/kvm_host.h | 71 ++++++++++++++++++++++++++++++++++++----
>   1 file changed, 65 insertions(+), 6 deletions(-)
>
> diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
> index 3eedcb3015e5..90e1c0005ff4 100644
> --- a/arch/mips/include/asm/kvm_host.h
> +++ b/arch/mips/include/asm/kvm_host.h
> @@ -481,15 +481,74 @@ struct kvm_vcpu_arch {
>   #define kvm_read_c0_guest_errorepc(cop0)	(cop0->reg[MIPS_CP0_ERROR_PC][0])
>   #define kvm_write_c0_guest_errorepc(cop0, val)	(cop0->reg[MIPS_CP0_ERROR_PC][0] = (val))
>
> +/*
> + * Some of the guest registers may be modified asynchronously (e.g. from a
> + * hrtimer callback in hard irq context) and therefore need stronger atomicity
> + * guarantees than other registers.
> + */
> +
> +static inline void _kvm_atomic_set_c0_guest_reg(unsigned long *reg,
> +						unsigned long val)

The name of this function is too unclear.

It should be _kvm_atomic_or_c0_guest_reg, or 
_kvm_atomic_setbits_c0_guest_reg(unsigned long *reg, unsigned long mask)

> +{
> +	unsigned long temp;
> +	do {
> +		__asm__ __volatile__(
> +		"	.set	mips3				\n"
> +		"	" __LL "%0, %1				\n"
> +		"	or	%0, %2				\n"
> +		"	" __SC	"%0, %1				\n"
> +		"	.set	mips0				\n"
> +		: "=&r" (temp), "+m" (*reg)
> +		: "r" (val));
> +	} while (unlikely(!temp));
> +}
> +
> +static inline void _kvm_atomic_clear_c0_guest_reg(unsigned long *reg,
> +						  unsigned long val)

Same here.

Perhaps _kvm_atomic_clearbits_c0_guest_reg(unsigned long *reg, unsigned 
long mask)

> +{
> +	unsigned long temp;
> +	do {
> +		__asm__ __volatile__(
> +		"	.set	mips3				\n"
> +		"	" __LL "%0, %1				\n"
> +		"	and	%0, %2				\n"
> +		"	" __SC	"%0, %1				\n"
> +		"	.set	mips0				\n"
> +		: "=&r" (temp), "+m" (*reg)
> +		: "r" (~val));
> +	} while (unlikely(!temp));
> +}
> +
> +static inline void _kvm_atomic_change_c0_guest_reg(unsigned long *reg,
> +						   unsigned long change,
> +						   unsigned long val)

Same here.

Perhaps

_kvm_atomic_setbits_c0_guest_reg(unsigned long *reg,
				unsigned long mask,
				unsigned long bits)

> +{
> +	unsigned long temp;
> +	do {
> +		__asm__ __volatile__(
> +		"	.set	mips3				\n"
> +		"	" __LL "%0, %1				\n"
> +		"	and	%0, %2				\n"
> +		"	or	%0, %3				\n"
> +		"	" __SC	"%0, %1				\n"
> +		"	.set	mips0				\n"
> +		: "=&r" (temp), "+m" (*reg)
> +		: "r" (~change), "r" (val & change));
> +	} while (unlikely(!temp));
> +}
> +
>   #define kvm_set_c0_guest_status(cop0, val)	(cop0->reg[MIPS_CP0_STATUS][0] |= (val))
>   #define kvm_clear_c0_guest_status(cop0, val)	(cop0->reg[MIPS_CP0_STATUS][0] &= ~(val))
> -#define kvm_set_c0_guest_cause(cop0, val)	(cop0->reg[MIPS_CP0_CAUSE][0] |= (val))
> -#define kvm_clear_c0_guest_cause(cop0, val)	(cop0->reg[MIPS_CP0_CAUSE][0] &= ~(val))
> +
> +/* Cause can be modified asynchronously from hardirq hrtimer callback */
> +#define kvm_set_c0_guest_cause(cop0, val)				\
> +	_kvm_atomic_set_c0_guest_reg(&cop0->reg[MIPS_CP0_CAUSE][0], val)
> +#define kvm_clear_c0_guest_cause(cop0, val)				\
> +	_kvm_atomic_clear_c0_guest_reg(&cop0->reg[MIPS_CP0_CAUSE][0], val)
>   #define kvm_change_c0_guest_cause(cop0, change, val)			\
> -{									\
> -	kvm_clear_c0_guest_cause(cop0, change);				\
> -	kvm_set_c0_guest_cause(cop0, ((val) & (change)));		\
> -}
> +	_kvm_atomic_change_c0_guest_reg(&cop0->reg[MIPS_CP0_CAUSE][0],	\
> +					change, val)
> +
>   #define kvm_set_c0_guest_ebase(cop0, val)	(cop0->reg[MIPS_CP0_PRID][1] |= (val))
>   #define kvm_clear_c0_guest_ebase(cop0, val)	(cop0->reg[MIPS_CP0_PRID][1] &= ~(val))
>   #define kvm_change_c0_guest_ebase(cop0, change, val)			\
>
