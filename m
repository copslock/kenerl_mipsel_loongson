Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jul 2016 09:50:22 +0200 (CEST)
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36130 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992156AbcGOHuPpwl8t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jul 2016 09:50:15 +0200
Received: by mail-pa0-f68.google.com with SMTP id ez1so2340003pab.3
        for <linux-mips@linux-mips.org>; Fri, 15 Jul 2016 00:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=cLkRhc2e5SR69+gwO5tQEm8WNFClS5Fb+frU37GSqQA=;
        b=Vu/Dw6Ks8YYb9lVzkgLTSAZD+DvPIecx6hAJz37GkTpleB2e2DlzhDMFXr8M/YsCeJ
         AiCSYIIMdXiWMr847s6CLeJ08Mb3ccwDH4wK7fC0zflzACa0qcwR60+BevPdC2P9z9BX
         remph5kjMM9uVluTxBVAo8nk+6J1Ad4nQpG+qtWwLc+YpNEhIAUpCaE8DOdlCDI0+iUD
         Gcss8ENNJi3HhQYKxLYIj21E7L0f8c0FZlXW63iUKa6qBv1w8MCetfZ+7jNC0aPxZNhC
         FJ9fFu+hcyW0CwclNhMYAxTn2Mh7HnpfjL8glWAI+S9DuRjImKOQkXbxM/5SdNEYgPEq
         Eecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=cLkRhc2e5SR69+gwO5tQEm8WNFClS5Fb+frU37GSqQA=;
        b=EIvUbGDsuHP9rz7IjOjXs+EjXY/r1MJCj+/wvOxSaA3pdn6VZoYmRThRPK2dwNzLWw
         3XZuuiOKiKJZje6hsNxB84zcn/8TTYftlPYmadeTzvQCUmJYRZq3L/Z3UtkiNmKSsVhF
         26A7PYJzQe4avC6JyhO7d9nwYngvv1lmdl83ZcOIhEGGFXGdHGFbHjf4FwsQxnb7CAhI
         0S01Pd+MBgeI2FpByCsbGT784qm7bjPtsQMdOHr4h4UZ+Vbxz8vBIlHHD2xmBx2dvc3o
         o5YVD/D3tcMlPAWO8FRNVHtCjFvghJM9FUfi1iGaGaWnIRf4SVKHv22NuS8miiWLeRzC
         5fqQ==
X-Gm-Message-State: ALyK8tK3JsEiLTHGoaYlupKtQg7TW1TyMLW4+jyetU2o7ob7kJbfqdAhMJKeUyNETeKBuA==
X-Received: by 10.66.77.194 with SMTP id u2mr29422640paw.90.1468569009645;
        Fri, 15 Jul 2016 00:50:09 -0700 (PDT)
Received: from dyn253.ozlabs.ibm.com ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id o6sm2207471pab.11.2016.07.15.00.50.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jul 2016 00:50:09 -0700 (PDT)
Subject: Re: [PATCH V3 4/5] kvm/stats: Add provisioning for 64-bit vm and vcpu
 statistics
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
References: <1468400015-4834-1-git-send-email-sjitindarsingh@gmail.com>
 <57860408.1000203@de.ibm.com>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com,
        christoffer.dall@linaro.org, marc.zyngier@arm.com,
        james.hogan@imgtec.com, agraf@suse.com, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, cornelia.huck@de.ibm.com,
        kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-mips@linux-mips.org,
        linux-s390@vger.kernel.org
From:   Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <578895A7.5060001@gmail.com>
Date:   Fri, 15 Jul 2016 17:49:59 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
MIME-Version: 1.0
In-Reply-To: <57860408.1000203@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <sjitindarsingh@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjitindarsingh@gmail.com
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



On 13/07/16 19:04, Christian Borntraeger wrote:
> On 07/13/2016 10:53 AM, Suraj Jitindar Singh wrote:
>> vms and vcpus have statistics associated with them which can be viewed
>> within the debugfs. Currently it is assumed within the vcpu_stat_get() and
>> vm_stat_get() functions that all of these statistics are represented as
>> u32s, however the next patch adds some u64 statistics.
>>
>> Thus modify these two functions, vcpu_stat_get() and vm_stat_get(), such
>> that they expect u64 statistics and update vm and vcpu statistics to u64s
>> accordingly.
>>
>> ---
>> Change Log:
>>
>> V1 -> V2:
>> 	- Nothing
>> V2 -> V3:
>> 	- Instead of implementing separate u32 and u64 functions keep the
>> 	  generic functions and modify them to expect u64s. Thus update all
>> 	  vm and vcpu statistics to u64s accordingly.
> Have not looked into everything, but I agree with changing everything to 64bit.
>
>
>> @@ -3583,8 +3583,8 @@ static const struct file_operations vcpu_stat_get_per_vm_fops = {
>>  };
>>
>>  static const struct file_operations *stat_fops_per_vm[] = {
>> -	[KVM_STAT_VCPU] = &vcpu_stat_get_per_vm_fops,
>> -	[KVM_STAT_VM]   = &vm_stat_get_per_vm_fops,
>> +	[KVM_STAT_VCPU]		= &vcpu_stat_get_per_vm_fops,
>> +	[KVM_STAT_VM]		= &vm_stat_get_per_vm_fops,
>>  };
> unrelated white space changes?

Woops, I'll fix that. Thanks

>
>>  static int vm_stat_get(void *_offset, u64 *val)
>> @@ -3628,8 +3628,8 @@ static int vcpu_stat_get(void *_offset, u64 *val)
>>  DEFINE_SIMPLE_ATTRIBUTE(vcpu_stat_fops, vcpu_stat_get, NULL, "%llu\n");
>>
>>  static const struct file_operations *stat_fops[] = {
>> -	[KVM_STAT_VCPU] = &vcpu_stat_fops,
>> -	[KVM_STAT_VM]   = &vm_stat_fops,
>> +	[KVM_STAT_VCPU]		= &vcpu_stat_fops,
>> +	[KVM_STAT_VM]		= &vm_stat_fops,
>>  };
>>
>>  static int kvm_init_debug(void)
>>
