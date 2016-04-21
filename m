Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Apr 2016 15:23:41 +0200 (CEST)
Received: from e06smtp10.uk.ibm.com ([195.75.94.106]:50692 "EHLO
        e06smtp10.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027124AbcDUNXggfCNA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Apr 2016 15:23:36 +0200
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <dahi@linux.vnet.ibm.com>;
        Thu, 21 Apr 2016 14:23:30 +0100
Received: from d06dlp03.portsmouth.uk.ibm.com (9.149.20.15)
        by e06smtp10.uk.ibm.com (192.168.101.140) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 21 Apr 2016 14:22:59 +0100
X-IBM-Helo: d06dlp03.portsmouth.uk.ibm.com
X-IBM-MailFrom: dahi@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 720621B0806E
        for <linux-mips@linux-mips.org>; Thu, 21 Apr 2016 14:23:43 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com [9.149.37.248])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u3LDMwKv7406002
        for <linux-mips@linux-mips.org>; Thu, 21 Apr 2016 13:22:58 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u3LDMwOQ031195
        for <linux-mips@linux-mips.org>; Thu, 21 Apr 2016 09:22:58 -0400
Received: from thinkpad-w530 (dyn-9-152-224-108.boeblingen.de.ibm.com [9.152.224.108])
        by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u3LDMvV9031168;
        Thu, 21 Apr 2016 09:22:57 -0400
Date:   Thu, 21 Apr 2016 15:22:55 +0200
From:   David Hildenbrand <dahi@linux.vnet.ibm.com>
To:     Greg Kurz <gkurz@linux.vnet.ibm.com>
Cc:     Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, james.hogan@imgtec.com,
        mingo@redhat.com, linux-mips@linux-mips.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, qemu-ppc@nongnu.org,
        Cornelia Huck <cornelia.huck@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3] KVM: remove buggy vcpu id check on vcpu creation
Message-ID: <20160421152255.5b1a04af@thinkpad-w530>
In-Reply-To: <20160421132958.0e9292d5@bahia.huguette.org>
References: <146116689259.20666.15860134511726195550.stgit@bahia.huguette.org>
        <20160420182909.GB4044@potion>
        <20160421132958.0e9292d5@bahia.huguette.org>
Organization: IBM Deutschland GmbH
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16042113-0041-0000-0000-00001AD4197C
Return-Path: <dahi@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53167
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dahi@linux.vnet.ibm.com
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

> On Wed, 20 Apr 2016 20:29:09 +0200
> Radim Krčmář <rkrcmar@redhat.com> wrote:
> 
> > 2016-04-20 17:44+0200, Greg Kurz:  
> > > Commit 338c7dbadd26 ("KVM: Improve create VCPU parameter (CVE-2013-4587)")
> > > introduced a check to prevent potential kernel memory corruption in case
> > > the vcpu id is too great.
> > > 
> > > Unfortunately this check assumes vcpu ids grow in sequence with a common
> > > difference of 1, which is wrong: archs are free to use vcpu id as they fit.
> > > For example, QEMU originated vcpu ids for PowerPC cpus running in boot3s_hv
> > > mode, can grow with a common difference of 2, 4 or 8: if KVM_MAX_VCPUS is
> > > 1024, guests may be limited down to 128 vcpus on POWER8.
> > > 
> > > This means the check does not belong here and should be moved to some arch
> > > specific function: kvm_arch_vcpu_create() looks like a good candidate.
> > > 
> > > ARM and s390 already have such a check.
> > > 
> > > I could not spot any path in the PowerPC or common KVM code where a vcpu
> > > id is used as described in the above commit: I believe PowerPC can live
> > > without this check.    
> > 
> > The only problematic path I see is kvm_get_vcpu_by_id(), which returns
> > NULL for any id above KVM_MAX_VCPUS.  
> 
> Oops my bad, I started to work on a 4.4 tree and I missed this check brought
> by commit c896939f7cff (KVM: use heuristic for fast VCPU lookup by id).
> 
> But again, I believe the check is wrong there also: the changelog just mentions
> this is a fastpath for the usual case where "VCPU ids match the array index"...
> why does the patch add a NULL return path if id >= KVM_MAX_VCPUS ?
> 
> > kvm_vm_ioctl_create_vcpu() uses kvm_get_vcpu_by_id() to check for
> > duplicate ids, so PowerPC could end up with many VCPUs of the same id.
> > I'm not sure what could fail, but code doesn't expect this situation.
> > Patching kvm_get_vcpu_by_id() is easy, though.
> >   
> 
> Something like this ?
> 
> 	if (id < 0)
> 		return NULL;
> 	if (id < KVM_MAX_VCPUS)
> 		vcpu = kvm_get_vcpu(kvm, id);
> 
> In the same patch ?

So the heuristic would only trigger if id < KVM_MAX_VCPUS.
By initializing vcpu to NULL this would work.

David
