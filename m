Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Apr 2016 13:20:11 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:33460 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27026468AbcDVLUJfPfIs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Apr 2016 13:20:09 +0200
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0BE017D0D2;
        Fri, 22 Apr 2016 11:20:01 +0000 (UTC)
Received: from nial.brq.redhat.com (dhcp-1-118.brq.redhat.com [10.34.1.118])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u3MBJwHY000371;
        Fri, 22 Apr 2016 07:19:59 -0400
Date:   Fri, 22 Apr 2016 13:19:57 +0200
From:   Igor Mammedov <imammedo@redhat.com>
To:     Greg Kurz <gkurz@linux.vnet.ibm.com>
Cc:     Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, james.hogan@imgtec.com,
        mingo@redhat.com, linux-mips@linux-mips.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Hildenbrand <dahi@linux.vnet.ibm.com>,
        qemu-ppc@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v4 2/2] KVM: move vcpu id checking to archs
Message-ID: <20160422131957.6419a696@nial.brq.redhat.com>
In-Reply-To: <20160422112538.41b23a9d@bahia.huguette.org>
References: <146124809455.32509.15232948272580716135.stgit@bahia.huguette.org>
        <146124811255.32509.17679765789502091772.stgit@bahia.huguette.org>
        <20160421160018.GA31953@potion>
        <20160421184500.6cb5fd8a@bahia.huguette.org>
        <20160421173611.GB30356@potion>
        <20160422112538.41b23a9d@bahia.huguette.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Return-Path: <imammedo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53200
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imammedo@redhat.com
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

> Hi Radim !
> 
> On Thu, 21 Apr 2016 19:36:11 +0200
> Radim Krčmář <rkrcmar@redhat.com> wrote:
> 
> > 2016-04-21 18:45+0200, Greg Kurz:  
> > > On Thu, 21 Apr 2016 18:00:19 +0200
> > > Radim Krčmář <rkrcmar@redhat.com> wrote:    
> > >> 2016-04-21 16:20+0200, Greg Kurz:    
[...]
> > >                                                                      maybe later
> > > if we have other scenarios where vcpu ids need to cross the limit ?    
> > 
> > x86 is going to have that soon too -- vcpu_id will be able to range from
> > 0 to 2^32-1 (or 2^31), but MAX_CPUS related data structures probably
> > won't be improved to actually scale, so MAX_CPUS will remain lower.
> >  
That's not true, x86 is going to stick with KVM_MAX_VCPUS/qemu's max_cpus,
the only thing that is going to change is that max supported APIC ID
value will be in range 0 to 2^32-1 vs current 8bit one
and since APIC ID is not vcpu_id so it won't affect vcpu_id.
 
> 
> Do you have some pointers to share so that we can see the broader picture ?
> 
> Thanks !
> 
> --
> Greg
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
