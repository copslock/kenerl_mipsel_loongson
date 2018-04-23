Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Apr 2018 06:31:39 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:53342 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991416AbeDWEbcCEe-x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Apr 2018 06:31:32 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 565546074C; Mon, 23 Apr 2018 04:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1524457885;
        bh=v0OFbGenpxDwlplaJAINF0A/dYLcUeDCoy4ReF67R0k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mv2bSFVrEmKtqYblsiXxBZ6hsvyhnM8lxN9OV12/zwqnqwOuk2r5Jlo+V1GCbn19q
         qHLkOUwMGoQfrJz2W/Xc5ZED+VvN0jCex/AgYoYe6zsZsKVwgKvv00VpuXFdWGe5KK
         OMLLopOjkD+UUJlqNlC/o7vnyuG6K7sCP0p1zMAw=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 660FE6070A;
        Mon, 23 Apr 2018 04:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1524457884;
        bh=v0OFbGenpxDwlplaJAINF0A/dYLcUeDCoy4ReF67R0k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KtpijYLjyQvshNjW8nexpgju66ufwfac/3kw2Xg8GNY/5+BhbGePewMEK8LuCxeUv
         v5lhDzxBNO/OjotAKxeHtfX/m8smm3drTFvpKbq/DvCif6uXFdZi0HudHFmTxMNvJX
         uqegJZbsa4mWiC9OePLEumhBX/Pi1Ku4zU5BqXWw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 23 Apr 2018 00:31:24 -0400
From:   okaya@codeaurora.org
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: io: Add barrier after register read in inX()
In-Reply-To: <1524455600-30384-1-git-send-email-chenhc@lemote.com>
References: <1524455600-30384-1-git-send-email-chenhc@lemote.com>
Message-ID: <c5a26d6f1e6ba35a4d45450adfa36aa3@codeaurora.org>
X-Sender: okaya@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Return-Path: <okaya@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63693
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: okaya@codeaurora.org
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

On 2018-04-22 23:53, Huacai Chen wrote:
> While a barrier is present in the outX() functions before the register
> write, a similar barrier is missing in the inX() functions after the
> register read. This could allow memory accesses following inX() to
> observe stale data.
> 
> This patch is very similar to commit a1cc7034e33d12dc1 ("MIPS: io: Add
> barrier after register read in readX()"). Because war_io_reorder_wmb()
> is both used by writeX() and outX(), if readX() need a barrier then so
> does inX().
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/include/asm/io.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
> index a7d0b83..cea8ad8 100644
> --- a/arch/mips/include/asm/io.h
> +++ b/arch/mips/include/asm/io.h
> @@ -414,6 +414,8 @@ static inline type pfx##in##bwlq##p(unsigned long 
> port)			\
>  	__val = *__addr;						\
>  	slow;								\
>  									\
> +	/* prevent prefetching of coherent DMA data prematurely */	\
> +	rmb();								\
>  	return pfx##ioswab##bwlq(__addr, __val);			\
>  }

Typically read barrier is applied after register read.
