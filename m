Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Dec 2015 14:35:59 +0100 (CET)
Received: from mx2.parallels.com ([199.115.105.18]:35239 "EHLO
        mx2.parallels.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008444AbbLXNf5hIa0f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Dec 2015 14:35:57 +0100
Received: from [199.115.105.250] (helo=mail.odin.com)
        by mx2.parallels.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        (Exim 4.86)
        (envelope-from <rkagan@virtuozzo.com>)
        id 1aC63d-0006Mi-Cy; Thu, 24 Dec 2015 05:35:53 -0800
Received: from rkaganb.sw.ru (10.30.3.95) by US-EXCH2.sw.swsoft.com
 (10.255.249.46) with Microsoft SMTP Server (TLS) id 15.0.1130.7; Thu, 24 Dec
 2015 05:35:43 -0800
Date:   Thu, 24 Dec 2015 16:35:39 +0300
From:   Roman Kagan <rkagan@virtuozzo.com>
To:     Andrey Smetanin <asmetanin@virtuozzo.com>
CC:     <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Gleb Natapov <gleb@kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alexander Graf <agraf@suse.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Cornelia Huck" <cornelia.huck@de.ibm.com>,
        <linux-mips@linux-mips.org>, <kvm-ppc@vger.kernel.org>,
        <linux-s390@vger.kernel.org>, "Denis V. Lunev" <den@openvz.org>,
        <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2] kvm: Make vcpu->requests as 64 bit bitmap
Message-ID: <20151224133538.GD19296@rkaganb.sw.ru>
Mail-Followup-To: Roman Kagan <rkagan@virtuozzo.com>,
        Andrey Smetanin <asmetanin@virtuozzo.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Gleb Natapov <gleb@kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, Alexander Graf <agraf@suse.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cornelia.huck@de.ibm.com>, linux-mips@linux-mips.org,
        kvm-ppc@vger.kernel.org, linux-s390@vger.kernel.org,
        "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
References: <1450963761-20269-1-git-send-email-asmetanin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1450963761-20269-1-git-send-email-asmetanin@virtuozzo.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: US-EXCH2.sw.swsoft.com (10.255.249.46) To
 US-EXCH2.sw.swsoft.com (10.255.249.46)
Return-Path: <rkagan@virtuozzo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50752
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rkagan@virtuozzo.com
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

On Thu, Dec 24, 2015 at 04:29:21PM +0300, Andrey Smetanin wrote:
> Currently on x86 arch we has already 32 requests defined
> so the newer request bits can't be placed inside
> vcpu->requests(unsigned long) inside x86 32 bit system.
> But we are going to add a new request in x86 arch
> for Hyper-V tsc page support.
> 
> To solve the problem the patch replaces vcpu->requests by
> bitmap with 64 bit length and uses bitmap API.
> 
> The patch consists of:
> * announce kvm_has_requests() to check whether vcpu has
> requests
> * announce kvm_clear_request() to clear particular vcpu request
> * announce kvm_test_request() to test particular vcpu request
> * replace if (vcpu->requests) by if (kvm_has_requests(vcpu))
> * replace clear_bit(req, vcpu->requests) by
>  kvm_clear_request(req, vcpu)
> 
> Changes v2:
> * hide internals of vcpu requests bitmap
> by interface usage in all places
> * replace test_bit(req, vcpu->requests) by
>  kvm_test_request()
> * POWERPC: trace vcpu requests bitmap by
> __bitmask, __assign_bitmap, __get_bitmask
> 
> Signed-off-by: Andrey Smetanin <asmetanin@virtuozzo.com>
> Acked-by: James Hogan <james.hogan@imgtec.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Gleb Natapov <gleb@kernel.org>
> CC: James Hogan <james.hogan@imgtec.com>
> CC: Paul Burton <paul.burton@imgtec.com>
> CC: Ralf Baechle <ralf@linux-mips.org>
> CC: Alexander Graf <agraf@suse.com>
> CC: Christian Borntraeger <borntraeger@de.ibm.com>
> CC: Cornelia Huck <cornelia.huck@de.ibm.com>
> CC: linux-mips@linux-mips.org
> CC: kvm-ppc@vger.kernel.org
> CC: linux-s390@vger.kernel.org
> CC: Roman Kagan <rkagan@virtuozzo.com>
> CC: Denis V. Lunev <den@openvz.org>
> CC: qemu-devel@nongnu.org
> ---
>  arch/mips/kvm/emulate.c           |  4 +---
>  arch/powerpc/kvm/book3s_pr.c      |  2 +-
>  arch/powerpc/kvm/book3s_pr_papr.c |  2 +-
>  arch/powerpc/kvm/booke.c          |  6 +++---
>  arch/powerpc/kvm/powerpc.c        |  6 +++---
>  arch/powerpc/kvm/trace.h          |  9 +++++----
>  arch/s390/kvm/kvm-s390.c          |  4 ++--
>  arch/x86/kvm/vmx.c                |  2 +-
>  arch/x86/kvm/x86.c                | 16 ++++++++--------
>  include/linux/kvm_host.h          | 38 +++++++++++++++++++++++++-------------
>  10 files changed, 50 insertions(+), 39 deletions(-)

Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
