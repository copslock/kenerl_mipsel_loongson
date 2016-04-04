Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2016 08:51:15 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:47568 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27025980AbcDDGvMpWZSH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Apr 2016 08:51:12 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u346pAd0014151;
        Mon, 4 Apr 2016 08:51:10 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u346pAOl014150;
        Mon, 4 Apr 2016 08:51:10 +0200
Date:   Mon, 4 Apr 2016 08:51:10 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Binbin Zhou <zhoubb@lemote.com>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Chunbo Cui <cuicb@lemote.com>, Huacai Chen <chenhc@lemote.com>
Subject: Re: [PATCH v3 3/8] MIPS: Loongson: Add platform devices for
 Loongson-1A/1B
Message-ID: <20160404065110.GB13706@linux-mips.org>
References: <1456793296-17120-1-git-send-email-zhoubb@lemote.com>
 <1456793296-17120-4-git-send-email-zhoubb@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1456793296-17120-4-git-send-email-zhoubb@lemote.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52856
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

On Tue, Mar 01, 2016 at 08:48:11AM +0800, Binbin Zhou wrote:

> Added basic platform devices for Loongson 1A, including serial port,
> ethernet, AHCI, USB, RTC, SPI and so on.
> 
> Most of the devices are shared with Loongson 1B, like serial port,
> ethernet, USB and so on.
> Specially, something like AHCI is only used in Loonson 1A.
                                                 ^^^^^^^

Loongson.

> Signed-off-by: Chunbo Cui <cuicb@lemote.com>
> Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/include/asm/mach-loongson32/irq.h       |   1 +
>  arch/mips/include/asm/mach-loongson32/loongson1.h | 167 +++++++++++--
>  arch/mips/include/asm/mach-loongson32/platform.h  |  11 +
>  arch/mips/loongson32/common/platform.c            | 290 +++++++++++++++++++++-
>  4 files changed, 441 insertions(+), 28 deletions(-)

How about switching the platform to DT?

  Ralf
