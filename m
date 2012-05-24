Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 May 2012 19:55:03 +0200 (CEST)
Received: from rcsinet15.oracle.com ([148.87.113.117]:22141 "EHLO
        rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903703Ab2EXRyy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 May 2012 19:54:54 +0200
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
        by rcsinet15.oracle.com (Sentrion-MTA-4.2.2/Sentrion-MTA-4.2.2) with ESMTP id q4OHsFp3007770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 24 May 2012 17:54:17 GMT
Received: from acsmt357.oracle.com (acsmt357.oracle.com [141.146.40.157])
        by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id q4OHsEnB016492
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 24 May 2012 17:54:14 GMT
Received: from abhmt104.oracle.com (abhmt104.oracle.com [141.146.116.56])
        by acsmt357.oracle.com (8.12.11.20060308/8.12.11) with ESMTP id q4OHsC1H000941;
        Thu, 24 May 2012 12:54:13 -0500
Received: from phenom.dumpdata.com (/209.6.85.33)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 May 2012 10:54:12 -0700
Received: by phenom.dumpdata.com (Postfix, from userid 1000)
        id D9E22402FB; Thu, 24 May 2012 13:47:41 -0400 (EDT)
Date:   Thu, 24 May 2012 13:47:41 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Alessandro Rubini <rubini@gnudd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        Giancarlo Asnaghi <giancarlo.asnaghi@st.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [PATCH] swiotlb: add "dma_attrs" argument to alloc and free, to
 match dma_map_ops
Message-ID: <20120524174741.GG24934@phenom.dumpdata.com>
References: <20120524114422.GA25950@mail.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120524114422.GA25950@mail.gnudd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Source-IP: acsinet22.oracle.com [141.146.126.238]
X-archive-position: 33447
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: konrad.wilk@oracle.com
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

On Thu, May 24, 2012 at 01:44:22PM +0200, Alessandro Rubini wrote:
> The alloc and free pointers within "struct dma_map_ops" receive a
> pointer to dma_attrs that was not present in the generic swiotlb
> functions.  For this reason, a few files had a local wrapper for the
> free function that just removes the attrs argument before calling the
> generic function.
> 
> This patch adds the extra argument to generic functions and removes
> such wrappers when they are no more needed.  This also fixes a
> compiler warning for sta2x11-fixup.c, that would have required yet
> another wrapper.
> 
> Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
> Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  arch/ia64/kernel/pci-swiotlb.c       |   11 ++---------
>  arch/mips/cavium-octeon/dma-octeon.c |    4 ++--
>  arch/unicore32/mm/dma-swiotlb.c      |   22 ++--------------------
>  arch/x86/kernel/pci-swiotlb.c        |   11 ++---------
>  arch/x86/pci/sta2x11-fixup.c         |    3 ++-
>  include/linux/swiotlb.h              |    7 ++++---
>  lib/swiotlb.c                        |    5 +++--

So .. what is this based on? I see in mainline  alloc_coherent and free_coherent
which are obviously changed here.

Don't you also need to change these two files:

 arch/x86/xen/pci-swiotlb-xen.c
 drivers/xen/swiotlb-xen.c
