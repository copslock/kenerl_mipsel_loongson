Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Apr 2016 03:40:51 +0200 (CEST)
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33275 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027286AbcDVBktDS5N3 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Apr 2016 03:40:49 +0200
Received: by mail-oi0-f68.google.com with SMTP id f63so12568107oig.0
        for <linux-mips@linux-mips.org>; Thu, 21 Apr 2016 18:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=pBdfQx83JWWoY0ofU7tITE1uPOFgMpbOGeEQsus4tK8=;
        b=LXVUsxrycLm3PII2GGje3qFqegHOugh0dtHfZlqPjXVih46v04PIvxclJUfvuEN8zI
         wuIrdKu6A+CswRDgBRnfh9kJdbMgq2qpLhWHFAS0O9O2sG0j6gakX+2g7CPQnqdTumvw
         IHPzLFIMjm1z/Z3VtyLiCwxtOj/SJRTAM7VAHf9ilY4dHsObc76Zm0t6WFAwocs/9Dh4
         qI9tUFmdEBW6Rl9v1h0iy56R/YmN2JDugSuHVozD/X+1OfcrazVO3yURm5Oe2Uo+Rf7q
         Oo1WlnbuHT2vv90fDB9juVkdIC0KsGDh9dux2fZGvnR9+vMexINEIPJ8tq+zqVRao+i8
         GcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=pBdfQx83JWWoY0ofU7tITE1uPOFgMpbOGeEQsus4tK8=;
        b=eG41351tEj2itcxyISkG+zRMcCeHBfmR05GwOjes5sGpy31uEEhJq9CEM9JcUVWo8m
         PlW+O6WPdDsIPm0XeqyBTQ6cjWFLhIoOw90SNiZhAiuEo3nZ+z1ndrsdnrzJylc3R7Er
         QrHrB2tKQwW3qExcAFYCuh3pEWgEeihhgvCPFtnzIvpn6kf+axdumtEWPkLMS/DGcsKk
         pdvutOgHyK6G77/DEaOw+s+xKavc1x8i6s28TGxnmONEEj5mtzC4DvaBTk3EkcVA922N
         rIrX9JK+O+dnMbHcyx2pS3fUSnQvKQBNdAmVnQyL4s7otSYMq3ihFNpJe3AV/1SBaZ9b
         cuiA==
X-Gm-Message-State: AOPr4FUO4qEbvk/hX+EwVNnlO2aa2LLdnldot/XVWWkyxVm8FCio3VALsBjLw/kBnQf4YomKsWGWj6NPkiKORw==
MIME-Version: 1.0
X-Received: by 10.157.27.180 with SMTP id z49mr7024385otd.61.1461289243102;
 Thu, 21 Apr 2016 18:40:43 -0700 (PDT)
Received: by 10.157.44.130 with HTTP; Thu, 21 Apr 2016 18:40:43 -0700 (PDT)
In-Reply-To: <20160421152916.GA30356@potion>
References: <146116689259.20666.15860134511726195550.stgit@bahia.huguette.org>
        <20160420182909.GB4044@potion>
        <20160421132958.0e9292d5@bahia.huguette.org>
        <20160421152916.GA30356@potion>
Date:   Fri, 22 Apr 2016 09:40:43 +0800
Message-ID: <CANRm+Cwh__btdC4e4t+jYqHsafL6xff6t4eukxT=EmwVLYvrMA@mail.gmail.com>
Subject: Re: [PATCH v3] KVM: remove buggy vcpu id check on vcpu creation
From:   Wanpeng Li <kernellwp@gmail.com>
To:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     Greg Kurz <gkurz@linux.vnet.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, james.hogan@imgtec.com,
        Ingo Molnar <mingo@redhat.com>, linux-mips@linux-mips.org,
        kvm <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        qemu-ppc@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <kernellwp@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53188
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kernellwp@gmail.com
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

2016-04-21 23:29 GMT+08:00 Radim Krčmář <rkrcmar@redhat.com>:
> 2016-04-21 13:29+0200, Greg Kurz:
>> On Wed, 20 Apr 2016 20:29:09 +0200
>> Radim Krčmář <rkrcmar@redhat.com> wrote:
>>> 2016-04-20 17:44+0200, Greg Kurz:
>>> > Commit 338c7dbadd26 ("KVM: Improve create VCPU parameter (CVE-2013-4587)")
>>> > introduced a check to prevent potential kernel memory corruption in case
>>> > the vcpu id is too great.
>>> >
>>> > Unfortunately this check assumes vcpu ids grow in sequence with a common
>>> > difference of 1, which is wrong: archs are free to use vcpu id as they fit.
>>> > For example, QEMU originated vcpu ids for PowerPC cpus running in boot3s_hv
>>> > mode, can grow with a common difference of 2, 4 or 8: if KVM_MAX_VCPUS is
>>> > 1024, guests may be limited down to 128 vcpus on POWER8.
>>> >
>>> > This means the check does not belong here and should be moved to some arch
>>> > specific function: kvm_arch_vcpu_create() looks like a good candidate.
>>> >
>>> > ARM and s390 already have such a check.
>>> >
>>> > I could not spot any path in the PowerPC or common KVM code where a vcpu
>>> > id is used as described in the above commit: I believe PowerPC can live
>>> > without this check.
>>>
>>> The only problematic path I see is kvm_get_vcpu_by_id(), which returns
>>> NULL for any id above KVM_MAX_VCPUS.
>>
>> Oops my bad, I started to work on a 4.4 tree and I missed this check brought
>> by commit c896939f7cff (KVM: use heuristic for fast VCPU lookup by id).
>>
>> But again, I believe the check is wrong there also: the changelog just mentions
>> this is a fastpath for the usual case where "VCPU ids match the array index"...
>> why does the patch add a NULL return path if id >= KVM_MAX_VCPUS ?
>
> (The patch had to check id >= KVM_MAX_VCPUS for sanity and there could
>  not be a VCPU with that index according to the spec, so it made a
>  shortcut to the correct NULL result ...)
>
>>> Second issue is that Documentation/virtual/kvm/api.txt says
>>>   4.7 KVM_CREATE_VCPU
>>>   [...]
>>>   This API adds a vcpu to a virtual machine.  The vcpu id is a small
>>>   integer in the range [0, max_vcpus).
>>>
>>
>> Yeah and I find the meaning of max_vcpus is unclear.
>>
>> Here it is considered as a limit for vcpu id, but if you look at the code,
>> KVM_MAX_VCPUS is also used as a limit for the number of vcpus:
>>
>> virt/kvm/kvm_main.c:    if (atomic_read(&kvm->online_vcpus) == KVM_MAX_VCPUS) {
>
> I agree.  Naming of KVM_CAP_NR_VCPUS and KVM_CAP_MAX_VCPUS would make
> you think that online_vcpus limit interpretation is the correct one, but
> the code is conflicted.
>
>>> so we'd remove those two lines and change the API too.  The change would
>>> be somewhat backward compatible, but doesn't PowerPC use high vcpu_id
>>> just because KVM is lacking an API to set DT ID?
>>
>> This is related to a limitation when running in book3s_hv mode with cpus
>> that support SMT (multiple HW threads): all HW threads within a core
>> cannot be running in different guests at the same time.
>>
>> We solve this by using a vcpu numbering scheme as follows:
>>
>> vcpu_id[N] = (N * thread_per_core_guest) / threads_per_core_host + N % threads_per_core_guest
>>
>> where N means "the Nth vcpu presented to the guest". This allows to have groups of vcpus
>> that can be scheduled to run on the same real core.
>>
>> So, in the "worst" case where we want to run a guest with 1 thread/core and the host
>> has 8 threads/core, we will need the vcpu_id limit to be 8*KVM_MAX_VCPUS.
>
> I see, thanks.  Accommodating existing users seems like an acceptable
> excuse to change the API.
>
>>> x86 (APIC ID) is affected by this and ARM (MP ID) probably too.
>>>
>>
>> x86 is limited to KVM_MAX_VCPUS (== 255) vcpus: it won't be affected if we also
>> patch kvm_get_vcpu_by_id() like suggested above.
>
> x86 vcpu_id encodes APIC ID and APIC ID encodes CPU topology by
> reserving blocks of bits for socket/core/thread, so if core or thread
> count isn't a power of two, then the set of valid APIC IDs is sparse,

             ^^^^^^^^^^^^^^^^^^^
             ^^^^^^^
Is this the root reason why recommand max vCPUs per vm is 160 and the
KVM_MAX_VCPUS is 255 instead of due to perforamnce concern?

Regards,
Wanpeng Li

> but max id is still limited by 255, so the effective maximum VCPU count
> is lower.
