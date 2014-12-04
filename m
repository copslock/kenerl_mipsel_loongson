Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Dec 2014 06:51:22 +0100 (CET)
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:46782 "EHLO
        mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006942AbaLDFvUxDTYY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Dec 2014 06:51:20 +0100
X-IronPort-AV: E=Sophos;i="5.07,513,1413270000"; 
   d="scan'208";a="52081010"
Received: from irvexchcas07.broadcom.com (HELO IRVEXCHCAS07.corp.ad.broadcom.com) ([10.9.208.55])
  by mail-gw3-out.broadcom.com with ESMTP; 03 Dec 2014 22:00:35 -0800
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Wed, 3 Dec 2014 21:51:23 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.3.174.1; Wed, 3 Dec 2014 21:51:23 -0800
Received: from jayachandranc.netlogicmicro.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 1828D40FE5;    Wed,  3 Dec 2014 21:50:39 -0800 (PST)
Date:   Thu, 4 Dec 2014 11:25:58 +0530
From:   Jayachandran C. <jchandra@broadcom.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Lars Persson <lars.persson@axis.com>,
        David Daney <ddaney.cavm@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Remove race window in page fault handling
Message-ID: <20141204055557.GF6017@jayachandranc.netlogicmicro.com>
References: <1401532566-22929-1-git-send-email-larper@axis.com>
 <538CAAA6.90509@gmail.com>
 <771471B8871B5044A6CA7CCD9C26EEE10117E31EC89D@xmail2.se.axis.com>
 <20141203133729.GB16063@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20141203133729.GB16063@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44570
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

On Wed, Dec 03, 2014 at 02:37:29PM +0100, Ralf Baechle wrote:
> On Tue, Jun 03, 2014 at 12:29:17PM +0200, Lars Persson wrote:
> 
> > Good point. Would adding !cpu_has_ic_fills_f_dc as an extra condition in set_pte_at be sufficient to address your concern ?
> 
> Returning to this old thread ...
> 
> cpu_has_ic_fills_f_dc means a CPU's data cache does not need to be
> written back to secondary cache or memory when instructions have been
> updated in memory.  In other words a CPU can refill the I-cache from
> the D-cache on an I-cache miss.
> 
> Only the Alchemy cores have this handy property.
> 
> The flag is also being set for XL? CPUs in
> 
>   arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h
> 
> but not anywhere in the probe code of arch/mips/mm/c-r4k.c which might
> stil be correct - but it's at least a bit sloppy and suspicious so I'm
> wondering if it's correct indeed.  Jayachandran?

On XLR/XLP, L1 Dcache is coherent and L1 Icache is not. We don't need to
flush dcache when we change an executable page or range, just an icache
flush is sufficient. At least in c-r4k.c, setting cpu_has_ic_fills_f_dc
did what we needed.

There were 2 issues, one is the usage in copy_to_user_page, for which
a patch was posted http://patchwork.linux-mips.org/patch/6122/
(we are using this patch). Another is that we might need a "sync" before
the icache flush.

JC.
