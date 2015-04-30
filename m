Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Apr 2015 14:01:47 +0200 (CEST)
Received: from e06smtp13.uk.ibm.com ([195.75.94.109]:47075 "EHLO
        e06smtp13.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012291AbbD3MBpkJ6xx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Apr 2015 14:01:45 +0200
Received: from /spool/local
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <borntraeger@de.ibm.com>;
        Thu, 30 Apr 2015 13:01:42 +0100
Received: from d06dlp02.portsmouth.uk.ibm.com (9.149.20.14)
        by e06smtp13.uk.ibm.com (192.168.101.143) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 30 Apr 2015 13:01:39 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id AA456219005F
        for <linux-mips@linux-mips.org>; Thu, 30 Apr 2015 13:01:21 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com [9.149.37.248])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t3UC1dGk7471518
        for <linux-mips@linux-mips.org>; Thu, 30 Apr 2015 12:01:39 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t3UC1cwm031790
        for <linux-mips@linux-mips.org>; Thu, 30 Apr 2015 08:01:38 -0400
Received: from oc1450873852.ibm.com (dyn-9-152-224-132.boeblingen.de.ibm.com [9.152.224.132])
        by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id t3UC1bsj031739;
        Thu, 30 Apr 2015 08:01:37 -0400
Message-ID: <554219A1.8050006@de.ibm.com>
Date:   Thu, 30 Apr 2015 14:01:37 +0200
From:   Christian Borntraeger <borntraeger@de.ibm.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     KVM <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-mips@linux-mips.org,
        Cornelia Huck <cornelia.huck@de.ibm.com>,
        Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 1/2] KVM: provide irq_unsafe kvm_guest_{enter|exit}
References: <1430394211-25209-1-git-send-email-borntraeger@de.ibm.com> <1430394211-25209-2-git-send-email-borntraeger@de.ibm.com> <554216EC.6070406@redhat.com>
In-Reply-To: <554216EC.6070406@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 15043012-0013-0000-0000-000003D4D935
Return-Path: <borntraeger@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47172
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

Am 30.04.2015 um 13:50 schrieb Paolo Bonzini:
> 
> 
> On 30/04/2015 13:43, Christian Borntraeger wrote:
>> +/* must be called with irqs disabled */
>> +static inline void __kvm_guest_enter(void)
>>  {
>> -	unsigned long flags;
>> -
>> -	BUG_ON(preemptible());
> 
> Please keep the BUG_ON() in kvm_guest_enter.  Otherwise looks good, thanks!

would be 
	BUG_ON(!irqs_disabled())
then?
