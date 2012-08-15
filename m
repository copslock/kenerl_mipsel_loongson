Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Aug 2012 23:31:38 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:33068 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903476Ab2HOVbc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Aug 2012 23:31:32 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q7FLVTD3022263;
        Wed, 15 Aug 2012 23:31:29 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q7FLVQMv022262;
        Wed, 15 Aug 2012 23:31:26 +0200
Date:   Wed, 15 Aug 2012 23:31:26 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH V5 13/18] drm: Define SAREA_MAX for Loongson (PageSize =
 16KB).
Message-ID: <20120815213126.GC15844@linux-mips.org>
References: <1344677543-22591-1-git-send-email-chenhc@lemote.com>
 <1344677543-22591-14-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1344677543-22591-14-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34184
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sat, Aug 11, 2012 at 05:32:18PM +0800, Huacai Chen wrote:

> Subject: [PATCH V5 13/18] drm: Define SAREA_MAX for Loongson (PageSize = 16KB).

But your code doesn't define it just for Loongsson as the log message claims
but rather for all MIPS.

> diff --git a/include/drm/drm_sarea.h b/include/drm/drm_sarea.h
> index ee5389d..1d1a858 100644
> --- a/include/drm/drm_sarea.h
> +++ b/include/drm/drm_sarea.h
> @@ -37,6 +37,8 @@
>  /* SAREA area needs to be at least a page */
>  #if defined(__alpha__)
>  #define SAREA_MAX                       0x2000U
> +#elif defined(__mips__)
> +#define SAREA_MAX                       0x4000U

How about replacing this whole #ifdef mess with something like:

#include <linux/kernel.h>
#include <asm/page.h>

/* Intel 830M driver needs at least 8k SAREA */
#define SAREA_MAX	max(PAGE_SIZE, 0x2000U)

MIPS also uses 64K page size and your patch as posted would break with 64k
pages.

  Ralf
