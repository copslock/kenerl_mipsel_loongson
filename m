Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Apr 2016 19:36:28 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:58728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27026632AbcDURgYmUQFB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Apr 2016 19:36:24 +0200
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B06B1BB06;
        Thu, 21 Apr 2016 17:36:16 +0000 (UTC)
Received: from potion (dhcp-1-215.brq.redhat.com [10.34.1.215])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u3LHaCEp032478;
        Thu, 21 Apr 2016 13:36:12 -0400
Received: by potion (sSMTP sendmail emulation); Thu, 21 Apr 2016 19:36:11 +0200
Date:   Thu, 21 Apr 2016 19:36:11 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Greg Kurz <gkurz@linux.vnet.ibm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, james.hogan@imgtec.com,
        mingo@redhat.com, linux-mips@linux-mips.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Hildenbrand <dahi@linux.vnet.ibm.com>,
        qemu-ppc@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v4 2/2] KVM: move vcpu id checking to archs
Message-ID: <20160421173611.GB30356@potion>
References: <146124809455.32509.15232948272580716135.stgit@bahia.huguette.org>
 <146124811255.32509.17679765789502091772.stgit@bahia.huguette.org>
 <20160421160018.GA31953@potion>
 <20160421184500.6cb5fd8a@bahia.huguette.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160421184500.6cb5fd8a@bahia.huguette.org>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Return-Path: <rkrcmar@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53184
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

2016-04-21 18:45+0200, Greg Kurz:
> On Thu, 21 Apr 2016 18:00:19 +0200
> Radim Krčmář <rkrcmar@redhat.com> wrote:
>> 2016-04-21 16:20+0200, Greg Kurz:
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
>> > 
>> > In the end, this patch simply moves the check to MIPS and x86. While here,
>> > we also update the documentation to dissociate vcpu ids from the maximum
>> > number of vcpus per virtual machine.
>> > 
>> > Acked-by: James Hogan <james.hogan@imgtec.com>
>> > Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
>> > Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
>> > ---
>> > v4: - updated subject for more clarity on what the patch does
>> >     - added James's and Connie's A-b tags
>> >     - updated documentation
>> > 
>> >  Documentation/virtual/kvm/api.txt |    7 +++----
>> >  arch/mips/kvm/mips.c              |    7 ++++++-
>> >  arch/x86/kvm/x86.c                |    3 +++
>> >  virt/kvm/kvm_main.c               |    3 ---
>> >  4 files changed, 12 insertions(+), 8 deletions(-)
>> > 
>> > diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
>> > index 4d0542c5206b..486a1d783b82 100644
>> > --- a/Documentation/virtual/kvm/api.txt
>> > +++ b/Documentation/virtual/kvm/api.txt
>> > @@ -199,11 +199,10 @@ Type: vm ioctl
>> >  Parameters: vcpu id (apic id on x86)
>> >  Returns: vcpu fd on success, -1 on error
>> >  
>> > -This API adds a vcpu to a virtual machine.  The vcpu id is a small integer
>> > -in the range [0, max_vcpus).
>> > +This API adds a vcpu to a virtual machine.  The vcpu id is a positive integer.  
>> 
>> Userspace won't be able to tell if KVM_CREATE_VCPU failed because it
>> provided too high vcpu_id to an old KVM or because new KVM failed in
>> other areas.  Not a huge problem (because I expect that userspace will
>> die on both), but a new KVM_CAP would be able to disambiguate it.
>> 
>> Toggleable capability doesn't seem necessary and only PowerPC changes,
>> so the capability could be arch specific ... I think that a generic one
>> makes more sense, though.
>>
> 
> I'm not sure userspace can disambiguate all the cases where KVM_CREATE_VCPU
> returns EINVAL already... and, FWIW, QEMU simply exits if it gets an error.

Yes, userspace cannot disambiguate, but would have the option of not
doing something that is destined to fail, like with KVM_CAP_MAX_VCPU.

> So I understand your concern but would we have a user for this ?

I think so, new userspace on pre-patch KVM is the most likely one.

Userspace cannot tell that KVM doesn't support the extension and
behaving like on patched KVM would result in a failure with cryptic
error message, because KVM only returns EINVAL.

Btw. PowerPC QEMU tries vcpu_id >= KVM_MAX_VCPUS and fails, instead of
recognizing that the user wanted too much?

>> Userspace also doesn't know the vcpu id limit anymore, and it might
>> care.  What do you think about returning the arch-specific limit (or the
>> highest positive integer) as int in KVM_CAP_MAX_VCPU_ID?
>> 
> 
> This is partly true: only arch agnostic code would be lost.
> 
> Moreover this is a problem for powerpc only at the moment and userspace code
> can compute the vcpu_id limit out of KVM_CAP_MAX_VCPUS and KVM_CAP_PPC_SMT.

How would that work on KVM without this patch?

> For other architectures, it is simply KVM_MAX_VCPUS.

(Other architectures would not implement the capability.)

>> I think this would also clarify the connection between VCPU limit and
>> VCPU_ID limit.  Or is a boolean cap better?
>> 
> 
> Well, I'm not fan of adding a generic API to handle a corner case...

I don't like it either, but I think that introducing the capability is
worth avoided problems.

>                                                                      maybe later
> if we have other scenarios where vcpu ids need to cross the limit ?

x86 is going to have that soon too -- vcpu_id will be able to range from
0 to 2^32-1 (or 2^31), but MAX_CPUS related data structures probably
won't be improved to actually scale, so MAX_CPUS will remain lower.
