Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Jun 2014 01:47:41 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:21360 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860058AbaF0Xr34Kmoj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Jun 2014 01:47:29 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8B0BBD18600CB;
        Sat, 28 Jun 2014 00:47:18 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Sat, 28 Jun
 2014 00:47:22 +0100
Received: from BAMAIL02.ba.imgtec.org (192.168.66.28) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Sat, 28 Jun 2014 00:47:22 +0100
Received: from [10.20.2.221] (10.20.2.221) by bamail02.ba.imgtec.org
 (192.168.66.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Fri, 27 Jun
 2014 16:47:20 -0700
Message-ID: <53AE0288.6000905@imgtec.com>
Date:   Fri, 27 Jun 2014 16:47:20 -0700
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Paolo Bonzini <pbonzini@redhat.com>,
        James Hogan <james.hogan@imgtec.com>
CC:     <gleb@kernel.org>, <kvm@vger.kernel.org>, <sanjayl@kymasys.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v3 7/9] MIPS: KVM: Fix memory leak on VCPU
References: <1403631071-6012-1-git-send-email-dengcheng.zhu@imgtec.com> <1403631071-6012-8-git-send-email-dengcheng.zhu@imgtec.com> <53AA9625.8020802@imgtec.com> <53AABDE9.3050907@redhat.com>
In-Reply-To: <53AABDE9.3050907@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.2.221]
Return-Path: <DengCheng.Zhu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@imgtec.com
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

Hi Paolo,


On 06/25/2014 05:17 AM, Paolo Bonzini wrote:
> Il 25/06/2014 11:28, James Hogan ha scritto:
>> On 24/06/14 18:31, Deng-Cheng Zhu wrote:
>>> From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
>>>
>>> kvm_arch_vcpu_free() is called in 2 code paths:
>>>
>>> 1) kvm_vm_ioctl()
>>>        kvm_vm_ioctl_create_vcpu()
>>>            kvm_arch_vcpu_destroy()
>>>                kvm_arch_vcpu_free()
>>> 2) kvm_put_kvm()
>>>        kvm_destroy_vm()
>>>            kvm_arch_destroy_vm()
>>>                kvm_mips_free_vcpus()
>>>                    kvm_arch_vcpu_free()
>>>
>>> Neither of the paths handles VCPU free. We need to do it in
>>> kvm_arch_vcpu_free() corresponding to the memory allocation in
>>> kvm_arch_vcpu_create().
>>>
>>> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
>>
>> Reviewed-by: James Hogan <james.hogan@imgtec.com>
>>
>> Maybe worth adding "Cc: stable@vger.kernel.org" and moving this to the
>> beginning of the patchset to avoid conflicts.
>>
>> Cheers
>> James
>>
>
> I've queued this for 3.16.  It applies cleanly apart for the filename change.

Maybe you forgot to put this on the branch "queue"? I don't see it. Thanks.


Deng-Cheng
