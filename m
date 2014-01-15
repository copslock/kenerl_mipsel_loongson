Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2014 12:44:15 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:16177 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827313AbaAOLoN17Kpz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jan 2014 12:44:13 +0100
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s0FBhrEa012052
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 15 Jan 2014 06:43:55 -0500
Received: from yakj.usersys.redhat.com (ovpn-112-37.ams2.redhat.com [10.36.112.37])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s0FB9KsK030749;
        Wed, 15 Jan 2014 06:09:24 -0500
Message-ID: <52D66C5F.5030509@redhat.com>
Date:   Wed, 15 Jan 2014 12:09:19 +0100
From:   Paolo Bonzini <pbonzini@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130923 Thunderbird/17.0.9
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org,
        Markos Chandras <markos.chandras@imgtec.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: Re: [PATCH 0/2] MIPS: KVM: fixes for KVM on ProAptiv cores
References: <1389780682-32638-1-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1389780682-32638-1-git-send-email-james.hogan@imgtec.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39000
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

Il 15/01/2014 11:11, James Hogan ha scritto:
> ProAptiv support includes support for EHINV (TLB invalidation) and FTLB
> (large fixed page size TLBs), both of which cause problems when combined
> with KVM. These two patches fix those problems.
> 
> These are based on John Crispin's mips-next-3.14 branch where ProAptiv
> support is applied. Please consider applying these for v3.14 too.
> 
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: Gleb Natapov <gleb@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: kvm@vger.kernel.org
> Cc: Markos Chandras <markos.chandras@imgtec.com>
> Cc: Sanjay Lal <sanjayl@kymasys.com>
> 
> James Hogan (2):
>   MIPS: KVM: use common EHINV aware UNIQUE_ENTRYHI
>   MIPS: KVM: remove shadow_tlb code
> 
>  arch/mips/include/asm/kvm_host.h |   7 --
>  arch/mips/kvm/kvm_mips.c         |   1 -
>  arch/mips/kvm/kvm_tlb.c          | 134 +--------------------------------------
>  3 files changed, 1 insertion(+), 141 deletions(-)
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
