Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Nov 2016 22:15:14 +0100 (CET)
Received: from mail-oi0-f54.google.com ([209.85.218.54]:32812 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993045AbcK0VPHTns3O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 27 Nov 2016 22:15:07 +0100
Received: by mail-oi0-f54.google.com with SMTP id w63so130860214oiw.0;
        Sun, 27 Nov 2016 13:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=S9zOhElFp15MSQYo3jH7Y1c61W9jLQmT/h/BHZJhecw=;
        b=G0kiuHrUeQG/BLCNtTLQOtE1+UMvNU1vvUogMOnDvFjtGUbfPar5vNIQXkrCwQ2Qfs
         EqCrxpLViVYFRgI2ppsTVslfo+fiep+GOkRkC8oEak7FfExB35qLE2c12iqMwygLrC+Z
         bGgMJrS8qjYtjKrVdIB/CjOU46uFghYSLpiN33OPseoDxoD1GpCa8HkFO/2AOMhdOXxE
         R2z2L35XNK3ndrSeoGyGkfTRqtPEhyIKrUXeeKqnm8SU4rL7PSpjOXTAyecMD8mP+a7d
         wBNqS/PaOnk+6M0WQuWiLpY3raj+pbCLwl1G7Px+IWVKD5PZTRRtudde2v3n9O8KJAyb
         Kslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=S9zOhElFp15MSQYo3jH7Y1c61W9jLQmT/h/BHZJhecw=;
        b=DbYU/dEBd2deM0Kaz4DpEfJURnQwGNcIRVCwKImeNabRwwSPEtgU49Pl9jtWUtr8ZK
         hQ3oArGClTLY2aX7gxy+tzwi/LnomQFx5ZOtxIqQWn2qNkMx72Y7wDmK2RacJwPOwHBK
         PT6gTTKsDjDYwZBlR0lQ0qlufgxvvHHNF0eGJLdxY1xKPdTCLn7S2dRuaiPmJfGSvZWo
         1hrOSUGcs4LvOVDvAotFiPKDJAq6MTWrskRDDJ5lw6ZQQgXAcgehntK9NN1dEKa1Rwlm
         k6lvUqa0SLeWS+TshV/9QbGZEy2hLgeB208daT/pY5JDlLtXzTwwOwtZm3BEVINyjlTy
         pQCg==
X-Gm-Message-State: AKaTC00+ka/CvomZwdOz1OJ8Q76BNvPIHaM9abTBFl8f5NLfGAiM6WqJuu+V5GuFgnb8gA==
X-Received: by 10.202.71.207 with SMTP id u198mr9129281oia.165.1480281301332;
        Sun, 27 Nov 2016 13:15:01 -0800 (PST)
Received: from ?IPv6:2001:470:d:73f:8457:d23d:8f69:e2d6? ([2001:470:d:73f:8457:d23d:8f69:e2d6])
        by smtp.googlemail.com with ESMTPSA id a65sm16683962oih.6.2016.11.27.13.15.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Nov 2016 13:15:00 -0800 (PST)
Subject: Re: [PATCH 3/3] MIPS: Sanitise DMA unmapping cache sync operations
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
References: <20161125184611.28396-1-paul.burton@imgtec.com>
 <20161125184611.28396-4-paul.burton@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <446105e0-63a7-cba9-6c83-6dee8132bde9@gmail.com>
Date:   Sun, 27 Nov 2016 13:14:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161125184611.28396-4-paul.burton@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55898
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Le 25/11/2016 à 10:46, Paul Burton a écrit :
> The behaviour of mips_dma_unmap_page() & mips_dma_unmap_sg() with
> regards to cache maintenance differ for no good reason. Whilst
> mips_dma_unmap_page() correctly takes into account whether a CPU may
> have speculatively prefetched data into caches by using
> cpu_needs_post_dma_flush(), it ignores the direction of the DMA transfer
> & thus performs cache maintenance after DMA_TO_DEVICE transfers for no
> good reason. Meanwhile mips_dma_unmap_sg() avoids unnecessary cache
> maintenance for DMA_TO_DEVICE transfers but performs unnecessary cache
> maintenance on CPUs which cannot have speculatively fetched data into
> the caches.
> 
> Fix this by using the same condition for cache maintenance in both
> mips_dma_unmap_page() & mips_dma_unmap_sg(). We perform cache
> maintenance when unmapping if and only if both:
> 
>   - cpu_needs_post_dma_flush() returns true, indicating that the device
>     performing DMA is not cache-coherent and the CPU may speculatively
>     prefetch data from memory being DMAed to.
> 
>   - The direction of the DMA is not DMA_TO_DEVICE, meaning that the
>     device may have written to memory & we should invalidate our cached
>     view in order to observe whatever the device wrote.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
