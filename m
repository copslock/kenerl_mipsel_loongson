Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Aug 2013 19:09:08 +0200 (CEST)
Received: from mail-oa0-f53.google.com ([209.85.219.53]:42735 "EHLO
        mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825118Ab3HLRI4PdzUa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Aug 2013 19:08:56 +0200
Received: by mail-oa0-f53.google.com with SMTP id k18so10151110oag.12
        for <linux-mips@linux-mips.org>; Mon, 12 Aug 2013 10:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=lYnXa9ZsUfWTk2lqck+YkXj/eXaXNZYLtec1XMZIsxE=;
        b=h3YC0zZwojArpuSWgwwfIPDzk5XpF4WZJHxhJWMe8EY7x8iHBDRb2SdbPFauhQsMAX
         hmKstlCpPrpk8Vp+gdw8g5TNlk7nZimEaot9JU7ipAChZbRa4KYRKpVFTiSBYBGIzp2e
         O/yQYbevL1hg6AraHNBJtRcjnflUYeBGMVmPQ3TBofh6kE6PM4Emqs9B7OrJHqCPhPrr
         R2ykBFMUnH4KHs1HEVAPeGhe/W+vw8fMVfH4Y0M8+MmTY4vmHmbY5ANKdvz1nqwn7Xp9
         q6DT7pdm47uFtsTU6cRLrZxynaMcQ4oF/gpy797wLwtrK/kO/y2L4R7IRWUn15Kw1efv
         chSw==
X-Received: by 10.182.204.72 with SMTP id kw8mr2277089obc.54.1376327330091;
        Mon, 12 Aug 2013 10:08:50 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id pt4sm34337356obb.14.2013.08.12.10.08.48
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 12 Aug 2013 10:08:49 -0700 (PDT)
Message-ID: <5209169F.5070709@gmail.com>
Date:   Mon, 12 Aug 2013 10:08:47 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Felix Fietkau <nbd@openwrt.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: partially inline dma ops
References: <1376306569-83278-1-git-send-email-nbd@openwrt.org> <1376306569-83278-2-git-send-email-nbd@openwrt.org>
In-Reply-To: <1376306569-83278-2-git-send-email-nbd@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37533
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

On 08/12/2013 04:22 AM, Felix Fietkau wrote:
> Several DMA ops are no-op on many platforms, and the indirection through
> the mips_dma_map_ops function table is causing the compiler to emit
> unnecessary code.
>
> Inlining visibly improves network performance in my tests (on a 24Kc
> based system), and also slightly reduces code size of a few drivers.
>
> Signed-off-by: Felix Fietkau <nbd@openwrt.org>
> ---
>   arch/mips/Kconfig                   |   4 +
>   arch/mips/include/asm/dma-mapping.h | 360 +++++++++++++++++++++++++++++++++++-
>   arch/mips/mm/dma-default.c          | 161 ++--------------
>   3 files changed, 372 insertions(+), 153 deletions(-)
>

That is not a very pleasing diffstat.


David
