Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Apr 2016 15:24:19 +0200 (CEST)
Received: from e06smtp15.uk.ibm.com ([195.75.94.111]:50667 "EHLO
        e06smtp15.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026632AbcDUNYQLpEBh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Apr 2016 15:24:16 +0200
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <dahi@linux.vnet.ibm.com>;
        Thu, 21 Apr 2016 14:24:10 +0100
Received: from d06dlp01.portsmouth.uk.ibm.com (9.149.20.13)
        by e06smtp15.uk.ibm.com (192.168.101.145) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 21 Apr 2016 14:24:08 +0100
X-IBM-Helo: d06dlp01.portsmouth.uk.ibm.com
X-IBM-MailFrom: dahi@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 60F5817D805D
        for <linux-mips@linux-mips.org>; Thu, 21 Apr 2016 14:24:56 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com [9.149.37.249])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u3LDO8fo25624754
        for <linux-mips@linux-mips.org>; Thu, 21 Apr 2016 13:24:08 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u3LDO7pw031495
        for <linux-mips@linux-mips.org>; Thu, 21 Apr 2016 07:24:07 -0600
Received: from thinkpad-w530 (dyn-9-152-224-108.boeblingen.de.ibm.com [9.152.224.108])
        by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u3LDO6Lt031482;
        Thu, 21 Apr 2016 07:24:07 -0600
Date:   Thu, 21 Apr 2016 15:24:06 +0200
From:   David Hildenbrand <dahi@linux.vnet.ibm.com>
To:     Cornelia Huck <cornelia.huck@de.ibm.com>
Cc:     Greg Kurz <gkurz@linux.vnet.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, james.hogan@imgtec.com,
        mingo@redhat.com, linux-mips@linux-mips.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, qemu-ppc@nongnu.org,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3] KVM: remove buggy vcpu id check on vcpu creation
Message-ID: <20160421152406.1ed89bec@thinkpad-w530>
In-Reply-To: <20160420184807.056da314.cornelia.huck@de.ibm.com>
References: <146116689259.20666.15860134511726195550.stgit@bahia.huguette.org>
        <20160420184807.056da314.cornelia.huck@de.ibm.com>
Organization: IBM Deutschland GmbH
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16042113-0021-0000-0000-0000339C2188
Return-Path: <dahi@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53168
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

> On Wed, 20 Apr 2016 17:44:54 +0200
> Greg Kurz <gkurz@linux.vnet.ibm.com> wrote:
> 
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
> > In the end, this patch simply moves the check to MIPS and x86.
> > 
> > Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> > ---
> > v3: use ERR_PTR()
> > 
> >  arch/mips/kvm/mips.c |    7 ++++++-
> >  arch/x86/kvm/x86.c   |    3 +++
> >  virt/kvm/kvm_main.c  |    3 ---
> >  3 files changed, 9 insertions(+), 4 deletions(-)
> >   
> 
> Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> 

The existing s390 check looks sane to me, too!

David
