Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2012 23:20:26 +0200 (CEST)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:49618 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903668Ab2C0VUM convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 27 Mar 2012 23:20:12 +0200
Received: by iaky10 with SMTP id y10so495838iak.36
        for <linux-mips@linux-mips.org>; Tue, 27 Mar 2012 14:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AL41A/CipD4grjfRNMvDofHgBc47Ii7R4haTHNx+j7Y=;
        b=WSVbkLKVKugYFsdwKDcZJjqvNrt/vgnhT0LioOy76EHXcJB6wPViqYhRDeBqd7p1cq
         QEKKBAlC1xUresllHcMrj/8lvLF+nPvmP4AaNfS9LVUtnMlj2/oz+sy0nf0eMuS2T3NB
         PuQqDXw8v908qj0kewaU/Izw5RyaBwm+TnATyAOm6SILioR1TWuCU09a/Zu2RqGDFuR1
         LaZvSuhPCkmfZxbpeElc5K1V6myOccPhGNbJXbMJtU5R7uY6QpKJjk+S/CgaBQMY/jOh
         +iMTUsM4vuGDztZAxeWjWdXRqQNc4oGr/C5y1g6RvARS3O3imthDjIAiy+yX3tLS2dWB
         lCiQ==
MIME-Version: 1.0
Received: by 10.43.51.10 with SMTP id vg10mr16402919icb.11.1332883205384; Tue,
 27 Mar 2012 14:20:05 -0700 (PDT)
Received: by 10.42.115.68 with HTTP; Tue, 27 Mar 2012 14:20:05 -0700 (PDT)
In-Reply-To: <1324643253-3024-6-git-send-email-m.szyprowski@samsung.com>
References: <1324643253-3024-1-git-send-email-m.szyprowski@samsung.com>
        <1324643253-3024-6-git-send-email-m.szyprowski@samsung.com>
Date:   Tue, 27 Mar 2012 14:20:05 -0700
X-Google-Sender-Auth: f7E4OaokyPRw3lkbP3PGUjIEWjo
Message-ID: <CA+8MBbLAafFbVwviFmkjD0DNz5RsCbB_TNLL67wEi2k-hyXkXA@mail.gmail.com>
Subject: Re: [PATCH 05/14] IA64: adapt for dma_map_ops changes
From:   Tony Luck <tony.luck@intel.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        microblaze-uclinux@itee.uq.edu.au, linux-arch@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mips@linux-mips.org, discuss@x86-64.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linaro-mm-sig@lists.linaro.org, Jonathan Corbet <corbet@lwn.net>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 32794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tony.luck@intel.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, Dec 23, 2011 at 4:27 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> From: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
>
> Adapt core IA64 architecture code for dma_map_ops changes: replace
> alloc/free_coherent with generic alloc/free methods.
>
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/ia64/hp/common/sba_iommu.c     |   11 ++++++-----
>  arch/ia64/include/asm/dma-mapping.h |   18 ++++++++++++------
>  arch/ia64/kernel/pci-swiotlb.c      |    9 +++++----
>  arch/ia64/sn/pci/pci_dma.c          |    9 +++++----
>  4 files changed, 28 insertions(+), 19 deletions(-)

The series breaks bisection from part 2 (when the x86 part changes
lib/swiotlb.c)
until part 5 (when ia64 sees the changes to match).  You could either merge part
5 into part 2 (to make a combined x86+ia64 piece) ... or try to pull
the libswiotlb
changes into their own piece (which would have some of the ia64 and x86 bits).
Or at the very least minimize the breakage window by putting ia64
right after x86
in the patch sequence.

Otherwise seems OK

Acked-by: Tony Luck <tony.luck@intel.com>
