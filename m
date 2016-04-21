Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Apr 2016 17:29:30 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:50467 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27025433AbcDUP33b8ZCb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Apr 2016 17:29:29 +0200
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0695C7F095;
        Thu, 21 Apr 2016 15:29:21 +0000 (UTC)
Received: from potion (dhcp-1-215.brq.redhat.com [10.34.1.215])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u3LFTHTY012403;
        Thu, 21 Apr 2016 11:29:17 -0400
Received: by potion (sSMTP sendmail emulation); Thu, 21 Apr 2016 17:29:16 +0200
Date:   Thu, 21 Apr 2016 17:29:16 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Greg Kurz <gkurz@linux.vnet.ibm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, james.hogan@imgtec.com,
        mingo@redhat.com, linux-mips@linux-mips.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, qemu-ppc@nongnu.org,
        Cornelia Huck <cornelia.huck@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3] KVM: remove buggy vcpu id check on vcpu creation
Message-ID: <20160421152916.GA30356@potion>
References: <146116689259.20666.15860134511726195550.stgit@bahia.huguette.org>
 <20160420182909.GB4044@potion>
 <20160421132958.0e9292d5@bahia.huguette.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160421132958.0e9292d5@bahia.huguette.org>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Return-Path: <rkrcmar@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rkrcmar@redhat.com
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

2016-04-21 13:29+0200, Greg Kurz:
> On Wed, 20 Apr 2016 20:29:09 +0200
> Radim Krčmář <rkrcmar@redhat.com> wrote:
>> 2016-04-20 17:44+0200, Greg Kurz:
>> > Commit 338c7dbadd26 ("KVM: Improve create VCPU parameter (CVE-2013-4587)")
>> > introduced a check to prevent potential kernel memory corruption in case
>> > the vcpu id is too great.
>> > 
>> > Unfortunately this check assumes vcpu ids grow in sequence with a common
>> > difference of 1, which is wrong: archs are free to use vcpu id as they fit.
>> > For example, QEMU originated vcpu ids for PowerPC cpus running in boot3s_hv
>> > mode, can grow with a common difference of 2, 4 or 8: if KVM_MAX_VCPUS is
>> > 1024, guests may be limited down to 128 vcpus on POWER8.
>> > 
>> > This means the check does not belong here and should be moved to some arch
>> > specific function: kvm_arch_vcpu_create() looks like a good candidate.
>> > 
>> > ARM and s390 already have such a check.
>> > 
>> > I could not spot any path in the PowerPC or common KVM code where a vcpu
>> > id is used as described in the above commit: I believe PowerPC can live
>> > without this check.  
>> 
>> The only problematic path I see is kvm_get_vcpu_by_id(), which returns
>> NULL for any id above KVM_MAX_VCPUS.
> 
> Oops my bad, I started to work on a 4.4 tree and I missed this check brought
> by commit c896939f7cff (KVM: use heuristic for fast VCPU lookup by id).
> 
> But again, I believe the check is wrong there also: the changelog just mentions
> this is a fastpath for the usual case where "VCPU ids match the array index"...
> why does the patch add a NULL return path if id >= KVM_MAX_VCPUS ?

(The patch had to check id >= KVM_MAX_VCPUS for sanity and there could
 not be a VCPU with that index according to the spec, so it made a
 shortcut to the correct NULL result ...)

>> Second issue is that Documentation/virtual/kvm/api.txt says
>>   4.7 KVM_CREATE_VCPU
>>   [...]
>>   This API adds a vcpu to a virtual machine.  The vcpu id is a small
>>   integer in the range [0, max_vcpus).
>> 
> 
> Yeah and I find the meaning of max_vcpus is unclear.
> 
> Here it is considered as a limit for vcpu id, but if you look at the code,
> KVM_MAX_VCPUS is also used as a limit for the number of vcpus:
> 
> virt/kvm/kvm_main.c:    if (atomic_read(&kvm->online_vcpus) == KVM_MAX_VCPUS) {

I agree.  Naming of KVM_CAP_NR_VCPUS and KVM_CAP_MAX_VCPUS would make
you think that online_vcpus limit interpretation is the correct one, but
the code is conflicted.

>> so we'd remove those two lines and change the API too.  The change would
>> be somewhat backward compatible, but doesn't PowerPC use high vcpu_id
>> just because KVM is lacking an API to set DT ID?
> 
> This is related to a limitation when running in book3s_hv mode with cpus
> that support SMT (multiple HW threads): all HW threads within a core
> cannot be running in different guests at the same time. 
> 
> We solve this by using a vcpu numbering scheme as follows:
> 
> vcpu_id[N] = (N * thread_per_core_guest) / threads_per_core_host + N % threads_per_core_guest
> 
> where N means "the Nth vcpu presented to the guest". This allows to have groups of vcpus
> that can be scheduled to run on the same real core.
> 
> So, in the "worst" case where we want to run a guest with 1 thread/core and the host
> has 8 threads/core, we will need the vcpu_id limit to be 8*KVM_MAX_VCPUS.

I see, thanks.  Accommodating existing users seems like an acceptable
excuse to change the API.

>> x86 (APIC ID) is affected by this and ARM (MP ID) probably too.
>> 
> 
> x86 is limited to KVM_MAX_VCPUS (== 255) vcpus: it won't be affected if we also
> patch kvm_get_vcpu_by_id() like suggested above.

x86 vcpu_id encodes APIC ID and APIC ID encodes CPU topology by
reserving blocks of bits for socket/core/thread, so if core or thread
count isn't a power of two, then the set of valid APIC IDs is sparse,
but max id is still limited by 255, so the effective maximum VCPU count
is lower.

x86 doesn't support APIC ID over 255 yet, though, so this change
wouldn't change a thing in practice. :)
