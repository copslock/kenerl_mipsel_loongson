Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Nov 2017 18:48:07 +0100 (CET)
Received: from mail-wr0-x243.google.com ([IPv6:2a00:1450:400c:c0c::243]:33489
        "EHLO mail-wr0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990511AbdKWRsAICLTE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Nov 2017 18:48:00 +0100
Received: by mail-wr0-x243.google.com with SMTP id 55so1948808wrx.0
        for <linux-mips@linux-mips.org>; Thu, 23 Nov 2017 09:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2YGeESZvOVjx4HxGosjKc+mcj1JMQc9Q5pTgX2DcB1Y=;
        b=fegAWYgmXB1SdhmT1U8K4oR4ejAxYdUDXKuKnu0M572YCMWGIgjbdTRzgQI/OYC2qB
         gBcbgMmD3sgIGTs8xzLCHdmDZF0+HU3izQXFoW4PkZEFyHYYAc5ORfPDr6JK0krm5xVl
         hBzXGuIC/pO7+XJ0iiMmdg3CyFe/eqkREb8BM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2YGeESZvOVjx4HxGosjKc+mcj1JMQc9Q5pTgX2DcB1Y=;
        b=ZO5k6pg3kIFd+B4yC96/DON0wP7AsMIniEcwIBIivMlMUlNotchp/2JECi4tsh0Z5+
         4yEeLLUR8IJi9OKFlOrKdkzVQYZGy5bVcc+rLuayOeYsNU5Qk7cfq4XhZL1k3gz5fwpV
         HnQmTtXgykWfMto+7vRgkxutAIqXSWIZn+5AQmYpqUeSSG45WcPXOhHC2iiANnew1DF/
         t0BlrxIiN9MjhwU55T/RZS8CuEy4jC/rrhdQFOdzeG6gPxP/8NP25BYnEPSaeyBwi29y
         yc24TJzV23xvNoGXKI/XUzcz77a6OQkeuPY5n9+lNyEZPgZ/uCfFR8d+uR/jOp8abJlh
         tgZg==
X-Gm-Message-State: AJaThX6spbycJuvKv99RoEjCs11TZTKA4LIj5l9opLyT1cbFo+1YVJ0V
        0MdIPIb/tl2J5i9YuamHLzUA0A==
X-Google-Smtp-Source: AGs4zMaCEL7tqDCi3bKKgBw7dki04nLWLAC0Vsni+N0dmqqXFCfaIDp6KhsRllbvpSs1u6y3GGxs1Q==
X-Received: by 10.223.150.175 with SMTP id u44mr20719217wrb.115.1511459273857;
        Thu, 23 Nov 2017 09:47:53 -0800 (PST)
Received: from localhost (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id u194sm5569909wmd.6.2017.11.23.09.47.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Nov 2017 09:47:52 -0800 (PST)
Date:   Thu, 23 Nov 2017 18:48:04 +0100
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
Message-ID: <20171123174804.GB28855@cbox>
References: <20171123160521.27260-1-christoffer.dall@linaro.org>
 <72357599-798d-14d0-336a-69a083f17863@redhat.com>
 <20171123170642.GA28855@cbox>
 <62ae4eb1-fd57-c525-cd73-e3f646d340e1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62ae4eb1-fd57-c525-cd73-e3f646d340e1@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61064
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

On Thu, Nov 23, 2017 at 06:12:41PM +0100, Paolo Bonzini wrote:
> On 23/11/2017 18:06, Christoffer Dall wrote:
> > On Thu, Nov 23, 2017 at 05:17:00PM +0100, Paolo Bonzini wrote:
> >> On 23/11/2017 17:05, Christoffer Dall wrote:
> >>> For example,
> >>> arm64 is about to do significant work in vcpu load/put when running a
> >>> vcpu, but not when doing things like KVM_SET_ONE_REG or
> >>> KVM_SET_MP_STATE.
> >>
> >> Out of curiosity, in what circumstances are these ioctls a hot path?
> >> Especially KVM_SET_MP_STATE.
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
> 
> For GET/SET_ONE_REG it certainly makes sense.  For everything else, I'm
> wondering which ioctls (and how many calls to each of them) exactly you
> are seeing, and also on which userspace paths.
> 

Outside of migration, not many.  It's not about optimizing certain
ioctl's, but rather that I think it's wrong and potentially vulnerable
to do significant work on the system which is strictly unnecessary.

> > That doesn't solve my need as I want to *only* do the arch vcpu_load for
> > KVM_RUN, I should have been more clear in the commit message.
> 
> That's what you want to do, but it might not be what you need to do.
> 

Well, why would we want to do a lot of work when there's absolutely no
need to?

I see that this patch is invasive, and that's why I originally proposed
the other approach of recording the ioctl number.

While it may be possible to call kvm_arch_vcpu_load() for a number of
non-KVM_RUN ioctls, it makes the KVM/ARM code more difficult to reason
about, especially after my optimization series, because a lot of things
can now happen, where we have to consider if we're really in the process
of running a vcpu or not.

Thanks,
-Christoffer
