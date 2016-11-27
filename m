Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Nov 2016 22:19:39 +0100 (CET)
Received: from mail-io0-f194.google.com ([209.85.223.194]:34947 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993209AbcK0VTcRAGIO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 27 Nov 2016 22:19:32 +0100
Received: by mail-io0-f194.google.com with SMTP id h133so19097327ioe.2;
        Sun, 27 Nov 2016 13:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=orOXaPR0sByGBpALnZm1BARXl9NEUfUexVXUuVcyTCg=;
        b=uqQtPGSxLylIcyPcTh3jdpTcZM1oruENjnRgFnuzfOawdAi7kJt0Sht/GTOcX+oqkc
         0Owqp91/SqTeISXXA2kVMjhygDHTgtH9R5TJgzWVgr/qwC3PBNi31qYI3IOcvCQHtHEv
         gCM9goLRCRnsJ8QvukCfhNEL2FXO3wBXNtO1bNQpwgXBAx0HgzFD9vQEjxEqvDePaZgj
         pJMEF0rzZenIMCLWegJcYZIrhaRAzRebELmtMgQAdkm97Xk6fEtSj5UXcuR8R8C8EDt6
         OYTW5f5Zky3Kt1rwanCI31XeqwAOWP/OyVCmuvDDZmVghuj1FMDR37tj6Du3p9I6Za9s
         f0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=orOXaPR0sByGBpALnZm1BARXl9NEUfUexVXUuVcyTCg=;
        b=ZHCdb+NcHzBodBWf5SgS/rOyP/7PKAGgr2QdwYeHW5ZK9fjVGy5yqKGckTexuijLGH
         5xAIMhSd8XNDAR5HzuhoxLQy1Na+ZUqCLCT+Rtax41jTn0ylPPHQbRB3YxFFhqHoj1Ff
         I1Co0a7WFiEPNQbMq/kNqORBfaOw60ujiPJ05w/HrLYCyuce/cdNN9GJSaW+0ixcfQzn
         eTLacPD/wH9EtNViL4CzESF1IPquEhfnhUzLDH9qye6zQeNYKQ1jh1LbqOA5IY388p2c
         HXrXNxKGyfEsYgT2GHtIIZ24ZX/8OMdE/u6THXVeX4H9SJYsZJY7E56rK2SG0VE7TigX
         wXSA==
X-Gm-Message-State: AKaTC03iosHAQsl8ms7lJcEuR1G1yqNCsfqnKHAF5LKX/SI5PtrsZJZ6Gm8FGKu4vOiVLQ==
X-Received: by 10.107.33.194 with SMTP id h185mr15649884ioh.18.1480281566182;
        Sun, 27 Nov 2016 13:19:26 -0800 (PST)
Received: from ?IPv6:2001:470:d:73f:8457:d23d:8f69:e2d6? ([2001:470:d:73f:8457:d23d:8f69:e2d6])
        by smtp.googlemail.com with ESMTPSA id l3sm8221193iti.3.2016.11.27.13.19.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Nov 2016 13:19:25 -0800 (PST)
Subject: Re: [PATCH 2/3] MIPS: Don't writeback when cache-invalidating DMA
 buffers
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
References: <20161125184611.28396-1-paul.burton@imgtec.com>
 <20161125184611.28396-3-paul.burton@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <094dfd60-a5e8-719c-4180-1abc286a7e51@gmail.com>
Date:   Sun, 27 Nov 2016 13:19:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161125184611.28396-3-paul.burton@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55900
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
> The DMA API should not be used to map memory which isn't cache-line
> aligned. To quote Documentation/DMA-API.txt:
> 
>   Warnings:  Memory coherency operates at a granularity called the cache
>   line width.  In order for memory mapped by this API to operate
>   correctly, the mapped region must begin exactly on a cache line
>   boundary and end exactly on one (to prevent two separately mapped
>   regions from sharing a single cache line).  Since the cache line size
>   may not be known at compile time, the API will not enforce this
>   requirement.  Therefore, it is recommended that driver writers who
>   don't take special care to determine the cache line size at run time
>   only map virtual regions that begin and end on page boundaries (which
>   are guaranteed also to be cache line boundaries).
> 
> The MIPS L2 cache code has until now attempted to work around unaligned
> cache maintenance by writing back the first & last lines of a region to
> be invalidated. This is problematic however, because if we access either
> line after our initial invalidate call & before the DMA completes we'll
> cause the cache line to become valid & thus see stale data unless we go
> on to perform a second invalidate on systems where
> cpu_needs_post_dma_flush() == 1. In such systems we still have problems
> because if we wrote to either cache line causing it to become dirty then
> the writeback of it would clobber the data that was written to memory by
> the device performing DMA.
> 
> Fix this by removing the bogus writebacks in the L2 cache invalidate
> code when the region is aligned. If cache invalidation functions are
> invoked on a region which is not cacheline-aligned then produce a
> warning and proceed to perform the writebacks despite them being
> technically incorrect, in an attempt to both allow broken drivers to
> continue to "work" whilst being annoying enough to cause people to fix
> them. Ideally at some point we'd remove the writebacks entirely, but at
> least leaving them for now will let broken drivers stand a chance of
> continuing to work as we find & fix anything that begins emitting
> warnings over the next cycle or two.
> 
> In an ideal world we would also check that the size of the memory region
> we're performing cache maintenance upon is aligned, however this
> generates a great deal of noise from drivers which kmalloc a region of
> memory & then map some subset of it using the dma_map_* APIs. These
> callers will work fine due to kmalloc providing suitably aligned memory,
> but because they don't know that kmalloc may have padded out the region
> they requested they don't tell the DMA API the actual size of the region
> & we instead see the size that they requested. This leads to all sorts
> of noise from many many drivers & subsystems so settle for only checking
> the base address of the region.
> 
> A further limitation is that we'd ideally check the alignment for
> writeback & invalidate operations, since DMA buffers that we write to &
> devices read from ought to be cache-line aligned too in order to satisfy
> the documented requirements of the DMA API. However there is a fair
> amount of code which violates this alignment requirement, most notably
> core networking code which seems to routinely map unaligned regions via
> skb_frag_dma_map(). Since this would be rather invasive to change and
> the writebacks aren't harmful/lossy, we ignore the writeback case for
> now too.
> 
> Although this fixes a bug introduced way back in v2.6.29 by commit
> a8ca8b64e3fd ("MIPS: Avoid destructive invalidation on partial
> cachelines."), which has since been undone, and commit 96983ffefce4
> ("MIPS: MIPSxx SC: Avoid destructive invalidation on partial L2
> cachelines.") which hasn't, I have not marked this for stable since it
> can trigger large numbers of warnings in systems which have not fixed up
> their drivers to correctly align buffers, and presumably the bulk of
> systems in the wild haven't hit this problem.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
