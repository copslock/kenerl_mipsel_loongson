Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2014 14:18:21 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:12064 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6859805AbaFYMSLID8m- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Jun 2014 14:18:11 +0200
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5PCHpYD010099
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jun 2014 08:17:51 -0400
Received: from yakj.usersys.redhat.com (ovpn-112-16.ams2.redhat.com [10.36.112.16])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s5PCHjMf020814;
        Wed, 25 Jun 2014 08:17:46 -0400
Message-ID: <53AABDE9.3050907@redhat.com>
Date:   Wed, 25 Jun 2014 14:17:45 +0200
From:   Paolo Bonzini <pbonzini@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>,
        Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
CC:     gleb@kernel.org, kvm@vger.kernel.org, sanjayl@kymasys.com,
        ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v3 7/9] MIPS: KVM: Fix memory leak on VCPU
References: <1403631071-6012-1-git-send-email-dengcheng.zhu@imgtec.com> <1403631071-6012-8-git-send-email-dengcheng.zhu@imgtec.com> <53AA9625.8020802@imgtec.com>
In-Reply-To: <53AA9625.8020802@imgtec.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pbonzini@redhat.com
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

Il 25/06/2014 11:28, James Hogan ha scritto:
> On 24/06/14 18:31, Deng-Cheng Zhu wrote:
>> From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
>>
>> kvm_arch_vcpu_free() is called in 2 code paths:
>>
>> 1) kvm_vm_ioctl()
>>        kvm_vm_ioctl_create_vcpu()
>>            kvm_arch_vcpu_destroy()
>>                kvm_arch_vcpu_free()
>> 2) kvm_put_kvm()
>>        kvm_destroy_vm()
>>            kvm_arch_destroy_vm()
>>                kvm_mips_free_vcpus()
>>                    kvm_arch_vcpu_free()
>>
>> Neither of the paths handles VCPU free. We need to do it in
>> kvm_arch_vcpu_free() corresponding to the memory allocation in
>> kvm_arch_vcpu_create().
>>
>> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
>
> Reviewed-by: James Hogan <james.hogan@imgtec.com>
>
> Maybe worth adding "Cc: stable@vger.kernel.org" and moving this to the
> beginning of the patchset to avoid conflicts.
>
> Cheers
> James
>

I've queued this for 3.16.  It applies cleanly apart for the filename 
change.

Paolo
