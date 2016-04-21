Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Apr 2016 13:30:16 +0200 (CEST)
Received: from e06smtp13.uk.ibm.com ([195.75.94.109]:47424 "EHLO
        e06smtp13.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027202AbcDULaOjc7fh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Apr 2016 13:30:14 +0200
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <gkurz@linux.vnet.ibm.com>;
        Thu, 21 Apr 2016 12:30:09 +0100
Received: from d06dlp02.portsmouth.uk.ibm.com (9.149.20.14)
        by e06smtp13.uk.ibm.com (192.168.101.143) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 21 Apr 2016 12:30:06 +0100
X-IBM-Helo: d06dlp02.portsmouth.uk.ibm.com
X-IBM-MailFrom: gkurz@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7524A2190073
        for <linux-mips@linux-mips.org>; Thu, 21 Apr 2016 12:29:43 +0100 (BST)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com [9.149.37.213])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u3LBU5QB3015084
        for <linux-mips@linux-mips.org>; Thu, 21 Apr 2016 11:30:05 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u3LBU3s3021612
        for <linux-mips@linux-mips.org>; Thu, 21 Apr 2016 05:30:05 -0600
Received: from smtp.lab.toulouse-stg.fr.ibm.com (srv01.lab.toulouse-stg.fr.ibm.com [9.101.4.1])
        by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u3LBU3eA021582;
        Thu, 21 Apr 2016 05:30:03 -0600
Received: from bahia.huguette.org (sig-9-83-160-41.evts.uk.ibm.com [9.83.160.41])
        by smtp.lab.toulouse-stg.fr.ibm.com (Postfix) with ESMTP id 5DCBA220077;
        Thu, 21 Apr 2016 13:30:01 +0200 (CEST)
Date:   Thu, 21 Apr 2016 13:29:58 +0200
From:   Greg Kurz <gkurz@linux.vnet.ibm.com>
To:     Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, james.hogan@imgtec.com,
        mingo@redhat.com, linux-mips@linux-mips.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, qemu-ppc@nongnu.org,
        Cornelia Huck <cornelia.huck@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3] KVM: remove buggy vcpu id check on vcpu creation
Message-ID: <20160421132958.0e9292d5@bahia.huguette.org>
In-Reply-To: <20160420182909.GB4044@potion>
References: <146116689259.20666.15860134511726195550.stgit@bahia.huguette.org>
        <20160420182909.GB4044@potion>
Organization: IBM
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16042111-0013-0000-0000-00000E7620FC
Return-Path: <gkurz@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53145
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gkurz@linux.vnet.ibm.com
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

On Wed, 20 Apr 2016 20:29:09 +0200
Radim Krčmář <rkrcmar@redhat.com> wrote:

> 2016-04-20 17:44+0200, Greg Kurz:
> > Commit 338c7dbadd26 ("KVM: Improve create VCPU parameter (CVE-2013-4587)")
> > introduced a check to prevent potential kernel memory corruption in case
> > the vcpu id is too great.
> > 
> > Unfortunately this check assumes vcpu ids grow in sequence with a common
> > difference of 1, which is wrong: archs are free to use vcpu id as they fit.
> > For example, QEMU originated vcpu ids for PowerPC cpus running in boot3s_hv
> > mode, can grow with a common difference of 2, 4 or 8: if KVM_MAX_VCPUS is
> > 1024, guests may be limited down to 128 vcpus on POWER8.
> > 
> > This means the check does not belong here and should be moved to some arch
> > specific function: kvm_arch_vcpu_create() looks like a good candidate.
> > 
> > ARM and s390 already have such a check.
> > 
> > I could not spot any path in the PowerPC or common KVM code where a vcpu
> > id is used as described in the above commit: I believe PowerPC can live
> > without this check.  
> 
> The only problematic path I see is kvm_get_vcpu_by_id(), which returns
> NULL for any id above KVM_MAX_VCPUS.

Oops my bad, I started to work on a 4.4 tree and I missed this check brought
by commit c896939f7cff (KVM: use heuristic for fast VCPU lookup by id).

But again, I believe the check is wrong there also: the changelog just mentions
this is a fastpath for the usual case where "VCPU ids match the array index"...
why does the patch add a NULL return path if id >= KVM_MAX_VCPUS ?

> kvm_vm_ioctl_create_vcpu() uses kvm_get_vcpu_by_id() to check for
> duplicate ids, so PowerPC could end up with many VCPUs of the same id.
> I'm not sure what could fail, but code doesn't expect this situation.
> Patching kvm_get_vcpu_by_id() is easy, though.
> 

Something like this ?

	if (id < 0)
		return NULL;
	if (id < KVM_MAX_VCPUS)
		vcpu = kvm_get_vcpu(kvm, id);

In the same patch ?

> Second issue is that Documentation/virtual/kvm/api.txt says
>   4.7 KVM_CREATE_VCPU
>   [...]
>   This API adds a vcpu to a virtual machine.  The vcpu id is a small
>   integer in the range [0, max_vcpus).
> 

Yeah and I find the meaning of max_vcpus is unclear.

Here it is considered as a limit for vcpu id, but if you look at the code,
KVM_MAX_VCPUS is also used as a limit for the number of vcpus:

virt/kvm/kvm_main.c:    if (atomic_read(&kvm->online_vcpus) == KVM_MAX_VCPUS) {

> so we'd remove those two lines and change the API too.  The change would
> be somewhat backward compatible, but doesn't PowerPC use high vcpu_id
> just because KVM is lacking an API to set DT ID?

This is related to a limitation when running in book3s_hv mode with cpus
that support SMT (multiple HW threads): all HW threads within a core
cannot be running in different guests at the same time. 

We solve this by using a vcpu numbering scheme as follows:

vcpu_id[N] = (N * thread_per_core_guest) / threads_per_core_host + N % threads_per_core_guest

where N means "the Nth vcpu presented to the guest". This allows to have groups of vcpus
that can be scheduled to run on the same real core.

So, in the "worst" case where we want to run a guest with 1 thread/core and the host
has 8 threads/core, we will need the vcpu_id limit to be 8*KVM_MAX_VCPUS.

> x86 (APIC ID) is affected by this and ARM (MP ID) probably too.
> 

x86 is limited to KVM_MAX_VCPUS (== 255) vcpus: it won't be affected if we also
patch kvm_get_vcpu_by_id() like suggested above.

Depending on the platform, ARM can be limited to VGIC_V3_MAX_CPUS (== 255) or
VGIC_V8_MAX_CPUS (== 8). I guess it won't be affected either.

> (Maybe it is time to decouple VCPU ID used in KVM interfaces from
>  architecture dependent CPU ID that the guest uses ...

Maybe... I did not get that far.

>  Mostly for future architectures that won't fit into 32 bits, but
>  clarity of the code could go up as well.)
> 

Thanks for your remarks !

Cheers.

--
Greg
