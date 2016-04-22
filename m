Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Apr 2016 15:07:20 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:50244 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27026472AbcDVNHSx1Gl3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Apr 2016 15:07:18 +0200
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D8813C05E16B;
        Fri, 22 Apr 2016 13:07:10 +0000 (UTC)
Received: from potion (dhcp-1-215.brq.redhat.com [10.34.1.215])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u3MD76cp021970;
        Fri, 22 Apr 2016 09:07:07 -0400
Received: by potion (sSMTP sendmail emulation); Fri, 22 Apr 2016 15:07:06 +0200
Date:   Fri, 22 Apr 2016 15:07:06 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     Greg Kurz <gkurz@linux.vnet.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, james.hogan@imgtec.com,
        Ingo Molnar <mingo@redhat.com>, linux-mips@linux-mips.org,
        kvm <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        qemu-ppc@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3] KVM: remove buggy vcpu id check on vcpu creation
Message-ID: <20160422130705.GD7202@potion>
References: <146116689259.20666.15860134511726195550.stgit@bahia.huguette.org>
 <20160420182909.GB4044@potion>
 <20160421132958.0e9292d5@bahia.huguette.org>
 <20160421152916.GA30356@potion>
 <CANRm+Cwh__btdC4e4t+jYqHsafL6xff6t4eukxT=EmwVLYvrMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANRm+Cwh__btdC4e4t+jYqHsafL6xff6t4eukxT=EmwVLYvrMA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Return-Path: <rkrcmar@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53201
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

2016-04-22 09:40+0800, Wanpeng Li:
> 2016-04-21 23:29 GMT+08:00 Radim Krčmář <rkrcmar@redhat.com>:
>> x86 vcpu_id encodes APIC ID and APIC ID encodes CPU topology by
>> reserving blocks of bits for socket/core/thread, so if core or thread
>> count isn't a power of two, then the set of valid APIC IDs is sparse,
> 
>              ^^^^^^^^^^^^^^^^^^^
>              ^^^^^^^
> Is this the root reason why recommand max vCPUs per vm is 160 and the
> KVM_MAX_VCPUS is 255 instead of due to perforamnce concern?

No, the recommended amout of VCPUs is 160 because I didn't bump it after
PLE stopped killing big guests. :/

You can get full 255 VCPU guest with a proper configuration, e.g.
"-smp 255" or "-smp 255,cores=8" and the only problem is scalability,
but I don't know of anything that doesn't scale to that point.

(Scaling up to 2^32 is harder, because you don't want O(N) search, nor
 full allocation on smaller guests.  Neither is a big problem now.)
