Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Nov 2017 20:58:35 +0100 (CET)
Received: from mail-wm0-x244.google.com ([IPv6:2a00:1450:400c:c09::244]:34467
        "EHLO mail-wm0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990451AbdK0T62PstnE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Nov 2017 20:58:28 +0100
Received: by mail-wm0-x244.google.com with SMTP id y82so29336272wmg.1
        for <linux-mips@linux-mips.org>; Mon, 27 Nov 2017 11:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=drii4VC21cYSgewg27i8aG5wvuWZeKM6WM9XjJ9wyck=;
        b=a81zEZHOj113jHMGrmVn2CFZFitzWPxVcbQunJwmVQk8wns3VFgrzKN6M9ngQy7tGi
         E5Um6IlCgXgfEboupI0gtwCv+6r+ntEymIpsGSrZpnYNCGI+G5TYvivqNzSCMs7chH7p
         kfU1U9Wf4ysXxwWEURFZ0xJlKKAvqDmh1ubb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=drii4VC21cYSgewg27i8aG5wvuWZeKM6WM9XjJ9wyck=;
        b=NApcl5XyYnivdPosQF02nYg2RjsxEaFeKzuKCDgPUDzsz8T1OKKLvw82DDFjZoGW7/
         TXh2dRjIOEJ5ABxeJaV4Ni/n1llpSaQYtwW+wikyzx4KqcP4gLqVwyaQhNdleEgXG2al
         r0nV00VPKQCusUoDaq2y8J+AWYDb3Ir7ebi23RcQVvS26cJz9tYHPQgbdzbUpSNgZ2VV
         AhGJdahtb5NXm5saqBHJ4cse2Za0yIzHEyCa5yzbYoWCEX+6iQYbAufP3ilPy/MnF+gc
         uAXdBBn9avKpsLFL9qgmteCnnVNcEsl5ff2NqY72qFlriiEAeUyr2bl7W3j45+A56yXg
         36xg==
X-Gm-Message-State: AJaThX6ZwoFCV5ktdLjnGT2zmrRrbqiMwEsKbXVyAgcvNSAm1y+xoAgd
        THlN6Rktm2PLJ5xGxS/vQ4qDaA==
X-Google-Smtp-Source: AGs4zMZNCCoIg4dbQKFFCJX4UfRMF6nypn1ewCxD0pcDqcDC/c0bsuRJ+bszYmbhumUMtPqNauJa7Q==
X-Received: by 10.28.198.75 with SMTP id w72mr17561063wmf.2.1511812702727;
        Mon, 27 Nov 2017 11:58:22 -0800 (PST)
Received: from localhost (x50d2404e.cust.hiper.dk. [80.210.64.78])
        by smtp.gmail.com with ESMTPSA id j13sm4229371wre.55.2017.11.27.11.58.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Nov 2017 11:58:21 -0800 (PST)
Date:   Mon, 27 Nov 2017 20:58:30 +0100
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
Subject: Re: [PATCH 01/15] KVM: Prepare for moving vcpu_load/vcpu_put into
 arch specific code
Message-ID: <20171127195830.GB16941@cbox>
References: <20171125205718.7731-1-christoffer.dall@linaro.org>
 <20171125205718.7731-2-christoffer.dall@linaro.org>
 <838db374-6040-c805-82f3-187a2cdfc40d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <838db374-6040-c805-82f3-187a2cdfc40d@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61107
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

On Mon, Nov 27, 2017 at 05:53:01PM +0100, Paolo Bonzini wrote:
> On 25/11/2017 21:57, Christoffer Dall wrote:
> > In preparation for moving calls to vcpu_load() and vcpu_put() into the
> > architecture specific implementations of the KVM vcpu ioctls, move the
> > calls in the main kvm_vcpu_ioctl() dispatcher function to each case
> > of the ioctl select statement.  This allows us to move the vcpu_load()
> > and vcpu_put() calls into architecture specific implementations of vcpu
> > ioctls, one by one.
> > 
> > Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> > ---
> >  virt/kvm/kvm_main.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 48 insertions(+), 5 deletions(-)
> > 
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 9deb5a245b83..fafafcc38b5a 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -2528,16 +2528,15 @@ static long kvm_vcpu_ioctl(struct file *filp,
> >  		return kvm_arch_vcpu_ioctl(filp, ioctl, arg);
> >  #endif
> >  
> > -
> > -	r = vcpu_load(vcpu);
> > -	if (r)
> > -		return r;
> >  	switch (ioctl) {
> >  	case KVM_RUN: {
> >  		struct pid *oldpid;
> >  		r = -EINVAL;
> >  		if (arg)
> >  			goto out;
> > +		r = vcpu_load(vcpu);
> > +		if (r)
> > +			goto out;
> >  		oldpid = rcu_access_pointer(vcpu->pid);
> 
> If it is not a problem for ARM, maybe it would actually be best to leave
> the locking in kvm_vcpu_ioctl (with the already existing exception of
> KVM_INTERRUPT).  This would make vcpu_load void, and would also let you
> keep the PID adjustment in common code.  This would be more similar to
> the previous version, but without introducing __vcpu_load/__vcpu_put.

Yes, that's not a problem for ARM, and it was actually what I started
out with, and you can see the result here (rebased on v4.15-rc1):

git://git.kernel.org/pub/scm/linux/kernel/git/cdall/linux.git vcpu-load-put-keeplock

I got a bit into getting rid of the (IMHO) ugly ifdef-shortcut
dispatcher code, and thus reworked it to the submitted version.

Going back and looking, it's nicer to avoid the pid adjustment call, and
having vcpu_load be void is also convenient, but we're stuck with the
ifdef.  I guess I lean towards your suggestion as well, given that my
problem with the ifdef is not a technical one, but an aesthetic one.

> 
> Looks good apart from this doubt!  Thanks,
> 
Let me know if you want to have a quick glance at the branch above and
prefer that I send that as v2.

Thanks,
-Christoffer
