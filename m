Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Mar 2011 18:16:40 +0100 (CET)
Received: from mx1.netlogicmicro.com ([12.49.93.86]:3055 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491109Ab1CPRQh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Mar 2011 18:16:37 +0100
X-TM-IMSS-Message-ID: <25b6493300014da2@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 25b6493300014da2 ; Wed, 16 Mar 2011 10:16:30 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 16 Mar 2011 10:17:26 -0700
Date:   Wed, 16 Mar 2011 22:52:33 +0530
From:   "Jayachandran C." <jayachandranc@netlogicmicro.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 3/7] Add XLR/XLS cache and TLB support
Message-ID: <20110316172232.GG15774@jayachandranc.netlogicmicro.com>
References: <cover.1300275485.git.jayachandranc@netlogicmicro.com>
 <cadf7ed67683e96d920fedc87d8fc5d6dbdccdc7.1300275485.git.jayachandranc@netlogicmicro.com>
 <4D80EA02.9030605@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D80EA02.9030605@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 16 Mar 2011 17:17:26.0679 (UTC) FILETIME=[05AFB270:01CBE3FE]
Return-Path: <jayachandranc@netlogicmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips

On Wed, Mar 16, 2011 at 09:49:06AM -0700, David Daney wrote:
> On 03/16/2011 04:57 AM, Jayachandran C wrote:
> [...]
> >diff --git a/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h b/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h
> >new file mode 100644
> >index 0000000..7740401
> >--- /dev/null
> >+++ b/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h
> >@@ -0,0 +1,9 @@
> >+#ifndef __ASM_MACH_NETLOGIC_CPU_FEATURE_OVERRIDES_H
> >+#define __ASM_MACH_NETLOGIC_CPU_FEATURE_OVERRIDES_H
> >+
> >+/*
> >+ * Most of the properties are in cpu->options
> >+ */
> >+#define cpu_has_netlogic_cache	1
> >+
> >+#endif /* __ASM_MACH_NETLOGIC_CPU_FEATURE_OVERRIDES_H */
> 
> Although this will probably work, you will likely get better
> performance if you supply static default values for as many
> overrides as possible.

True, we will miss possible compile-time optimizations, will 
look at this.

Thanks!
JC.
-- 
Jayachandran C.
jayachandranc@netlogicmicro.com                  (Netlogic Microsystems)
jchandra@freebsd.org                               (The FreeBSD Project)
