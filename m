Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 18:35:38 +0100 (CET)
Received: from mail-pg0-x242.google.com ([IPv6:2607:f8b0:400e:c05::242]:42869
        "EHLO mail-pg0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992036AbdK2RfZlfV1V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Nov 2017 18:35:25 +0100
Received: by mail-pg0-x242.google.com with SMTP id e14so1791212pgr.9
        for <linux-mips@linux-mips.org>; Wed, 29 Nov 2017 09:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=u+Zl8aUd7ZiL7VT1NHATrRqYm86YaspodFN/+Z+E1Sw=;
        b=e4Yp7ejgTPX17b35f0Fuzi6aY+qHXHf7DTHYpD4pW+pJatE9I97W8vMyP/ZeUgHU5s
         +nPnkjwXNimaNZTyUZvvJPRuaR5wig0M/+0Zjx+wJQGMYfNQRPJq0QPtoMIpxW1cxLqt
         8Mbz/aHRO4wsLYy7aXNAjPh2lan0oAfBzUc+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=u+Zl8aUd7ZiL7VT1NHATrRqYm86YaspodFN/+Z+E1Sw=;
        b=tuuMaXsx0IHESPjY2nqJ9Mudz42vdWqcyhyWhyFYaHpJFaCqfJQ4xOboYYsLS3ZrsC
         TXWpQGKfYboPozAhcX9J6TyrXMkbHiA/FgoUGmzDooZ8fT9K/5E9dheieXKVdcw5zN3Z
         rHXfP+VFPt+z6voJn36XEw2dAVuTMmI14m+/CfXGbKwUnZvyJMdNoxw11T69M1wg+ArC
         uqQIrQ1xfFh1onKCSOBR2a09P5uE/Ko8XKv2Y67tPJmm5D4EYp36udx78vGjnCBk8UKD
         7X0pQRMhWgbVkblYSAQvmtYEVh4eg6sbVIsMyI9s329iFGx8LNQF2CcMju8foDhpfhMr
         qhHw==
X-Gm-Message-State: AJaThX5tSynr0bgiHdOFBMhiXoTYCkh50bvymzQwlu5vc7kD7/5zJDBM
        SyEq9j2ts7CCM8lGsYZ8Zwkptb4u7xdRhDMvgQRECA==
X-Google-Smtp-Source: AGs4zMa6y1U7vO/1bDi1i2Cz/ndpC0ksxRfhaBL3W9T3yxrT9VE8/IEnH8BRyM2/05SF+99koby9JChj8Fp9EJXlzHk=
X-Received: by 10.98.213.71 with SMTP id d68mr3634671pfg.171.1511976917165;
 Wed, 29 Nov 2017 09:35:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.241.6 with HTTP; Wed, 29 Nov 2017 09:35:16 -0800 (PST)
In-Reply-To: <51b1bb38-7fa8-d785-3281-5a239639989e@redhat.com>
References: <20171129164116.16167-1-christoffer.dall@linaro.org>
 <20171129164116.16167-2-christoffer.dall@linaro.org> <25c1daca-1d8b-48e7-af2d-5cf47d0d278b@redhat.com>
 <1cf0f391-960c-a457-29e5-f31ee410a9d1@redhat.com> <51b1bb38-7fa8-d785-3281-5a239639989e@redhat.com>
From:   Christoffer Dall <christoffer.dall@linaro.org>
Date:   Wed, 29 Nov 2017 17:35:16 +0000
Message-ID: <CAMJs5B_sYAQDF6Z3tDD4u8S3gJWns+gR1CE_hrcD83L_wmpEwQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/16] KVM: Take vcpu->mutex outside vcpu_load
To:     David Hildenbrand <david@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Andrew Jones <drjones@redhat.com>,
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
X-archive-position: 61216
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

On Wed, Nov 29, 2017 at 5:22 PM, David Hildenbrand <david@redhat.com> wrote:
> On 29.11.2017 18:20, Paolo Bonzini wrote:
>> On 29/11/2017 18:17, David Hildenbrand wrote:
>>> On 29.11.2017 17:41, Christoffer Dall wrote:
>>>> As we're about to call vcpu_load() from architecture-specific
>>>> implementations of the KVM vcpu ioctls, but yet we access data
>>>> structures protected by the vcpu->mutex in the generic code, factor
>>>> this logic out from vcpu_load().
>>>>
>>>> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
>>>> ---
>>>>  arch/x86/kvm/vmx.c       |  4 +---
>>>>  arch/x86/kvm/x86.c       | 20 +++++++-------------
>>>>  include/linux/kvm_host.h |  2 +-
>>>>  virt/kvm/kvm_main.c      | 17 ++++++-----------
>>>>  4 files changed, 15 insertions(+), 28 deletions(-)
>>>>
>>>> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
>>>> index 714a067..e7c46d2 100644
>>>> --- a/arch/x86/kvm/vmx.c
>>>> +++ b/arch/x86/kvm/vmx.c
>>>> @@ -9559,10 +9559,8 @@ static void vmx_switch_vmcs(struct kvm_vcpu *vcpu, struct loaded_vmcs *vmcs)
>>>>  static void vmx_free_vcpu_nested(struct kvm_vcpu *vcpu)
>>>>  {
>>>>         struct vcpu_vmx *vmx = to_vmx(vcpu);
>>>> -       int r;
>>>>
>>>> -       r = vcpu_load(vcpu);
>>>> -       BUG_ON(r);
>>>> +       vcpu_load(vcpu);
>>> I am most likely missing something, why don't we have to take the lock
>>> in these cases?
>>
>> See earlier discussion, at these points there can be no concurrent
>> access; the file descriptor is not accessible yet, or is already gone.
>>
>> Paolo
>
> Thanks, this belongs into the patch description then.
>
Fair enough, I'll add that.

Thanks for having a look.

-Christoffer
