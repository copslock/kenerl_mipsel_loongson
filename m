Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 May 2012 17:15:32 +0200 (CEST)
Received: from mail-gg0-f177.google.com ([209.85.161.177]:61983 "EHLO
        mail-gg0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903703Ab2EXPP2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 May 2012 17:15:28 +0200
Received: by ggcs5 with SMTP id s5so8869376ggc.36
        for <multiple recipients>; Thu, 24 May 2012 08:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=r19tiiCVT9ZOr090sa54p1G313HDJ2LiTJvs//sZ8YM=;
        b=M1bapl4z/heQhFRICl3Qoi4pHnrF8q3z24rHEWI6sOVnnrK4JhzLOvX80gDUem/5HX
         bcmrOA9TMyh95eXgRbi9plqnmpnxXKuzWH7r2otw2D4lAORMEwjFNuZDK8m6EkOQm7AE
         vUOsVfN/BAb9If/sJsb/xW8pPXMN01CDmKniZPfi9AQ1QORlrCJMl4riK1RNlKCocYM8
         jUuPxc/55k5xfUht0o5LNPL+0/p9RwjauSNhYHjqcunnhx4GeTUNEFXQ+G5afHJ1CQ8V
         IcRkcSkereycXLjJ4ZOQNuKLprqv++QuK167Z7ZdAhHlfZjqtW2OJP75HKJRutkLPAm/
         YIOw==
Received: by 10.68.191.230 with SMTP id hb6mr22010509pbc.57.1337872521005;
        Thu, 24 May 2012 08:15:21 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id wo8sm5773164pbc.9.2012.05.24.08.15.18
        (version=SSLv3 cipher=OTHER);
        Thu, 24 May 2012 08:15:19 -0700 (PDT)
Message-ID: <4FBE5085.2090904@gmail.com>
Date:   Thu, 24 May 2012 08:15:17 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Alessandro Rubini <rubini@gnudd.com>
CC:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        Giancarlo Asnaghi <giancarlo.asnaghi@st.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] swiotlb: add "dma_attrs" argument to alloc and free,
 to match dma_map_ops
References: <20120524114422.GA25950@mail.gnudd.com>
In-Reply-To: <20120524114422.GA25950@mail.gnudd.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 33445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 05/24/2012 04:44 AM, Alessandro Rubini wrote:
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
> Signed-off-by: Alessandro Rubini<rubini@gnudd.com>
> Acked-by: Giancarlo Asnaghi<giancarlo.asnaghi@st.com>
> Cc: Tony Luck<tony.luck@intel.com>
> Cc: Fenghua Yu<fenghua.yu@intel.com>
> Cc: Ralf Baechle<ralf@linux-mips.org>
> Cc: Guan Xuetao<gxt@mprc.pku.edu.cn>
> Cc: Thomas Gleixner<tglx@linutronix.de>
> Cc: Kyungmin Park<kyungmin.park@samsung.com>
> Cc: FUJITA Tomonori<fujita.tomonori@lab.ntt.co.jp>
> Cc: Konrad Rzeszutek Wilk<konrad.wilk@oracle.com>
> ---
>   arch/ia64/kernel/pci-swiotlb.c       |   11 ++---------
>   arch/mips/cavium-octeon/dma-octeon.c |    4 ++--
>   arch/unicore32/mm/dma-swiotlb.c      |   22 ++--------------------
>   arch/x86/kernel/pci-swiotlb.c        |   11 ++---------
>   arch/x86/pci/sta2x11-fixup.c         |    3 ++-
>   include/linux/swiotlb.h              |    7 ++++---
>   lib/swiotlb.c                        |    5 +++--
>   7 files changed, 17 insertions(+), 46 deletions(-)
>

This looks sane (although I haven't tested it).  For the OCTEON bits:

Acked-by: David Daney <david.daney@cavium.com>
