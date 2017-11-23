Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Nov 2017 19:05:26 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32990 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990511AbdKWSFUH6fBE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Nov 2017 19:05:20 +0100
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vANI3Q81031152
        for <linux-mips@linux-mips.org>; Thu, 23 Nov 2017 13:05:17 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2edyhwb2mw-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Thu, 23 Nov 2017 13:05:17 -0500
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <borntraeger@de.ibm.com>;
        Thu, 23 Nov 2017 18:05:14 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp13.uk.ibm.com (192.168.101.143) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 23 Nov 2017 18:05:08 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id vANI58iv44302430;
        Thu, 23 Nov 2017 18:05:08 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EC6FA4040;
        Thu, 23 Nov 2017 17:59:47 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77152A404D;
        Thu, 23 Nov 2017 17:59:46 +0000 (GMT)
Received: from oc7330422307.ibm.com (unknown [9.145.174.206])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Nov 2017 17:59:46 +0000 (GMT)
Subject: Re: [RFC PATCH] KVM: Only register preempt notifiers and load arch
 cpu state as needed
To:     Christoffer Dall <cdall@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Christoffer Dall <christoffer.dall@linaro.org>,
        kvm@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
        Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
References: <20171123160521.27260-1-christoffer.dall@linaro.org>
 <72357599-798d-14d0-336a-69a083f17863@redhat.com>
 <20171123170642.GA28855@cbox>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Date:   Thu, 23 Nov 2017 19:05:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171123170642.GA28855@cbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 17112318-0012-0000-0000-00000590E457
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 17112318-0013-0000-0000-0000190BBD9C
Message-Id: <57693a50-e682-9b3b-7d8c-c46b66e33d84@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-23_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1711230244
Return-Path: <borntraeger@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61065
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: borntraeger@de.ibm.com
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



On 11/23/2017 06:06 PM, Christoffer Dall wrote:
> On Thu, Nov 23, 2017 at 05:17:00PM +0100, Paolo Bonzini wrote:
>> On 23/11/2017 17:05, Christoffer Dall wrote:
>>> For example,
>>> arm64 is about to do significant work in vcpu load/put when running a
>>> vcpu, but not when doing things like KVM_SET_ONE_REG or
>>> KVM_SET_MP_STATE.
>>
>> Out of curiosity, in what circumstances are these ioctls a hot path?
>> Especially KVM_SET_MP_STATE.
>>
> 
> Perhaps my commit message was misleading; we only want to do that for
> KVM_RUN, and not for anything else.  We're already doing things like
> potentially jumping to hyp mode and flushing VMIDs which really
> shouldn't be done unless we actually plan on running a VCPU, and we're
> going to do things like setting up the timer to handle timer interrupts
> in an ISR, which doesn't make sense unless the VCPU is running.
> 
> Add to that, that loading an entire VM's state onto hardware, only to
> read back a single register from hardware and returning it to user
> space, doesn't really fall within optimization vs. non-optimization in
> the critical path, but is just wrong, IMHO.
> 
>>> Hi all,
>>>
>>> Drew suggested this as an alternative approach to recording the ioctl
>>> number on the vcpu struct [1] as it may benefit other architectures in
>>> general.
>>>
>>> I had a look at some of the specific ioctls across architectures, but
>>> must admit that I can't easily tell which architecture specific logic
>>> relies on having registered preempt notifiers and having called the
>>> architecture specific load function.
>>>
>>> It would be great if you would let me know if you think this is
>>> generally useful or if you prefer the less invasive approach, and in
>>> case this is useful, if you could have a look at all the vcpu ioctls for
>>> your architecture and let me know if I am being too loose or too
>>> careful in calling __vcpu_load() in this patch.
>>
>> I can suggest a third approach:
>>
>>         if (ioctl == KVM_GET_ONE_REG || ioctl == KVM_SET_ONE_REG)
>>                 return kvm_arch_vcpu_ioctl(filp, ioctl, arg);
>>
>> in kvm_vcpu_ioctl before "r = vcpu_load(vcpu);", or even better:
>>
>>         if (ioctl == KVM_GET_ONE_REG)
>> 		// call kvm_arch_vcpu_get_one_reg_ioctl(vcpu, &reg);
>> 		// and do copy_to_user
>> 		return kvm_vcpu_get_one_reg_ioctl(vcpu, arg);
>>         if (ioctl == KVM_SET_ONE_REG)
>> 		// do copy_from_user then call
>> 		// kvm_arch_vcpu_set_one_reg_ioctl(vcpu, &reg);
>> 		return kvm_vcpu_set_one_reg_ioctl(vcpu, arg);
>>
>> so that the kvm_arch_vcpu_get/set_one_reg_ioctl functions are called
>> without the lock.
>>
>> Then all architectures except ARM can be switched to do
>> vcpu_load/vcpu_put in kvm_arch_vcpu_get/set_one_reg_ioctl
> 
> That doesn't solve my need as I want to *only* do the arch vcpu_load for
> KVM_RUN, I should have been more clear in the commit message.

What about splitting arch_vcpu_load/put into two callbacks and call the 2nd
one only for VCPU_run? e.g. keep arch_vcpu_load and add arch_vcpu_load_run
and arch_vcpu_unload_run

Then every architecture can move things from arch_vcpu_load into arch_vcpu_load_run
if its only necessary for RUN.
