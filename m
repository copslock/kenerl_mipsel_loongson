Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Jun 2013 14:03:42 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:38204 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6815747Ab3FPMDkUfti- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 16 Jun 2013 14:03:40 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5GC3a4c030455;
        Sun, 16 Jun 2013 14:03:36 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5GC3aWX030454;
        Sun, 16 Jun 2013 14:03:36 +0200
Date:   Sun, 16 Jun 2013 14:03:36 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, kvm@vger.kernel.org,
        Sanjay Lal <sanjayl@kymasys.com>, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 28/31] mips/kvm: Only use KVM_COALESCED_MMIO_PAGE_OFFSET
 with KVM_MIPSTE
Message-ID: <20130616120336.GN20046@linux-mips.org>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
 <1370646215-6543-29-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1370646215-6543-29-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Fri, Jun 07, 2013 at 04:03:32PM -0700, David Daney wrote:

> From: David Daney <david.daney@cavium.com>
> 
> The forthcoming MIPSVZ code doesn't currently use this, so it must
> only be enabled for KVM_MIPSTE.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  arch/mips/include/asm/kvm_host.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
> index 505b804..9f209e1 100644
> --- a/arch/mips/include/asm/kvm_host.h
> +++ b/arch/mips/include/asm/kvm_host.h
> @@ -25,7 +25,9 @@
>  /* memory slots that does not exposed to userspace */
>  #define KVM_PRIVATE_MEM_SLOTS 	0
>  
> +#ifdef CONFIG_KVM_MIPSTE
>  #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
> +#endif

What if KVM_MIPSTE and KVM_MIPSVZ both get enabled?

  Ralf
