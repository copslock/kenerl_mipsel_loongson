Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2016 08:43:59 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:47142 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27025935AbcDDGnzgOrtH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Apr 2016 08:43:55 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u346hqw1013994;
        Mon, 4 Apr 2016 08:43:52 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u346hnHs013993;
        Mon, 4 Apr 2016 08:43:49 +0200
Date:   Mon, 4 Apr 2016 08:43:49 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Binbin Zhou <zhoubb@lemote.com>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Chunbo Cui <cuicb@lemote.com>, Huacai Chen <chenhc@lemote.com>
Subject: Re: [PATCH v3 2/8] MIPS: Loongson: Add Loongson-1A Kconfig options
Message-ID: <20160404064349.GA13706@linux-mips.org>
References: <1456793296-17120-1-git-send-email-zhoubb@lemote.com>
 <1456793296-17120-3-git-send-email-zhoubb@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1456793296-17120-3-git-send-email-zhoubb@lemote.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52855
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

On Tue, Mar 01, 2016 at 08:48:10AM +0800, Binbin Zhou wrote:

> diff --git a/arch/mips/loongson32/Kconfig b/arch/mips/loongson32/Kconfig
> index 7704f20..741867c 100644
> --- a/arch/mips/loongson32/Kconfig
> +++ b/arch/mips/loongson32/Kconfig
> @@ -1,8 +1,28 @@
>  if MACH_LOONGSON32
>  
> +config ZONE_DMA
> +	prompt "Zone DMA"
> +	bool
> +

There is already a ZONE_DMA option in arch/mips/Kconfig.  Do you really
need ZONE_DMA?  Even if so I suggest to not present this option to the
user interactively but enable it with a select - normal users building
a kernel will probably not know what ZONE_DMA is.

  Ralf
