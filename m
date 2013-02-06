Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Feb 2013 14:17:21 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:13658 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823089Ab3BFNRUb8Eh5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 6 Feb 2013 14:17:20 +0100
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r16DHHij020997
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 6 Feb 2013 08:17:17 -0500
Received: from dhcp-1-237.tlv.redhat.com (dhcp-4-26.tlv.redhat.com [10.35.4.26])
        by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r16DHGcr007247;
        Wed, 6 Feb 2013 08:17:16 -0500
Received: by dhcp-1-237.tlv.redhat.com (Postfix, from userid 13519)
        id C8EC118D479; Wed,  6 Feb 2013 15:17:15 +0200 (IST)
Date:   Wed, 6 Feb 2013 15:17:15 +0200
From:   Gleb Natapov <gleb@redhat.com>
To:     Sanjay Lal <sanjayl@kymasys.com>
Cc:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 09/18] KVM/MIPS32: COP0 accesses profiling.
Message-ID: <20130206131715.GB7837@redhat.com>
References: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com>
 <1353551656-23579-10-git-send-email-sanjayl@kymasys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1353551656-23579-10-git-send-email-sanjayl@kymasys.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
X-archive-position: 35716
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, Nov 21, 2012 at 06:34:07PM -0800, Sanjay Lal wrote:
> 
> Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
> ---
>  arch/mips/kvm/kvm_mips_stats.c | 81 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 arch/mips/kvm/kvm_mips_stats.c
> 
> diff --git a/arch/mips/kvm/kvm_mips_stats.c b/arch/mips/kvm/kvm_mips_stats.c
> new file mode 100644
> index 0000000..e442a26
> --- /dev/null
> +++ b/arch/mips/kvm/kvm_mips_stats.c
> @@ -0,0 +1,81 @@
> +/*
> +* This file is subject to the terms and conditions of the GNU General Public
> +* License.  See the file "COPYING" in the main directory of this archive
> +* for more details.
> +*
> +* KVM/MIPS: COP0 access histogram
> +*
> +* Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
> +* Authors: Sanjay Lal <sanjayl@kymasys.com>
> +*/
> +
> +#include <linux/kvm_host.h>
> +
> +char *kvm_mips_exit_types_str[MAX_KVM_MIPS_EXIT_TYPES] = {
> +	"WAIT",
> +	"CACHE",
> +	"Signal",
> +	"Interrupt",
> +	"COP0/1 Unusable",
> +	"TLB Mod",
> +	"TLB Miss (LD)",
> +	"TLB Miss (ST)",
> +	"Address Err (ST)",
> +	"Address Error (LD)",
> +	"System Call",
> +	"Reserved Inst",
> +	"Break Inst",
> +	"D-Cache Flushes",
> +};
> +
> +char *kvm_cop0_str[N_MIPS_COPROC_REGS] = {
> +	"Index",
> +	"Random",
> +	"EntryLo0",
> +	"EntryLo1",
> +	"Context",
> +	"PG Mask",
> +	"Wired",
> +	"HWREna",
> +	"BadVAddr",
> +	"Count",
> +	"EntryHI",
> +	"Compare",
> +	"Status",
> +	"Cause",
> +	"EXC PC",
> +	"PRID",
> +	"Config",
> +	"LLAddr",
> +	"Watch Lo",
> +	"Watch Hi",
> +	"X Context",
> +	"Reserved",
> +	"Impl Dep",
> +	"Debug",
> +	"DEPC",
> +	"PerfCnt",
> +	"ErrCtl",
> +	"CacheErr",
> +	"TagLo",
> +	"TagHi",
> +	"ErrorEPC",
> +	"DESAVE"
> +};
> +
> +int kvm_mips_dump_stats(struct kvm_vcpu *vcpu)
> +{
> +	int i, j __unused;
> +#ifdef CONFIG_KVM_MIPS_DEBUG_COP0_COUNTERS
> +	printk("\nKVM VCPU[%d] COP0 Access Profile:\n", vcpu->vcpu_id);
> +	for (i = 0; i < N_MIPS_COPROC_REGS; i++) {
> +		for (j = 0; j < N_MIPS_COPROC_SEL; j++) {
> +			if (vcpu->arch.cop0->stat[i][j])
> +				printk("%s[%d]: %lu\n", kvm_cop0_str[i], j,
> +				       vcpu->arch.cop0->stat[i][j]);
> +		}
> +	}
> +#endif
> +
> +	return 0;
> +}
You need to use ftrace event for that. Much more flexible with perf
integration and no need to recompile to enabled/disable.

--
			Gleb.
