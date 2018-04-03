Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Apr 2018 09:21:33 +0200 (CEST)
Received: from mail-qt0-x243.google.com ([IPv6:2607:f8b0:400d:c0d::243]:33335
        "EHLO mail-qt0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992971AbeDCHVZJ08du (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Apr 2018 09:21:25 +0200
Received: by mail-qt0-x243.google.com with SMTP id d50so10749714qtc.0;
        Tue, 03 Apr 2018 00:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=MAUpUrOux+E9Kj2s+qA6L+jP3EoLR0gCt+OZGasN/yE=;
        b=jYJ/V1yd3Dk0kbUv2QwKioyWF/oMBGaIF+hFyHMlF0WXnB9dR7PHt74a0yzqjDXfZx
         5Hb57zGt5lohITElz62ujFSE+YbH4j9o3xmlQCO53Cor1iB+BYmmp1nEOUqOHQ6KUjfF
         4+jTDhfbyLmNDHUbMv5FZKqJLia/ssID+Iyi0ImhunRYmJ+ltEY7feUVR1FkDGHx7KIQ
         OkOU+6pmur8tF6siUtMZZORTWMNjO8L05wt6iIrRfCTYLJOxlNi3FvCusb6u7wa00RtF
         6DQJT65WGomz1zf2/hROmf8U8fOanW7xkLM3VAEllg1lQWdbWYrZrUl/4QAycUUh5PSG
         NDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=MAUpUrOux+E9Kj2s+qA6L+jP3EoLR0gCt+OZGasN/yE=;
        b=Hf1K2d4Mp6d0feU/nm/Jn71uaroG+t+P5MYdMaEtbljcc7v8iJDiradOM7nPgSgbIP
         VhrN9mXGgp5Fbv/IV3YXgnB8e1WOTU2ua3W2LGJLPbMEnwVGPGO2CetvdF3aQqbKA7Jj
         CzjMjuRZmZvxwTpVshLCwLqcUoy0bOQg/78AK6W3HG21+vjmK/cFwnEwm0U2GMEW1Mm8
         U1iLG7G6Q5q0H/t4C8c41ZI2ZnLno3xaF5DlAk+f4WOX3akcYZRm2xfFcIzlP2EeYGoN
         EiN8I6WnsOy1IHOpyOwlkFW/74MSUAVX0A6+2SrO8EMT4x0xgAXr9we5D1l4STMoDUoH
         1QOg==
X-Gm-Message-State: ALQs6tBXa8WxEyy45LoxhRGchRHQ3+EYrVzH+pSHr3pbwCrvx3v9BwvB
        HZsITWL2RpETEuGL5zmLcE9QeKUS0vHOP3TIJ98=
X-Google-Smtp-Source: AIpwx4+s+QVlV/p5YqTuMvNLST/cE7+8tBcYFSHIJ7eS3uhWY5tpsgDfKrGZU/xT/LZpp38e17xfv6ECRYgZhnSbbXI=
X-Received: by 10.200.65.200 with SMTP id o8mr18934171qtm.75.1522740078822;
 Tue, 03 Apr 2018 00:21:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.185.25 with HTTP; Tue, 3 Apr 2018 00:21:18 -0700 (PDT)
In-Reply-To: <1522692821-27706-1-git-send-email-okaya@codeaurora.org>
References: <1522692821-27706-1-git-send-email-okaya@codeaurora.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 3 Apr 2018 09:21:18 +0200
X-Google-Sender-Auth: 4vuAMkavNvqcJuN-1jtqTL1uUc8
Message-ID: <CAK8P3a0WwhDoTdQNoxnpBVDZu8a7oKdB2tSjVRTRf3rrecEKMA@mail.gmail.com>
Subject: Re: [PATCH v2] MIPS: io: add a barrier after register read in readX()
To:     Sinan Kaya <okaya@codeaurora.org>
Cc:     "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Timur Tabi <timur@codeaurora.org>, sulrich@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Mon, Apr 2, 2018 at 8:13 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> While a barrier is present in writeX() function before the register write,
> a similar barrier is missing in the readX() function after the register
> read. This could allow memory accesses following readX() to observe
> stale data.
>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/mips/include/asm/io.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
> index 0cbf3af..7f9068d 100644
> --- a/arch/mips/include/asm/io.h
> +++ b/arch/mips/include/asm/io.h
> @@ -377,6 +377,7 @@ static inline type pfx##read##bwlq(const volatile void __iomem *mem)        \
>                 BUG();                                                  \
>         }                                                               \
>                                                                         \
> +       war_io_reorder_wmb();                                           \
>         return pfx##ioswab##bwlq(__mem, __val);                         \
>  }

I'm not sure if this is the right barrier: what we want here is a read
barrier to
prevent any following memory access from being prefetched ahead of the readl(),
so I would have expected a kind of rmb() rather than wmb().

The barrier you used here is defined as

#if defined(CONFIG_CPU_CAVIUM_OCTEON) || defined(CONFIG_LOONGSON3_ENHANCEMENT)
#define war_io_reorder_wmb()            wmb()
#else
#define war_io_reorder_wmb()            do { } while (0)
#endif

which appears to list the particular CPUs that have a reordering
write buffer. That may not be the same set of CPUs that have the
capability to do out-of-order loads.

       Arnd
