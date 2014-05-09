Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 May 2014 17:58:15 +0200 (CEST)
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:7511 "EHLO
        mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6854774AbaEIP6NRF6FP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 May 2014 17:58:13 +0200
X-IronPort-AV: E=Sophos;i="4.97,1019,1389772800"; 
   d="scan'208";a="28568080"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw2-out.broadcom.com with ESMTP; 09 May 2014 09:24:50 -0700
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Fri, 9 May 2014 08:58:05 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP Server id
 14.3.174.1; Fri, 9 May 2014 08:58:06 -0700
Received: from jayachandranc.netlogicmicro.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 964545D818;    Fri,  9 May 2014 08:58:01 -0700 (PDT)
Date:   Fri, 9 May 2014 21:35:09 +0530
From:   Jayachandran C. <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     <ralf@linux-mips.org>
Subject: Re: [PATCH RFC 0/5] Mapped kernel support for Broadcom XLP
Message-ID: <20140509160508.GA14124@jayachandranc.netlogicmicro.com>
References: <1399649304-25856-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1399649304-25856-1-git-send-email-jchandra@broadcom.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40061
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

On Fri, May 09, 2014 at 08:58:20PM +0530, Jayachandran C wrote:
> This patchset adds support for loading a XLR/XLP kernel compiled with a
> CKSEG2 load address.
> 
> The changes are to:
>  - move the existing MAPPED_KERNEL option from sgi-ip27 to common config
>  - Add a plat_mem_fixup function to arch_mem_init which will allow
>    the platform to calculate the kernel wired TLB entries and save
>    them so that all the CPUs can set them up at boot.
>  - Update PAGE_OFFSET, MAP_BASE and MODULE_START when mapped kernel
>    is enabled.
>  - Update compressed kernel code to generate the final executable in
>    KSEG0 and map the load address of the embedded kernel before loading
>    it.
>  - Use wired entries of sizes 256M/1G/4G to map the available memory on
>    XLP9xx and XLP2xx
> 
> Comments and suggestions welcome.

Looks like I missed a patch while sending this out. Will send the full
patchset again (and fix it up in patchwork).

JC.
