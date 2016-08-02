Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Aug 2016 10:29:44 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:59424 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992990AbcHBI3d7hfqO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Aug 2016 10:29:33 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u728TSrS016397;
        Tue, 2 Aug 2016 10:29:28 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u728TNws016396;
        Tue, 2 Aug 2016 10:29:23 +0200
Date:   Tue, 2 Aug 2016 10:29:23 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Binbin Zhou <zhoubb@lemote.com>,
        James Hogan <james.hogan@imgtec.com>
Cc:     John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Chunbo Cui <cuichboo@163.com>, Huacai Chen <chenhc@lemote.com>
Subject: Re: [PATCH RESEND v4 7/9] MIPS: Loongson-1A: Enable SPARSEMEN and
 HIGHMEM
Message-ID: <20160802082923.GA15910@linux-mips.org>
References: <1463621912-9883-1-git-send-email-zhoubb@lemote.com>
 <1463621912-9883-6-git-send-email-zhoubb@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1463621912-9883-6-git-send-email-zhoubb@lemote.com>
User-Agent: Mutt/1.6.2 (2016-07-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54389
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

On Thu, May 19, 2016 at 09:38:30AM +0800, Binbin Zhou wrote:

> diff --git a/arch/mips/include/asm/sparsemem.h b/arch/mips/include/asm/sparsemem.h
> index b1071c1..f73e671 100644
> --- a/arch/mips/include/asm/sparsemem.h
> +++ b/arch/mips/include/asm/sparsemem.h
> @@ -11,7 +11,11 @@
>  #else
>  # define SECTION_SIZE_BITS	28
>  #endif
> -#define MAX_PHYSMEM_BITS	48
> +#ifdef CONFIG_64BIT
> +# define MAX_PHYSMEM_BITS	48
> +#else
> +# define MAX_PHYSMEM_BITS	36
> +#endif

This doesn't look right for XPA.  What do you think, James?

I think we don't use sparsemem on XPA atm so I can apply this safely -
but it should be fixed properly.

  Ralf
