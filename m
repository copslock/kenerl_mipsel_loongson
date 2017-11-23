Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Nov 2017 19:32:56 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:44909
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991416AbdKWSctbr1Jr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Nov 2017 19:32:49 +0100
Received: by mail-wm0-x241.google.com with SMTP id r68so18590770wmr.3
        for <linux-mips@linux-mips.org>; Thu, 23 Nov 2017 10:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pMMG5PDfy6hps7fhZ9adbkmOh8+MgRbgegILzKnKzZE=;
        b=Fx1zHpZvtsNUEDqoZWtJlN0LHjjduDW96n7ViFJ3Me3KLFKs2WhMMYJHELNCbNCTpQ
         Odpu3Ie6j6dSYL/vUeMCaBsyCRK3mAoM1w8vPl3+jPuN0O697UT+YFmnCcFpiAmdVMq+
         kewtxjlmZruPIM7ZrGmuKRR7FU3aZP2iCC2Dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pMMG5PDfy6hps7fhZ9adbkmOh8+MgRbgegILzKnKzZE=;
        b=qwkLnX31qWQ1/9A4CU8X2tyAJLz7ucqgu2vUpUN3rh4nB7jHuCcd8u/9UfJJRL7PNB
         1iKVbjRztdY8HPW1Z7xH6hVClYL7eESlVbWqpimgkSjw5uwAZlWYNbJntkb0SbsEp09y
         fnyqN3L4hNJh5Oy8pymDbUdtOxdbJ9cqgiOHwnIiCT4sVkuiuAkD+rB0c+FWj4K15URj
         3t/X7ISxb6Nw1pb2t3RYwYAESz8IVRxEATs91H2h5hAOFoTllXF9CpQjuttZnyATJi5U
         4Mol4vKRnE0U6TBNYxcoOGWzuMDH/upwduroWHzjXpw6aiGorPqf+wtsPrrW025yWdbZ
         1Sew==
X-Gm-Message-State: AJaThX54hl1mZ3+2t8neyn5jBZhchO8R4HNpaISKFUh6s9+1MKwlSueG
        CV08CyfxU/ZdVa/GukLFZJALPA==
X-Google-Smtp-Source: AGs4zMZvJ9SAocoAeOzJPJO5452uZW4/U3yOVXJBFYTJ37np+qNf6ooqehfezpmF52UiGt4u9vxoRg==
X-Received: by 10.28.191.3 with SMTP id p3mr6991505wmf.81.1511461964038;
        Thu, 23 Nov 2017 10:32:44 -0800 (PST)
Received: from localhost (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id 64sm9425033wrk.46.2017.11.23.10.32.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Nov 2017 10:32:43 -0800 (PST)
Date:   Thu, 23 Nov 2017 19:32:55 +0100
From:   Christoffer Dall <cdall@linaro.org>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        kvm@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
        Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
Subject: Re: [RFC PATCH] KVM: Only register preempt notifiers and load arch
 cpu state as needed
Message-ID: <20171123183255.GD28855@cbox>
References: <20171123160521.27260-1-christoffer.dall@linaro.org>
 <72357599-798d-14d0-336a-69a083f17863@redhat.com>
 <20171123170642.GA28855@cbox>
 <57693a50-e682-9b3b-7d8c-c46b66e33d84@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57693a50-e682-9b3b-7d8c-c46b66e33d84@de.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cdall@linaro.org
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

On Thu, Nov 23, 2017 at 07:05:07PM +0100, Christian Borntraeger wrote:
> 
> 
> On 11/23/2017 06:06 PM, Christoffer Dall wrote:
> > On Thu, Nov 23, 2017 at 05:17:00PM +0100, Paolo Bonzini wrote:
> >> On 23/11/2017 17:05, Christoffer Dall wrote:
> >>> For example,
> >>> arm64 is about to do significant work in vcpu load/put when running a
> >>> vcpu, but not when doing things like KVM_SET_ONE_REG or
> >>> KVM_SET_MP_STATE.
> >>
> >> Out of curiosity, in what circumstances are these ioctls a hot path?
> >> Especially KVM_SET_MP_STATE.
> >>
> > 
> > Perhaps my commit message was misleading; we only want to do that for
> > KVM_RUN, and not for anything else.  We're already doing things like
> > potentially jumping to hyp mode and flushing VMIDs which really
> > shouldn't be done unless we actually plan on running a VCPU, and we're
> > going to do things like setting up the timer to handle timer interrupts
> > in an ISR, which doesn't make sense unless the VCPU is running.
> > 
> > Add to that, that loading an entire VM's state onto hardware, only to
> > read back a single register from hardware and returning it to user
> > space, doesn't really fall within optimization vs. non-optimization in
> > the critical path, but is just wrong, IMHO.
> > 
> >>> Hi all,
> >>>
> >>> Drew suggested this as an alternative approach to recording the ioctl
> >>> number on the vcpu struct [1] as it may benefit other architectures in
> >>> general.
> >>>
> >>> I had a look at some of the specific ioctls across architectures, but
> >>> must admit that I can't easily tell which architecture specific logic
> >>> relies on having registered preempt notifiers and having called the
> >>> architecture specific load function.
> >>>
> >>> It would be great if you would let me know if you think this is
> >>> generally useful or if you prefer the less invasive approach, and in
> >>> case this is useful, if you could have a look at all the vcpu ioctls for
> >>> your architecture and let me know if I am being too loose or too
> >>> careful in calling __vcpu_load() in this patch.
> >>
> >> I can suggest a third approach:
> >>
> >>         if (ioctl == KVM_GET_ONE_REG || ioctl == KVM_SET_ONE_REG)
> >>                 return kvm_arch_vcpu_ioctl(filp, ioctl, arg);
> >>
> >> in kvm_vcpu_ioctl before "r = vcpu_load(vcpu);", or even better:
> >>
> >>         if (ioctl == KVM_GET_ONE_REG)
> >> 		// call kvm_arch_vcpu_get_one_reg_ioctl(vcpu, &reg);
> >> 		// and do copy_to_user
> >> 		return kvm_vcpu_get_one_reg_ioctl(vcpu, arg);
> >>         if (ioctl == KVM_SET_ONE_REG)
> >> 		// do copy_from_user then call
> >> 		// kvm_arch_vcpu_set_one_reg_ioctl(vcpu, &reg);
> >> 		return kvm_vcpu_set_one_reg_ioctl(vcpu, arg);
> >>
> >> so that the kvm_arch_vcpu_get/set_one_reg_ioctl functions are called
> >> without the lock.
> >>
> >> Then all architectures except ARM can be switched to do
> >> vcpu_load/vcpu_put in kvm_arch_vcpu_get/set_one_reg_ioctl
> > 
> > That doesn't solve my need as I want to *only* do the arch vcpu_load for
> > KVM_RUN, I should have been more clear in the commit message.
> 
> What about splitting arch_vcpu_load/put into two callbacks and call the 2nd
> one only for VCPU_run? e.g. keep arch_vcpu_load and add arch_vcpu_load_run
> and arch_vcpu_unload_run
> 
> Then every architecture can move things from arch_vcpu_load into arch_vcpu_load_run
> if its only necessary for RUN.
> 
Unfortunately that doesn't work because the preempt notifiers don't know
which of the two functions they should call.

Thanks,
-Christoffer
