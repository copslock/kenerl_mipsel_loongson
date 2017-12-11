Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Dec 2017 10:19:38 +0100 (CET)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:34608
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990424AbdLKJTbqZKv9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Dec 2017 10:19:31 +0100
Received: by mail-wm0-x243.google.com with SMTP id y82so12314239wmg.1
        for <linux-mips@linux-mips.org>; Mon, 11 Dec 2017 01:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xG75J/MCYrAAx2rG6EGc/KJJFMK36f+JruBbyYOYwBQ=;
        b=LWou24NiMgcviOV+gj1ajhFZsVzdd2q1MDO1FPb4MFGBNn7Vl8X3dEuDUSxgwIVN9y
         0Zi/yLcOcTfTrdju0D+xIUgrIjPlU1qnKlubIbHBc5gSK2FtWu4tMru4xn4/Ye9HSss/
         fh4771DcYF6XfDcW+Vr2Gn3Q5BtzEjmcDGREs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xG75J/MCYrAAx2rG6EGc/KJJFMK36f+JruBbyYOYwBQ=;
        b=ZF6TNzu8UP0IF8FQApsjHS5i+lUVjCKEHrk3xRrNlS/SaO/os52F7K8j/0E169BP/v
         1D00IVRwTudG49FisPiVG9o/VcyWkgQj9fIfBmaQ3B7YMMTPT0a9bEtx0uQPjjT2DlwF
         CzGQD78Som7yGezvYTrx+MiKksjrjT/9J2m8MS6hPGSmzkKbqbj6Fo7sxn03RuASBi+7
         u0xlkC30P8mQnvL4854TMzvb1jI8tHPSjoOwwU/i64QJoa9GPPngtg5pGupify/lr0EJ
         e44XevML8470i6W0LruyDdjnaeZa6IGtEf2bGfIgmYQ3VdV9LODdVkD/rqFriHa36VeI
         H8fA==
X-Gm-Message-State: AKGB3mJKssXrpgrj4qkau//+JaccFC1fUyeEhbGP9RaZdnor+g3dVqgI
        fDQk3ioPdb0yr/Mnag5FGbuCkA==
X-Google-Smtp-Source: ACJfBouKDCcVvE3yPKe1fDuOJkW2a0nU8Nv60wOyA2ICRevpFLvGm3ZCFcv0Hpo0krqSV9q/wUusqA==
X-Received: by 10.80.152.6 with SMTP id g6mr232954edb.28.1512983966271;
        Mon, 11 Dec 2017 01:19:26 -0800 (PST)
Received: from localhost (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id c30sm6299550edf.1.2017.12.11.01.19.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 11 Dec 2017 01:19:25 -0800 (PST)
Date:   Mon, 11 Dec 2017 10:19:21 +0100
From:   Christoffer Dall <christoffer.dall@linaro.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Christoffer Dall <cdall@kernel.org>, kvm@vger.kernel.org,
        Andrew Jones <drjones@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Paul Mackerras <paulus@ozlabs.org>, kvm-ppc@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 07/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_set_sregs
Message-ID: <20171211091921.GE910@cbox>
References: <20171204203538.8370-1-cdall@kernel.org>
 <20171204203538.8370-8-cdall@kernel.org>
 <0faf23f5-3540-47ac-19a9-0f44b2c782a0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0faf23f5-3540-47ac-19a9-0f44b2c782a0@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61399
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

On Fri, Dec 08, 2017 at 05:26:02PM +0100, David Hildenbrand wrote:
> 
> >  
> >  int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
> > diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> > index f647e121070e..cdf0be02c95a 100644
> > --- a/arch/powerpc/kvm/booke.c
> > +++ b/arch/powerpc/kvm/booke.c
> > @@ -1632,18 +1632,25 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
> >  {
> >  	int ret;
> >  
> > +	vcpu_load(vcpu);
> > +
> > +	ret = -EINVAL;
> 
> you can initialize this directly.
> 
> >  	if (vcpu->arch.pvr != sregs->pvr)
> > -		return -EINVAL;
> > +		goto out;
> >  
> >  	ret = set_sregs_base(vcpu, sregs);
> >  	if (ret < 0)
> > -		return ret;
> > +		goto out;
> >  
> >  	ret = set_sregs_arch206(vcpu, sregs);
> >  	if (ret < 0)
> > -		return ret;
> > +		goto out;
> > +
> > +	ret = vcpu->kvm->arch.kvm_ops->set_sregs(vcpu, sregs);
> >  
> > -	return vcpu->kvm->arch.kvm_ops->set_sregs(vcpu, sregs);
> > +out:
> > +	vcpu_put(vcpu);
> > +	return ret;
> >  }
> >  
> >  int kvmppc_get_one_reg(struct kvm_vcpu *vcpu, u64 id,
> > diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> > index 18011fc4ac49..d95b4f15e52b 100644
> > --- a/arch/s390/kvm/kvm-s390.c
> > +++ b/arch/s390/kvm/kvm-s390.c
> > @@ -2729,8 +2729,12 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
> >  int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
> >  				  struct kvm_sregs *sregs)
> >  {
> > +	vcpu_load(vcpu);
> > +
> >  	memcpy(&vcpu->run->s.regs.acrs, &sregs->acrs, sizeof(sregs->acrs));
> >  	memcpy(&vcpu->arch.sie_block->gcr, &sregs->crs, sizeof(sregs->crs));
> > +
> > +	vcpu_put(vcpu);
> >  	return 0;
> >  }
> >  
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 20a5f6776eea..a31a80aee0b9 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -7500,15 +7500,19 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
> >  	int mmu_reset_needed = 0;
> >  	int pending_vec, max_bits, idx;
> >  	struct desc_ptr dt;
> > +	int ret;
> > +
> > +	vcpu_load(vcpu);
> >  
> > +	ret = -EINVAL;
> 
> dito

Sure.

> 
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 

Thanks for the review!
-Christoffer
