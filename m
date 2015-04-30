Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Apr 2015 14:07:48 +0200 (CEST)
Received: from e06smtp14.uk.ibm.com ([195.75.94.110]:48344 "EHLO
        e06smtp14.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012298AbbD3MHquOqo1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Apr 2015 14:07:46 +0200
Received: from /spool/local
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <borntraeger@de.ibm.com>;
        Thu, 30 Apr 2015 13:07:42 +0100
Received: from d06dlp03.portsmouth.uk.ibm.com (9.149.20.15)
        by e06smtp14.uk.ibm.com (192.168.101.144) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 30 Apr 2015 13:07:40 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4E1E31B0805F
        for <linux-mips@linux-mips.org>; Thu, 30 Apr 2015 13:08:20 +0100 (BST)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com [9.149.37.247])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t3UC7eRl6619418
        for <linux-mips@linux-mips.org>; Thu, 30 Apr 2015 12:07:40 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t3UC7d4l030872
        for <linux-mips@linux-mips.org>; Thu, 30 Apr 2015 06:07:40 -0600
Received: from oc1450873852.ibm.com (dyn-9-152-224-132.boeblingen.de.ibm.com [9.152.224.132])
        by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id t3UC7dd4030831;
        Thu, 30 Apr 2015 06:07:39 -0600
Message-ID: <55421B0A.2060606@de.ibm.com>
Date:   Thu, 30 Apr 2015 14:07:38 +0200
From:   Christian Borntraeger <borntraeger@de.ibm.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     KVM <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-mips@linux-mips.org,
        Cornelia Huck <cornelia.huck@de.ibm.com>,
        Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 1/2] KVM: provide irq_unsafe kvm_guest_{enter|exit}
References: <1430394211-25209-1-git-send-email-borntraeger@de.ibm.com> <1430394211-25209-2-git-send-email-borntraeger@de.ibm.com> <554216EC.6070406@redhat.com> <554219A1.8050006@de.ibm.com> <554219F2.9020805@de.ibm.com>
In-Reply-To: <554219F2.9020805@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 15043012-0017-0000-0000-000003E5BE05
Return-Path: <borntraeger@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47174
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

Am 30.04.2015 um 14:02 schrieb Christian Borntraeger:
> Am 30.04.2015 um 14:01 schrieb Christian Borntraeger:
>> Am 30.04.2015 um 13:50 schrieb Paolo Bonzini:
>>>
>>>
>>> On 30/04/2015 13:43, Christian Borntraeger wrote:
>>>> +/* must be called with irqs disabled */
>>>> +static inline void __kvm_guest_enter(void)
>>>>  {
>>>> -	unsigned long flags;
>>>> -
>>>> -	BUG_ON(preemptible());
>>>
>>> Please keep the BUG_ON() in kvm_guest_enter.  Otherwise looks good, thanks!
> 
> Ah, you mean have the BUG_ON in the non underscore version? Yes, makes sense.

Hmmm, too quick.
the BUG_ON was there to make sure that rcu_virt_note_context_switch is safe.
The reworked code pulls the rcu_virt_note_context_switch within the irq_save
section so we no longer need this BUG_ON, no?

Christian
