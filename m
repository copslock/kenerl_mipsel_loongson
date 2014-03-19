Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Mar 2014 17:02:42 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:34917 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6862337AbaCSQCgWh4OX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Mar 2014 17:02:36 +0100
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s2JG2K5m020257
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 19 Mar 2014 12:02:20 -0400
Received: from yakj.usersys.redhat.com (ovpn-112-55.ams2.redhat.com [10.36.112.55])
        by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id s2JG2GZn009363;
        Wed, 19 Mar 2014 12:02:17 -0400
Message-ID: <5329BF87.9070406@redhat.com>
Date:   Wed, 19 Mar 2014 17:02:15 +0100
From:   Paolo Bonzini <pbonzini@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@kernel.org>
CC:     Sanjay Lal <sanjayl@kymasys.com>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH 0/4] MIPS: KVM: RI + RDHWR handling fixes
References: <1394802370-20487-1-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1394802370-20487-1-git-send-email-james.hogan@imgtec.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39504
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pbonzini@redhat.com
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

Il 14/03/2014 14:06, James Hogan ha scritto:
> Some misc KVM RI/RDHWR handling fixes.
>
> Patch 1 prevents a reserved instruction (RI) exception from taking out
> the entire guest (e.g. crashme inevitably causes lots of these). If the
> hypervisor can't handle the RI, it can just emulate a guest RI exception
> instead so the guest OS can handle it. I've marked this one for stable
> since it allows guest userland to take out the VM.
>
> Patch 3 fixes the RDHWR emulation to actually consult HWREna so that the
> guest can catch exceptions of implemented RDHWR if it desires. I've not
> marked this for stable since Linux at least enables the hardware
> registers with HWREna anyway.
>
> Patch 2 and 4 are cleanups that I noticed while writing patch 3.
>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Gleb Natapov <gleb@kernel.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sanjay Lal <sanjayl@kymasys.com>
> Cc: linux-mips@linux-mips.org
> Cc: kvm@vger.kernel.org
>
> James Hogan (4):
>   MIPS: KVM: Pass reserved instruction exceptions to guest
>   MIPS: KVM: asm/kvm_host.h: Clean up whitespace
>   MIPS: KVM: Consult HWREna before emulating RDHWR
>   MIPS: KVM: Remove dead code in CP0 emulation
>
>  arch/mips/include/asm/kvm_host.h | 417 ++++++++++++++++++++-------------------
>  arch/mips/kvm/kvm_mips_emul.c    |  40 ++--
>  2 files changed, 229 insertions(+), 228 deletions(-)
>

Looks good.  I've applied it to kvm/queue, having a Reviewed-by or 
Acked-by from the MIPS folks would be nice too.

Paolo
