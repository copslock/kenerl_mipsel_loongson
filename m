Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 May 2013 19:07:59 +0200 (CEST)
Received: from mail-pb0-f50.google.com ([209.85.160.50]:61830 "EHLO
        mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827534Ab3E3RHyJ9qgp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 May 2013 19:07:54 +0200
Received: by mail-pb0-f50.google.com with SMTP id wy17so707253pbc.9
        for <multiple recipients>; Thu, 30 May 2013 10:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=m8kdbtFA7n1ic+3CXhsMwphrOT+RO7I0XBsEzlPCssc=;
        b=lZKxLlHOZMB/tyJpSEWRpzPhIYZP0IwosIz9k6b6I/Iy7sroz0I48cY9UrjGuy/8nk
         +RS1JwSAtVq3Bcre/ZOxie9a2c0ZoNfRLGIFsJN321j3p1Pojd1G/7Cgt+qZOQJJTFgz
         X9mwr/7lhzpvUXjBomJPWwclOx/450YY3U9fXf4dgLmSPeeG7M1mowKBEnX7lf7HXRU6
         9vSn/IA1yggGBVxp6DJ8B9UDg1gxDOFLH+7tWBwAYl0zzgJdJ1OCAOJ3XNXjwzQXTXOD
         2oJxEcwsSIqoKW6Xt8s4fTt6I700lhBD3gIRxDasUmW+EK7W/R6T4Cd6vusu0uEsAV2X
         uTiw==
X-Received: by 10.68.76.67 with SMTP id i3mr8937265pbw.20.1369933666293;
        Thu, 30 May 2013 10:07:46 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id dc3sm4381403pbc.9.2013.05.30.10.07.44
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 30 May 2013 10:07:45 -0700 (PDT)
Message-ID: <51A7875F.4080606@gmail.com>
Date:   Thu, 30 May 2013 10:07:43 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sanjay Lal <sanjayl@kymasys.com>
CC:     kvm@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 10/18] KVM/MIPS32-VZ: Add API for VZ-ASE Capability
References: <n> <1368942460-15577-1-git-send-email-sanjayl@kymasys.com> <1368942460-15577-11-git-send-email-sanjayl@kymasys.com> <51A4DC99.7040706@redhat.com>
In-Reply-To: <51A4DC99.7040706@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36645
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 05/28/2013 09:34 AM, Paolo Bonzini wrote:
> Il 19/05/2013 07:47, Sanjay Lal ha scritto:
>> - Add API to allow clients (QEMU etc.) to check whether the H/W
>>    supports the MIPS VZ-ASE.
>
> Why does this matter to userspace?  Do the userspace have some way to
> detect if the kernel is unmodified or minimally-modified?
>

There are (will be) two types of VM presented by MIPS KVM:

1) That provided by the initial patch where a faux-MIPS is emulated and 
all kernel code must be in the USEG address space.

2) Real MIPS, addressing works as per the architecture specification.

Presumably the user-space client would like to know which of these are 
supported, as well as be able to select the desired model.

I don't know the best way to do this, but I agree that 
KVM_CAP_MIPS_VZ_ASE is probably not the best name for it.

My idea was to have the arg of the KVM_CREATE_VM ioctl specify the 
desired style

David Daney



> Paolo
>
>> Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
>> ---
>>   include/uapi/linux/kvm.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index a5c86fc..5889e976 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -666,6 +666,7 @@ struct kvm_ppc_smmu_info {
>>   #define KVM_CAP_IRQ_MPIC 90
>>   #define KVM_CAP_PPC_RTAS 91
>>   #define KVM_CAP_IRQ_XICS 92
>> +#define KVM_CAP_MIPS_VZ_ASE 93
>>
>>   #ifdef KVM_CAP_IRQ_ROUTING
>>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
