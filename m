Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Nov 2012 12:47:10 +0100 (CET)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:48674 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823049Ab2KVLrJL6dXE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Nov 2012 12:47:09 +0100
Received: by mail-lb0-f177.google.com with SMTP id n10so4238218lbo.36
        for <linux-mips@linux-mips.org>; Thu, 22 Nov 2012 03:47:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=yJRZ7tfRsFCxk8KoP/XB93UhXdKibFvmhZr8rOZuUPg=;
        b=bwjBujIMZetbQV3pT4kej3M1Y02Ey2uipON5ASgMFH27tcd9FEmJMgfBkz4056jKZT
         ehQOBc9+/YyVNpOHcuvrp0lELcTeUupAnloz6SwzIZfHHtleQp2PFYp6kgFCIL/AuBKs
         eCGq/XewUfJU3PBzFwgTp3H0S1z6tv549mRVvaNjOftfL2T4Tzx+2TkIh2bHRl/lT2vI
         h92LjIFn0qctWlDO2wJRFrJ0sJ2M/ZKxb3S3qwNgetYcjSf7Huo3Q147EhnUfLoj+0SF
         6FWVXTPGQSPh6hJZbUvzWHRW0hZlNKqWq7Q2rkYkWRyfw8BGltGwdzGo8Rh/ZiDXnnxA
         0t7A==
Received: by 10.112.29.229 with SMTP id n5mr485910lbh.130.1353584823540;
        Thu, 22 Nov 2012 03:47:03 -0800 (PST)
Received: from [192.168.2.2] (ppp91-79-70-131.pppoe.mtu-net.ru. [91.79.70.131])
        by mx.google.com with ESMTPS id oz12sm1117087lab.17.2012.11.22.03.47.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Nov 2012 03:47:02 -0800 (PST)
Message-ID: <50AE1065.9080909@mvista.com>
Date:   Thu, 22 Nov 2012 15:45:41 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Sanjay Lal <sanjayl@kymasys.com>
CC:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 09/18] KVM/MIPS32: COP0 accesses profiling.
References: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com> <1353551656-23579-10-git-send-email-sanjayl@kymasys.com>
In-Reply-To: <1353551656-23579-10-git-send-email-sanjayl@kymasys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQnj0U9waN1r9wlG0nMZK2MgmgC4KqCgOG14sqK06LkUxmxxrhnFMxeCW4H/lq7ooJI7m4A1
X-archive-position: 35095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
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

Hello.

On 22-11-2012 6:34, Sanjay Lal wrote:

> Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
> ---
>   arch/mips/kvm/kvm_mips_stats.c | 81 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 81 insertions(+)
>   create mode 100644 arch/mips/kvm/kvm_mips_stats.c

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

    I guess it should be "Error" in both cases.

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

    EntryHi.

> +int kvm_mips_dump_stats(struct kvm_vcpu *vcpu)
> +{
> +	int i, j __unused;

    Empty line after declarations wouldn't hurt.

> +#ifdef CONFIG_KVM_MIPS_DEBUG_COP0_COUNTERS

WBR, Sergei
