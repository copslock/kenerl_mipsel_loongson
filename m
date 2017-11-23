Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Nov 2017 18:06:45 +0100 (CET)
Received: from mail-wr0-x243.google.com ([IPv6:2a00:1450:400c:c0c::243]:39599
        "EHLO mail-wr0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990511AbdKWRGi1T60r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Nov 2017 18:06:38 +0100
Received: by mail-wr0-x243.google.com with SMTP id 11so14797014wrb.6
        for <linux-mips@linux-mips.org>; Thu, 23 Nov 2017 09:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TjdwyhkoYKgqWWlOJdhe9HibW+oA9mDDqELszf5qmM8=;
        b=JRMgGVciXX0Ll7sNVXD4IQHVWhLnC8E3BOdT6vqXzWqlauvw+hSgakr0J87bmLxSkH
         Ov+CW9+RKxxctGJoldm/ET58bqgCWZZ2ASmu0huIdeVccqWouH/QoD8dXgJrPJFtdFVs
         zdsm1Fh3OWi8zr3LlPa/6YctksJCUiDWQ4g2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TjdwyhkoYKgqWWlOJdhe9HibW+oA9mDDqELszf5qmM8=;
        b=maCom74yn/U4lnWjComijniog533H2LYfnx1efKKGIzY9lxR8JBIyazAIyExFDFXVE
         +xiYzBdmW4w/rU3RW7bUTzOeJOgZn8FldhX1kbH/zMwfsrPtRQWnT/xEz7NZ7mq5q7ix
         9MMKrUZRth74DWlKRZabTRhgnFloj4BZUaPyBKCyVRhxxpzi3EMwsCDU/MsFG3pGU5RU
         SHN98m6KO9CqPpaJjtz0/FWhplN7Z4NSq2QzV4iuWn4k7J4tDx8THXRtdEbYbMbCyKZ2
         26d7NZmtEJoPHHZhghNVF29+hGdtGioiPnROGpiGGF0WB8tGW+MftqzwMnNMTcgIRYbT
         bLqg==
X-Gm-Message-State: AJaThX6JAwOV1QzHXmItMCvO3q35WKNNhm53947MM9CDYZ4XUoErMb/j
        zqOcV7qf3iEFtlVyfgrPjdDJow==
X-Google-Smtp-Source: AGs4zMabRvExQZlz/q2sNWi4qE+pB1HDrgVuQhBVOzNR9/+P/gHCywyY1EXza4o2runhVbTFj0vbSA==
X-Received: by 10.223.147.135 with SMTP id 7mr22793016wrp.237.1511456792945;
        Thu, 23 Nov 2017 09:06:32 -0800 (PST)
Received: from localhost (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id t135sm5207016wmt.24.2017.11.23.09.06.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Nov 2017 09:06:30 -0800 (PST)
Date:   Thu, 23 Nov 2017 18:06:42 +0100
From:   Christoffer Dall <cdall@linaro.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Christoffer Dall <christoffer.dall@linaro.org>,
        kvm@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
Subject: Re: [RFC PATCH] KVM: Only register preempt notifiers and load arch
 cpu state as needed
Message-ID: <20171123170642.GA28855@cbox>
References: <20171123160521.27260-1-christoffer.dall@linaro.org>
 <72357599-798d-14d0-336a-69a083f17863@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72357599-798d-14d0-336a-69a083f17863@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61062
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

On Thu, Nov 23, 2017 at 05:17:00PM +0100, Paolo Bonzini wrote:
> On 23/11/2017 17:05, Christoffer Dall wrote:
> > For example,
> > arm64 is about to do significant work in vcpu load/put when running a
> > vcpu, but not when doing things like KVM_SET_ONE_REG or
> > KVM_SET_MP_STATE.
> 
> Out of curiosity, in what circumstances are these ioctls a hot path?
> Especially KVM_SET_MP_STATE.
> 

Perhaps my commit message was misleading; we only want to do that for
KVM_RUN, and not for anything else.  We're already doing things like
potentially jumping to hyp mode and flushing VMIDs which really
shouldn't be done unless we actually plan on running a VCPU, and we're
going to do things like setting up the timer to handle timer interrupts
in an ISR, which doesn't make sense unless the VCPU is running.

Add to that, that loading an entire VM's state onto hardware, only to
read back a single register from hardware and returning it to user
space, doesn't really fall within optimization vs. non-optimization in
the critical path, but is just wrong, IMHO.

> > Hi all,
> > 
> > Drew suggested this as an alternative approach to recording the ioctl
> > number on the vcpu struct [1] as it may benefit other architectures in
> > general.
> > 
> > I had a look at some of the specific ioctls across architectures, but
> > must admit that I can't easily tell which architecture specific logic
> > relies on having registered preempt notifiers and having called the
> > architecture specific load function.
> > 
> > It would be great if you would let me know if you think this is
> > generally useful or if you prefer the less invasive approach, and in
> > case this is useful, if you could have a look at all the vcpu ioctls for
> > your architecture and let me know if I am being too loose or too
> > careful in calling __vcpu_load() in this patch.
> 
> I can suggest a third approach:
> 
>         if (ioctl == KVM_GET_ONE_REG || ioctl == KVM_SET_ONE_REG)
>                 return kvm_arch_vcpu_ioctl(filp, ioctl, arg);
> 
> in kvm_vcpu_ioctl before "r = vcpu_load(vcpu);", or even better:
> 
>         if (ioctl == KVM_GET_ONE_REG)
> 		// call kvm_arch_vcpu_get_one_reg_ioctl(vcpu, &reg);
> 		// and do copy_to_user
> 		return kvm_vcpu_get_one_reg_ioctl(vcpu, arg);
>         if (ioctl == KVM_SET_ONE_REG)
> 		// do copy_from_user then call
> 		// kvm_arch_vcpu_set_one_reg_ioctl(vcpu, &reg);
> 		return kvm_vcpu_set_one_reg_ioctl(vcpu, arg);
> 
> so that the kvm_arch_vcpu_get/set_one_reg_ioctl functions are called
> without the lock.
> 
> Then all architectures except ARM can be switched to do
> vcpu_load/vcpu_put in kvm_arch_vcpu_get/set_one_reg_ioctl

That doesn't solve my need as I want to *only* do the arch vcpu_load for
KVM_RUN, I should have been more clear in the commit message.

Thanks,
-Christoffer
