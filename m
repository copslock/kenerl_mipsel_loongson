Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Apr 2016 15:48:50 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:39594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27026343AbcDVNssicPHE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Apr 2016 15:48:48 +0200
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 840BB8111C;
        Fri, 22 Apr 2016 13:48:42 +0000 (UTC)
Received: from potion (dhcp-1-215.brq.redhat.com [10.34.1.215])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u3MDmcgk009670;
        Fri, 22 Apr 2016 09:48:39 -0400
Received: by potion (sSMTP sendmail emulation); Fri, 22 Apr 2016 15:48:38 +0200
Date:   Fri, 22 Apr 2016 15:48:38 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Igor Mammedov <imammedo@redhat.com>
Cc:     Greg Kurz <gkurz@linux.vnet.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, james.hogan@imgtec.com,
        mingo@redhat.com, linux-mips@linux-mips.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Hildenbrand <dahi@linux.vnet.ibm.com>,
        qemu-ppc@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v4 2/2] KVM: move vcpu id checking to archs
Message-ID: <20160422134837.GA30844@potion>
References: <146124809455.32509.15232948272580716135.stgit@bahia.huguette.org>
 <146124811255.32509.17679765789502091772.stgit@bahia.huguette.org>
 <20160421160018.GA31953@potion>
 <20160421184500.6cb5fd8a@bahia.huguette.org>
 <20160421173611.GB30356@potion>
 <20160422112538.41b23a9d@bahia.huguette.org>
 <20160422131957.6419a696@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160422131957.6419a696@nial.brq.redhat.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Return-Path: <rkrcmar@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53203
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

2016-04-22 13:19+0200, Igor Mammedov:
> On Fri, 22 Apr 2016 11:25:38 +0200
> Greg Kurz <gkurz@linux.vnet.ibm.com> wrote:
>> On Thu, 21 Apr 2016 19:36:11 +0200
>> Radim Krčmář <rkrcmar@redhat.com> wrote:
>> > 2016-04-21 18:45+0200, Greg Kurz:  
>> > > On Thu, 21 Apr 2016 18:00:19 +0200
>> > > Radim Krčmář <rkrcmar@redhat.com> wrote:    
>> > >> 2016-04-21 16:20+0200, Greg Kurz:    
>[...]
>> > >                                                                      maybe later
>> > > if we have other scenarios where vcpu ids need to cross the limit ?    
>> > 
>> > x86 is going to have that soon too -- vcpu_id will be able to range from
>> > 0 to 2^32-1 (or 2^31), but MAX_CPUS related data structures probably
>> > won't be improved to actually scale, so MAX_CPUS will remain lower.
>> >  
> That's not true, x86 is going to stick with KVM_MAX_VCPUS/qemu's max_cpus,
> the only thing that is going to change is that max supported APIC ID
> value will be in range 0 to 2^32-1 vs current 8bit one
> and since APIC ID is not vcpu_id so it won't affect vcpu_id.

I wish it wasn't.  vcpu_id is the initial APIC ID -- at least the spec
says so and KVM code behaves like that (QEMU does too).

It doesn't have to be so, though, KVM_SET_LAPIC provides the interface
to set APIC ID.  We'd decouple these two and change some related things.
(And add yet another cap for that? :])

I'll see what would be really needed,

thanks.
