Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2017 12:01:25 +0200 (CEST)
Received: from mail-wm0-x236.google.com ([IPv6:2a00:1450:400c:c09::236]:36249
        "EHLO mail-wm0-x236.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994922AbdH2KBEgajaB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Aug 2017 12:01:04 +0200
Received: by mail-wm0-x236.google.com with SMTP id b82so17358417wmd.1
        for <linux-mips@linux-mips.org>; Tue, 29 Aug 2017 03:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SFbSuxyB9dGd25O152JEFwFDgZazzaIlSrZUj9vgagw=;
        b=SL/lxyB21jHUxuWVkK+Z2jwk4XntBYNnfoLVBXbpQ83eCCQqc69dFgqFoFQMtExgA6
         GTjaAL3eG+tGRVXnnEHqv2h08ipuA1K7E6n50WTzEapQhJmBAVpmh2n0M7cchzPN5ffs
         tE0M1ztw/uP2xKNUUT33iw3h+fwGKjZym5jPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SFbSuxyB9dGd25O152JEFwFDgZazzaIlSrZUj9vgagw=;
        b=qqZRwxXbixzM8i9bKvykjlSN3J3RnUlzA+9pvphl4fqmqT/W2PsU14y3ZH23Pv1tkD
         6/l+9Q+mlRs7/jG4GxcQ+PAb6p7cUAqCNX2lY9Rd/tCU6Q/o7akwULzF6rSQtoXw9w0J
         pwscV/Nm4BBJ7FNbwVc2yse7jHLQ9FSFRfo8GQQZh+/phljSl3Mgb+SKkU/W31FnxhVL
         zwN56s3wfeklQi/xeorOpnzB3WXTiXk0AsAJ5voxw+tYuzf8Qu4P2YYeepMPY5NN/ffh
         NmVE7V9W7f4SCepzzn6H31fVVQkhy/PUzRLfFbF6FrYACQoHsX9cfp8wjFKlcAF7vu2t
         smIg==
X-Gm-Message-State: AHYfb5i3g+qNz+/MOPxMaaGBiTPGMrfVDba3dEjMGcnVwW/2rRrvRtoi
        U6U92Vi8vCB6htVF
X-Received: by 10.80.151.101 with SMTP id d34mr3166820edb.83.1504000857401;
        Tue, 29 Aug 2017 03:00:57 -0700 (PDT)
Received: from localhost (xd93ddc2d.cust.hiper.dk. [217.61.220.45])
        by smtp.gmail.com with ESMTPSA id m25sm1126305edj.23.2017.08.29.03.00.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Aug 2017 03:00:56 -0700 (PDT)
Date:   Tue, 29 Aug 2017 12:00:55 +0200
From:   Christoffer Dall <cdall@linaro.org>
To:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alexander Graf <agraf@suse.com>
Subject: Re: [PATCH RFC v3 2/9] KVM: arm/arm64: fix vcpu self-detection in
 vgic_v3_dispatch_sgi()
Message-ID: <20170829100055.GV24649@cbox>
References: <20170821203530.9266-1-rkrcmar@redhat.com>
 <20170821203530.9266-3-rkrcmar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170821203530.9266-3-rkrcmar@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <cdall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59855
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

On Mon, Aug 21, 2017 at 10:35:23PM +0200, Radim Krčmář wrote:
> The index in kvm->vcpus array and vcpu->vcpu_id are very different
> things.  Comparing struct kvm_vcpu pointers is a sure way to know.
> 
> Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>

Acked-by: Christoffer Dall <cdall@linaro.org>

> ---
>  virt/kvm/arm/vgic/vgic-mmio-v3.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c b/virt/kvm/arm/vgic/vgic-mmio-v3.c
> index 408ef06638fc..9d4b69b766ec 100644
> --- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
> +++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
> @@ -797,7 +797,6 @@ void vgic_v3_dispatch_sgi(struct kvm_vcpu *vcpu, u64 reg)
>  	u16 target_cpus;
>  	u64 mpidr;
>  	int sgi, c;
> -	int vcpu_id = vcpu->vcpu_id;
>  	bool broadcast;
>  
>  	sgi = (reg & ICC_SGI1R_SGI_ID_MASK) >> ICC_SGI1R_SGI_ID_SHIFT;
> @@ -821,7 +820,7 @@ void vgic_v3_dispatch_sgi(struct kvm_vcpu *vcpu, u64 reg)
>  			break;
>  
>  		/* Don't signal the calling VCPU */
> -		if (broadcast && c == vcpu_id)
> +		if (broadcast && c_vcpu == vcpu)
>  			continue;
>  
>  		if (!broadcast) {
> -- 
> 2.13.3
> 
