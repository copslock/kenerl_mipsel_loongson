Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 18:34:25 +0100 (CET)
Received: from mail-pl0-x242.google.com ([IPv6:2607:f8b0:400e:c01::242]:43323
        "EHLO mail-pl0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991957AbdK2ReSedMxV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Nov 2017 18:34:18 +0100
Received: by mail-pl0-x242.google.com with SMTP id x4so2527947plv.10
        for <linux-mips@linux-mips.org>; Wed, 29 Nov 2017 09:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HrnmsnTwUM+OnPETEucycdpO75gVjt+URfcFOiA5/Nw=;
        b=GWqd67FTZ/4FUSVLzQzbMATQZqXWLE9KkCgk2vUlQNhZnyQEcfRmoWN8M5y+bJ39CH
         5iUPJ5yMlzsahIPvEpZyNnUHJ+9AVFj+KXC8EdrEMO1jWcw/g/NiDmpnR96yb5AnIBLj
         bNo5eZZc3RxQp3nCf/BhTTKVp8ouuzkYZv9Og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HrnmsnTwUM+OnPETEucycdpO75gVjt+URfcFOiA5/Nw=;
        b=uNpYlnGALcTNeHIYUrZraUUfFAjr6LGFiehMz2nXZcVGzUxYDJmQstcgJQPjMarDfd
         murvZU9feI60yZUKphM1QuhTU9HjPU89X0ZJn/xFzotvnBC09cHVnzdqWVEajZfmhJaV
         CyCboIDkjT0bDF3yZyxONpTc8goxp5URv4MbZUQxzAPv+yPMcjsHz6FIEBkOBvTz1QCd
         BcDcXgxonL+VrEELwWmMV64y0FJcKdpuOEvyRJ7moujuRhvMHQLCSW28bEzkAncRgTf5
         SeX30b6tf6XfgnsYLEZKOuoh+XHf7eLqZzlJP4iclSNGEA7ONdRaF+QopV3beL4EqaQF
         UAnA==
X-Gm-Message-State: AJaThX72B0dpWU974ZJT5g45hhiTtOvVvP0DE0cKZXtFWKx00UyH/jCE
        x7C/euQAtru3ged7zA1NFoLRx3ASNPeoKB0Jvs7oUw==
X-Google-Smtp-Source: AGs4zMY6kwD0+JOINFJPnoQnM3cGFDAvLIWd1clPlb7uuxd51MSzv34qtFqccXB0yJPL2c/aecVwj1NyYCGWssXNycI=
X-Received: by 10.84.195.228 with SMTP id j91mr3579865pld.120.1511976849369;
 Wed, 29 Nov 2017 09:34:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.241.6 with HTTP; Wed, 29 Nov 2017 09:34:08 -0800 (PST)
In-Reply-To: <12137903-6f11-6350-6344-30e3bc6542e3@redhat.com>
References: <20171129164116.16167-1-christoffer.dall@linaro.org>
 <20171129164116.16167-16-christoffer.dall@linaro.org> <12137903-6f11-6350-6344-30e3bc6542e3@redhat.com>
From:   Christoffer Dall <christoffer.dall@linaro.org>
Date:   Wed, 29 Nov 2017 17:34:08 +0000
Message-ID: <CAMJs5B-JWrHrCyO6zNC8z34uiMrhNk6RaQCTKRB27Mki+XhpFg@mail.gmail.com>
Subject: Re: [PATCH v2 15/16] KVM: arm/arm64: Avoid vcpu_load for other vcpu
 ioctls than KVM_RUN
To:     David Hildenbrand <david@redhat.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Alexander Graf <agraf@suse.com>,
        kvm-ppc <kvm-ppc@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <christoffer.dall@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61215
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

On Wed, Nov 29, 2017 at 5:30 PM, David Hildenbrand <david@redhat.com> wrote:
>
>> +++ b/virt/kvm/arm/arm.c
>> @@ -381,14 +381,11 @@ static void vcpu_power_off(struct kvm_vcpu *vcpu)
>>  int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
>>                                   struct kvm_mp_state *mp_state)
>>  {
>> -     vcpu_load(vcpu);
>> -
>>       if (vcpu->arch.power_off)
>>               mp_state->mp_state = KVM_MP_STATE_STOPPED;
>>       else
>>               mp_state->mp_state = KVM_MP_STATE_RUNNABLE;
>>
>> -     vcpu_put(vcpu);
>>       return 0;
>>  }
>
> Okay, this also makes sense on other architectures. The important thing
> is only that we hold the vcpu mutex.
>
Yes, but as Paolo said, it's better if architecture maintainers do
that themselves.  The risk of me messing things up is way too high
otherwise.

Thanks,
-Christoffer
