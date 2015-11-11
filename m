Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2015 15:43:31 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:33808 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011543AbbKKOn3T0qSe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Nov 2015 15:43:29 +0100
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (Postfix) with ESMTPS id 359738F31A;
        Wed, 11 Nov 2015 14:43:26 +0000 (UTC)
Received: from [10.36.112.47] (ovpn-112-47.ams2.redhat.com [10.36.112.47])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id tABEhE3f011290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 11 Nov 2015 09:43:21 -0500
Subject: Re: [PATCH 0/3] MIPS: KVM: Misc fixes
To:     James Hogan <james.hogan@imgtec.com>
References: <1447251680-5254-1-git-send-email-james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, Gleb Natapov <gleb@kernel.org>,
        linux-mips@linux-mips.org, kvm@vger.kernel.org,
        stable@vger.kernel.org
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <56435402.2050503@redhat.com>
Date:   Wed, 11 Nov 2015 15:43:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <1447251680-5254-1-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49889
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



On 11/11/2015 15:21, James Hogan wrote:
> A few misc MIPS KVM fixes for issues that have been around since the
> code was merged in v3.10.
> 
> James Hogan (3):
>   MIPS: KVM: Fix ASID restoration logic
>   MIPS: KVM: Fix CACHE immediate offset sign extension
>   MIPS: KVM: Uninit VCPU in vcpu_create error path
> 
>  arch/mips/kvm/emulate.c |  2 +-
>  arch/mips/kvm/locore.S  | 16 ++++++++++------
>  arch/mips/kvm/mips.c    |  5 ++++-
>  3 files changed, 15 insertions(+), 8 deletions(-)
> 
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Gleb Natapov <gleb@kernel.org>
> Cc: linux-mips@linux-mips.org
> Cc: kvm@vger.kernel.org
> Cc: <stable@vger.kernel.org>
> 

Thanks, these will have to wait after the end of the merge window.

Paolo
