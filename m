Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Aug 2017 09:27:08 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54324 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990552AbdHVH1A6OI7X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Aug 2017 09:27:00 +0200
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v7M7OVEK109546
        for <linux-mips@linux-mips.org>; Tue, 22 Aug 2017 03:26:59 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2cgg3sgh5m-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Tue, 22 Aug 2017 03:26:58 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <borntraeger@de.ibm.com>;
        Tue, 22 Aug 2017 08:26:56 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp15.uk.ibm.com (192.168.101.145) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Tue, 22 Aug 2017 08:26:51 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v7M7QpCS20316278;
        Tue, 22 Aug 2017 07:26:51 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 509294C046;
        Tue, 22 Aug 2017 08:23:53 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C35864C040;
        Tue, 22 Aug 2017 08:23:52 +0100 (BST)
Received: from oc7330422307.ibm.com (unknown [9.152.224.206])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 22 Aug 2017 08:23:52 +0100 (BST)
Subject: Re: [PATCH RFC v3 1/9] KVM: s390: optimize detection of started vcpus
To:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Christoffer Dall <cdall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alexander Graf <agraf@suse.com>
References: <20170821203530.9266-1-rkrcmar@redhat.com>
 <20170821203530.9266-2-rkrcmar@redhat.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Date:   Tue, 22 Aug 2017 09:26:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20170821203530.9266-2-rkrcmar@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 17082207-0020-0000-0000-000003B052EA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 17082207-0021-0000-0000-0000423FCB4D
Message-Id: <f09bdbc8-298f-fa7e-31be-ceaf048681a9@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-08-22_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.0.1-1707230000
 definitions=main-1708220114
Return-Path: <borntraeger@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59753
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



On 08/21/2017 10:35 PM, Radim Krčmář wrote:
> We can add a variable instead of scanning all online VCPUs to know how
> many are started.  We can't trivially tell which VCPU is the last one,
> though.
> 
> Suggested-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>



> @@ -3453,16 +3447,12 @@ void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
> 
>  void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
>  {
> -	int i, online_vcpus, started_vcpus = 0;

here you remove i.

> -	struct kvm_vcpu *started_vcpu = NULL;
> -
>  	if (is_vcpu_stopped(vcpu))
>  		return;
> 
>  	trace_kvm_s390_vcpu_start_stop(vcpu->vcpu_id, 0);
>  	/* Only one cpu at a time may enter/leave the STOPPED state. */
>  	spin_lock(&vcpu->kvm->arch.start_stop_lock);
> -	online_vcpus = atomic_read(&vcpu->kvm->online_vcpus);
> 
>  	/* SIGP STOP and SIGP STOP AND STORE STATUS has been fully processed */
>  	kvm_s390_clear_stop_irq(vcpu);
> @@ -3470,19 +3460,20 @@ void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
>  	atomic_or(CPUSTAT_STOPPED, &vcpu->arch.sie_block->cpuflags);
>  	__disable_ibs_on_vcpu(vcpu);
> 
> -	for (i = 0; i < online_vcpus; i++) {
> -		if (!is_vcpu_stopped(vcpu->kvm->vcpus[i])) {
> -			started_vcpus++;
> -			started_vcpu = vcpu->kvm->vcpus[i];
> -		}
> -	}
> +	vcpu->kvm->arch.started_vcpus--;
> +
> +	if (vcpu->kvm->arch.started_vcpus == 1) {
> +		struct kvm_vcpu *started_vcpu;
> 
> -	if (started_vcpus == 1) {
>  		/*
> -		 * As we only have one VCPU left, we want to enable the
> -		 * IBS facility for that VCPU to speed it up.
> +		 * As we only have one VCPU left, we want to enable the IBS
> +		 * facility for that VCPU to speed it up.
>  		 */
> -		__enable_ibs_on_vcpu(started_vcpu);
> +		kvm_for_each_vcpu(i, started_vcpu, vcpu->kvm)

here you need i.
> +			if (!is_vcpu_stopped(started_vcpu)) {
> +				__enable_ibs_on_vcpu(started_vcpu);
> +				break;
> +			}
>  	}
> 
>  	spin_unlock(&vcpu->kvm->arch.start_stop_lock);
> 
