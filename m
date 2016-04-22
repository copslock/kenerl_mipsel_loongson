Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Apr 2016 12:22:24 +0200 (CEST)
Received: from e06smtp06.uk.ibm.com ([195.75.94.102]:47890 "EHLO
        e06smtp06.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026472AbcDVKWVw62Iz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Apr 2016 12:22:21 +0200
Received: from localhost
        by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <cornelia.huck@de.ibm.com>;
        Fri, 22 Apr 2016 11:22:16 +0100
Received: from d06dlp03.portsmouth.uk.ibm.com (9.149.20.15)
        by e06smtp06.uk.ibm.com (192.168.101.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Fri, 22 Apr 2016 11:22:14 +0100
X-IBM-Helo: d06dlp03.portsmouth.uk.ibm.com
X-IBM-MailFrom: cornelia.huck@de.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2FCF21B08061
        for <linux-mips@linux-mips.org>; Fri, 22 Apr 2016 11:22:59 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com [9.149.37.250])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u3MAMESW3473856
        for <linux-mips@linux-mips.org>; Fri, 22 Apr 2016 10:22:14 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u3MAMDNG007762
        for <linux-mips@linux-mips.org>; Fri, 22 Apr 2016 04:22:13 -0600
Received: from gondolin (dyn-9-152-224-197.boeblingen.de.ibm.com [9.152.224.197])
        by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u3MAMCtg007754;
        Fri, 22 Apr 2016 04:22:12 -0600
Date:   Fri, 22 Apr 2016 12:22:10 +0200
From:   Cornelia Huck <cornelia.huck@de.ibm.com>
To:     Greg Kurz <gkurz@linux.vnet.ibm.com>
Cc:     Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, james.hogan@imgtec.com,
        mingo@redhat.com, linux-mips@linux-mips.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Hildenbrand <dahi@linux.vnet.ibm.com>,
        qemu-ppc@nongnu.org, Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v4 2/2] KVM: move vcpu id checking to archs
Message-ID: <20160422122210.50450345.cornelia.huck@de.ibm.com>
In-Reply-To: <20160422112538.41b23a9d@bahia.huguette.org>
References: <146124809455.32509.15232948272580716135.stgit@bahia.huguette.org>
        <146124811255.32509.17679765789502091772.stgit@bahia.huguette.org>
        <20160421160018.GA31953@potion>
        <20160421184500.6cb5fd8a@bahia.huguette.org>
        <20160421173611.GB30356@potion>
        <20160422112538.41b23a9d@bahia.huguette.org>
Organization: IBM Deutschland Research & Development GmbH Vorsitzende des
 Aufsichtsrats: Martina Koederitz =?UTF-8?B?R2VzY2jDpGZ0c2bDvGhydW5nOg==?=
 Dirk Wittkopp Sitz der Gesellschaft: =?UTF-8?B?QsO2Ymxpbmdlbg==?=
 Registergericht: Amtsgericht Stuttgart, HRB 243294
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16042210-0025-0000-0000-000014091660
Return-Path: <cornelia.huck@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53199
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cornelia.huck@de.ibm.com
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

On Fri, 22 Apr 2016 11:25:38 +0200
Greg Kurz <gkurz@linux.vnet.ibm.com> wrote:

> On Thu, 21 Apr 2016 19:36:11 +0200
> Radim Krčmář <rkrcmar@redhat.com> wrote:

> > > For other architectures, it is simply KVM_MAX_VCPUS.  
> > 
> > (Other architectures would not implement the capability.)
> > 
> 
> So this would be KVM_CAP_PPC_MAX_VCPU_ID ?
> 
> > >> I think this would also clarify the connection between VCPU limit and
> > >> VCPU_ID limit.  Or is a boolean cap better?
> > >>   
> > > 
> > > Well, I'm not fan of adding a generic API to handle a corner case...  
> > 
> > I don't like it either, but I think that introducing the capability is
> > worth avoided problems.
> > 
> 
> I admit that having separate capabilities for the number of vcpus and the
> maximum vcpu id fixes the confusion once and for all.

Yes, and I think that the new max_vpcu_id cap should be generic for
that reason.
