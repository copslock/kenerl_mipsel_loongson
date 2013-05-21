Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 May 2013 10:01:07 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:21114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6818020Ab3EUIBCD5vMf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 May 2013 10:01:02 +0200
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4L80nkf002356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 21 May 2013 04:00:49 -0400
Received: from dhcp-1-237.tlv.redhat.com (dhcp-4-26.tlv.redhat.com [10.35.4.26])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r4L80lcs019224;
        Tue, 21 May 2013 04:00:48 -0400
Received: by dhcp-1-237.tlv.redhat.com (Postfix, from userid 13519)
        id 6ED801336CE; Tue, 21 May 2013 11:00:47 +0300 (IDT)
Date:   Tue, 21 May 2013 11:00:47 +0300
From:   Gleb Natapov <gleb@redhat.com>
To:     Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-mips@linux-mips.org, kvm@vger.kernel.org,
        ralf@linux-mips.org, mtosatti@redhat.com
Subject: Re: [PATCH 2/4] KVM/MIPS32: Wrap calls to gfn_to_pfn() with
 srcu_read_lock/unlock()
Message-ID: <20130521080047.GV4725@redhat.com>
References: <n>
 <1368885266-8619-1-git-send-email-sanjayl@kymasys.com>
 <1368885266-8619-3-git-send-email-sanjayl@kymasys.com>
 <20130519125210.GI4725@redhat.com>
 <AB98FD4C-123F-4C64-B6CF-0F86E4EBD554@kymasys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AB98FD4C-123F-4C64-B6CF-0F86E4EBD554@kymasys.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Return-Path: <gleb@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36497
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gleb@redhat.com
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

On Sun, May 19, 2013 at 10:36:32AM -0400, Sanjay Lal wrote:
> 
> On May 19, 2013, at 8:52 AM, Gleb Natapov wrote:
> 
> > On Sat, May 18, 2013 at 06:54:24AM -0700, Sanjay Lal wrote:
> >> - As suggested by Gleb, wrap calls to gfn_to_pfn() with srcu_read_lock/unlock().
> >>  Memory slots should be acccessed from a SRCU read section.
> >> - kvm_mips_map_page() now returns an error code to it's callers, instead of calling panic()
> >> if it cannot find a mapping for a particular gfn.
> >> 
> >> Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
> >> ---
> >> arch/mips/kvm/kvm_tlb.c | 36 +++++++++++++++++++++++++++---------
> >> 1 file changed, 27 insertions(+), 9 deletions(-)
> >> 
> >> diff --git a/arch/mips/kvm/kvm_tlb.c b/arch/mips/kvm/kvm_tlb.c
> >> index 89511a9..ab2e9b0 100644
> >> --- a/arch/mips/kvm/kvm_tlb.c
> >> +++ b/arch/mips/kvm/kvm_tlb.c
> >> @@ -16,7 +16,10 @@
> >> #include <linux/mm.h>
> >> #include <linux/delay.h>
> >> #include <linux/module.h>
> >> +#include <linux/bootmem.h>
> > You haven't answered it when I asked it on v2:
> > Is this include still needed now when export of min_low_pfn is not
> > longer here?
> > 
> 
> Sorry about that, juggling too many patches, bootmem.h is no longer needed in kvm_tlb.c.  Actually, I thought I had removed it before posting v3.
> 
Should I expect new version, or can I just drop this include from the
patch and apply?

--
			Gleb.
