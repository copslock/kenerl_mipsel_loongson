Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Apr 2016 18:45:18 +0200 (CEST)
Received: from e06smtp17.uk.ibm.com ([195.75.94.113]:56596 "EHLO
        e06smtp17.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026632AbcDUQpOOCJOP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Apr 2016 18:45:14 +0200
Received: from localhost
        by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <gkurz@linux.vnet.ibm.com>;
        Thu, 21 Apr 2016 17:45:08 +0100
Received: from d06dlp02.portsmouth.uk.ibm.com (9.149.20.14)
        by e06smtp17.uk.ibm.com (192.168.101.147) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 21 Apr 2016 17:45:06 +0100
X-IBM-Helo: d06dlp02.portsmouth.uk.ibm.com
X-IBM-MailFrom: gkurz@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3249B2190066
        for <linux-mips@linux-mips.org>; Thu, 21 Apr 2016 17:44:43 +0100 (BST)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com [9.149.37.251])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u3LGj5eN5964170
        for <linux-mips@linux-mips.org>; Thu, 21 Apr 2016 16:45:05 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u3LFj6nK020798
        for <linux-mips@linux-mips.org>; Thu, 21 Apr 2016 09:45:07 -0600
Received: from smtp.lab.toulouse-stg.fr.ibm.com (srv01.lab.toulouse-stg.fr.ibm.com [9.101.4.1])
        by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u3LFj64V020795;
        Thu, 21 Apr 2016 09:45:06 -0600
Received: from bahia.huguette.org (sig-9-83-160-41.evts.uk.ibm.com [9.83.160.41])
        by smtp.lab.toulouse-stg.fr.ibm.com (Postfix) with ESMTP id 6EC5622050F;
        Thu, 21 Apr 2016 18:45:02 +0200 (CEST)
Date:   Thu, 21 Apr 2016 18:45:00 +0200
From:   Greg Kurz <gkurz@linux.vnet.ibm.com>
To:     Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, james.hogan@imgtec.com,
        mingo@redhat.com, linux-mips@linux-mips.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Hildenbrand <dahi@linux.vnet.ibm.com>,
        qemu-ppc@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v4 2/2] KVM: move vcpu id checking to archs
Message-ID: <20160421184500.6cb5fd8a@bahia.huguette.org>
In-Reply-To: <20160421160018.GA31953@potion>
References: <146124809455.32509.15232948272580716135.stgit@bahia.huguette.org>
        <146124811255.32509.17679765789502091772.stgit@bahia.huguette.org>
        <20160421160018.GA31953@potion>
Organization: IBM
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16042116-0005-0000-0000-0000144A25B9
Return-Path: <gkurz@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53181
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

On Thu, 21 Apr 2016 18:00:19 +0200
Radim Krčmář <rkrcmar@redhat.com> wrote:

> 2016-04-21 16:20+0200, Greg Kurz:
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
> > 
> > In the end, this patch simply moves the check to MIPS and x86. While here,
> > we also update the documentation to dissociate vcpu ids from the maximum
> > number of vcpus per virtual machine.
> > 
> > Acked-by: James Hogan <james.hogan@imgtec.com>
> > Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> > ---
> > v4: - updated subject for more clarity on what the patch does
> >     - added James's and Connie's A-b tags
> >     - updated documentation
> > 
> >  Documentation/virtual/kvm/api.txt |    7 +++----
> >  arch/mips/kvm/mips.c              |    7 ++++++-
> >  arch/x86/kvm/x86.c                |    3 +++
> >  virt/kvm/kvm_main.c               |    3 ---
> >  4 files changed, 12 insertions(+), 8 deletions(-)
> > 
> > diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> > index 4d0542c5206b..486a1d783b82 100644
> > --- a/Documentation/virtual/kvm/api.txt
> > +++ b/Documentation/virtual/kvm/api.txt
> > @@ -199,11 +199,10 @@ Type: vm ioctl
> >  Parameters: vcpu id (apic id on x86)
> >  Returns: vcpu fd on success, -1 on error
> >  
> > -This API adds a vcpu to a virtual machine.  The vcpu id is a small integer
> > -in the range [0, max_vcpus).
> > +This API adds a vcpu to a virtual machine.  The vcpu id is a positive integer.  
> 
> Userspace won't be able to tell if KVM_CREATE_VCPU failed because it
> provided too high vcpu_id to an old KVM or because new KVM failed in
> other areas.  Not a huge problem (because I expect that userspace will
> die on both), but a new KVM_CAP would be able to disambiguate it.
> 
> Toggleable capability doesn't seem necessary and only PowerPC changes,
> so the capability could be arch specific ... I think that a generic one
> makes more sense, though.
>

I'm not sure userspace can disambiguate all the cases where KVM_CREATE_VCPU
returns EINVAL already... and, FWIW, QEMU simply exits if it gets an error.

So I understand your concern but would we have a user for this ?

> Userspace also doesn't know the vcpu id limit anymore, and it might
> care.  What do you think about returning the arch-specific limit (or the
> highest positive integer) as int in KVM_CAP_MAX_VCPU_ID?
> 

This is partly true: only arch agnostic code would be lost.

Moreover this is a problem for powerpc only at the moment and userspace code
can compute the vcpu_id limit out of KVM_CAP_MAX_VCPUS and KVM_CAP_PPC_SMT.

For other architectures, it is simply KVM_MAX_VCPUS.

> I think this would also clarify the connection between VCPU limit and
> VCPU_ID limit.  Or is a boolean cap better?
> 

Well, I'm not fan of adding a generic API to handle a corner case... maybe later
if we have other scenarios where vcpu ids need to cross the limit ?

> > -The recommended max_vcpus value can be retrieved using the KVM_CAP_NR_VCPUS of
> > -the KVM_CHECK_EXTENSION ioctl() at run-time.
> > +The recommended maximum number of vcpus (max_vcpus) can be retrieved using the
> > +KVM_CAP_NR_VCPUS of the KVM_CHECK_EXTENSION ioctl() at run-time.
> >  The maximum possible value for max_vcpus can be retrieved using the
> >  KVM_CAP_MAX_VCPUS of the KVM_CHECK_EXTENSION ioctl() at run-time.  
> 
