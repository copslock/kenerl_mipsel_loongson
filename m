Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Dec 2017 16:18:40 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:46197
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990487AbdLKPSdTwS1N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Dec 2017 16:18:33 +0100
Received: by mail-wm0-x241.google.com with SMTP id r78so15180316wme.5
        for <linux-mips@linux-mips.org>; Mon, 11 Dec 2017 07:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=89JfGKsK3Asbyqks7rL5Pk7KJHHqEqBh/Ephso427Ko=;
        b=gMbDZOpjo1VUU1MeQGU87QoAtxyxUpOUHc+fav7nEh+ur+78Rnr7UTRaXE3Mlv2WOg
         AqUdA8Fli0fK2j5dfZWgCQxS75h2ZrwosInTs3zXpBV8t8TMFM43JGRbGTskTfGl3zDs
         EyYxmYsTPJaCBKlI6xRjwhDrW7Vk9at5CqRhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=89JfGKsK3Asbyqks7rL5Pk7KJHHqEqBh/Ephso427Ko=;
        b=sPJx32tB0S5TMiVHzUHosx4JxzDPy7Xk4fSjQ6ICBpOeyE9zREW4poOEQexIXeacVF
         uUwopQ2s4OyPmp7B54r3x6g7IzazgWt3KslrvwqD161PSiDR19UpSMiTnfzM9DSPvnb5
         jhJtUx2dV4ElI8sM8YxQDEFFZgFWUE7TcMtlJntolL6O3NCx7agb1YVMXvTQEvG4oLpJ
         Iv9S7UwY5CwlhzgxjioYi/NnJlyf9FlYhcFHpR23oUsl6nt5DpZZ1MqrkYps0nkHxAj0
         s7zVJJIp0pF8qMBB0ESh1HHi/T/10A49qVPDK3If/Osn66bLCounr3XQC7xX2irA0vmh
         Pc9A==
X-Gm-Message-State: AKGB3mLRoEXx0/06tBqD11x//hifJgOOdJdol9pXzTRthvh7s0tTuvpu
        9RVBPdDJT4i5iMeo+Zh+Enuk1g==
X-Google-Smtp-Source: ACJfBotv3srJINiqlY3rG5G2A4BOklSLJpnpNCQF00RBnmBBhhYgnJKw/YGHNAXCs7JwAbs+4rkaDQ==
X-Received: by 10.80.143.67 with SMTP id 61mr1481378edy.219.1513005503845;
        Mon, 11 Dec 2017 07:18:23 -0800 (PST)
Received: from localhost (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id e46sm7088186edb.93.2017.12.11.07.18.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 11 Dec 2017 07:18:22 -0800 (PST)
Date:   Mon, 11 Dec 2017 16:18:18 +0100
From:   Christoffer Dall <christoffer.dall@linaro.org>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Christoffer Dall <cdall@kernel.org>, kvm@vger.kernel.org,
        Andrew Jones <drjones@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Paul Mackerras <paulus@ozlabs.org>, kvm-ppc@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 11/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_set_guest_debug
Message-ID: <20171211151818.GI910@cbox>
References: <20171204203538.8370-1-cdall@kernel.org>
 <20171204203538.8370-12-cdall@kernel.org>
 <20171211133943.236f18be.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171211133943.236f18be.cohuck@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: christoffer.dall@linaro.org
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

On Mon, Dec 11, 2017 at 01:39:43PM +0100, Cornelia Huck wrote:
> On Mon,  4 Dec 2017 21:35:33 +0100
> Christoffer Dall <cdall@kernel.org> wrote:
> 
> > From: Christoffer Dall <christoffer.dall@linaro.org>
> > 
> > Move vcpu_load() and vcpu_put() into the architecture specific
> > implementations of kvm_arch_vcpu_ioctl_set_guest_debug().
> > 
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> > ---
> >  arch/arm64/kvm/guest.c    | 15 ++++++++++++---
> >  arch/powerpc/kvm/book3s.c |  2 ++
> >  arch/powerpc/kvm/booke.c  | 19 +++++++++++++------
> >  arch/s390/kvm/kvm-s390.c  | 16 ++++++++++++----
> >  arch/x86/kvm/x86.c        |  4 +++-
> >  virt/kvm/kvm_main.c       |  2 --
> >  6 files changed, 42 insertions(+), 16 deletions(-)
> > 
> 
> > diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> > index 1b491b89cd43..7cb0e2677e60 100644
> > --- a/arch/powerpc/kvm/booke.c
> > +++ b/arch/powerpc/kvm/booke.c
> > @@ -2018,12 +2018,15 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
> >  {
> >  	struct debug_reg *dbg_reg;
> >  	int n, b = 0, w = 0;
> > +	int ret = 0;
> > +
> > +	vcpu_load(vcpu);
> >  
> >  	if (!(dbg->control & KVM_GUESTDBG_ENABLE)) {
> >  		vcpu->arch.dbg_reg.dbcr0 = 0;
> >  		vcpu->guest_debug = 0;
> >  		kvm_guest_protect_msr(vcpu, MSR_DE, false);
> > -		return 0;
> > +		goto out;
> >  	}
> >  
> >  	kvm_guest_protect_msr(vcpu, MSR_DE, true);
> > @@ -2055,8 +2058,9 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
> >  #endif
> >  
> >  	if (!(vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP))
> > -		return 0;
> > +		goto out;
> >  
> > +	ret = -EINVAL;
> >  	for (n = 0; n < (KVMPPC_BOOKE_IAC_NUM + KVMPPC_BOOKE_DAC_NUM); n++) {
> >  		uint64_t addr = dbg->arch.bp[n].addr;
> >  		uint32_t type = dbg->arch.bp[n].type;
> > @@ -2067,21 +2071,24 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
> >  		if (type & ~(KVMPPC_DEBUG_WATCH_READ |
> >  			     KVMPPC_DEBUG_WATCH_WRITE |
> >  			     KVMPPC_DEBUG_BREAKPOINT))
> > -			return -EINVAL;
> > +			goto out;
> >  
> >  		if (type & KVMPPC_DEBUG_BREAKPOINT) {
> >  			/* Setting H/W breakpoint */
> >  			if (kvmppc_booke_add_breakpoint(dbg_reg, addr, b++))
> > -				return -EINVAL;
> > +				goto out;
> >  		} else {
> >  			/* Setting H/W watchpoint */
> >  			if (kvmppc_booke_add_watchpoint(dbg_reg, addr,
> >  							type, w++))
> > -				return -EINVAL;
> > +				goto out;
> >  		}
> >  	}
> >  
> > -	return 0;
> > +	ret = 0;
> 
> I would probably set the -EINVAL in the individual branches (so it is
> clear that something is wrong, and it is not just a benign exit as in
> the cases above), but your code is correct as well.

I think that's better as well actually.  I got probably got a little
used to that pattern after looking the main dispatcher function for a
while.  I'm happy to change it.

> > +out:
> > +	vcpu_put(vcpu);
> > +	return ret;
> >  }
> >  
> >  void kvmppc_booke_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
> 
> In any case,
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Thanks!
-Christoffer
