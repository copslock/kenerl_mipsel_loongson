Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 16:10:39 +0200 (CEST)
Received: from e06smtp11.uk.ibm.com ([195.75.94.107]:43451 "EHLO
        e06smtp11.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011723AbbD1OKhr0Hdn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2015 16:10:37 +0200
Received: from /spool/local
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <borntraeger@de.ibm.com>;
        Tue, 28 Apr 2015 15:10:32 +0100
Received: from d06dlp02.portsmouth.uk.ibm.com (9.149.20.14)
        by e06smtp11.uk.ibm.com (192.168.101.141) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Tue, 28 Apr 2015 15:10:30 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0B1212190046
        for <linux-mips@linux-mips.org>; Tue, 28 Apr 2015 15:10:12 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t3SEAT5l7668208
        for <linux-mips@linux-mips.org>; Tue, 28 Apr 2015 14:10:29 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t3SEARnW009572
        for <linux-mips@linux-mips.org>; Tue, 28 Apr 2015 08:10:28 -0600
Received: from oc1450873852.ibm.com (sig-9-81-65-26.evts.uk.ibm.com [9.81.65.26])
        by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id t3SEAOMo009349;
        Tue, 28 Apr 2015 08:10:25 -0600
Message-ID: <553F94CF.2080409@de.ibm.com>
Date:   Tue, 28 Apr 2015 16:10:23 +0200
From:   Christian Borntraeger <borntraeger@de.ibm.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     KVM <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-mips@linux-mips.org,
        Cornelia Huck <cornelia.huck@de.ibm.com>,
        Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH/RFC 2/2] KVM: push down irq_save from kvm_guest_exit
References: <1430217168-25504-1-git-send-email-borntraeger@de.ibm.com> <1430217168-25504-3-git-send-email-borntraeger@de.ibm.com> <553F70E9.50907@redhat.com>
In-Reply-To: <553F70E9.50907@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 15042814-0041-0000-0000-00000439C4DD
Return-Path: <borntraeger@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47133
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

Am 28.04.2015 um 13:37 schrieb Paolo Bonzini:
>> --- a/arch/powerpc/kvm/book3s_pr.c
>> +++ b/arch/powerpc/kvm/book3s_pr.c
>> @@ -891,7 +891,9 @@ int kvmppc_handle_exit_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
>>  
>>  	/* We get here with MSR.EE=1 */
>>  
>> +	local_irq_disable();
>>  	trace_kvm_exit(exit_nr, vcpu);
>> +	local_irq_enable();
>>  	kvm_guest_exit();
> 
> This looks wrong.
> 
Yes it is.

>> --- a/include/linux/kvm_host.h
>> +++ b/include/linux/kvm_host.h
>> @@ -773,11 +773,7 @@ static inline void kvm_guest_enter(void)
>>  
>>  static inline void kvm_guest_exit(void)
>>  {
>> -	unsigned long flags;
>> -
>> -	local_irq_save(flags);
> 
> Why no WARN_ON here?

Yes,WARN_ON makes sense.
Hmm, on the other hand the  irqs_disabled call might be somewhat expensive again
(would boil down on s390 to call stnsm (store and and system mask) once for 
query and once for setting.

so...
> 
> I think the patches are sensible, especially since you can add warnings.
>  This kind of code definitely knows if it has interrupts disabled or enabled
> 
> Alternatively, the irq-disabled versions could be called
> __kvm_guest_{enter,exit}.  Then you can use those directly when it makes
> sense.

..having a special  __kvm_guest_{enter,exit} without the WARN_ON might be even
the cheapest way. In that way I could leave everything besides s390 alone and
arch maintainers can do a followup patch if appropriate.
