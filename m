Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2017 11:19:22 +0200 (CEST)
Received: from mail-wr0-x242.google.com ([IPv6:2a00:1450:400c:c0c::242]:36153
        "EHLO mail-wr0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992111AbdFTJTLs1352 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jun 2017 11:19:11 +0200
Received: by mail-wr0-x242.google.com with SMTP id 77so16546688wrb.3
        for <linux-mips@linux-mips.org>; Tue, 20 Jun 2017 02:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RT8xhX7Kl/bRpb+ZIQXTuflmmK0MiiKKO1tsrc1ezAA=;
        b=CMk7dKePtws7BOKRA9LJPaR8ZrsscuASSh6iuT3KAgHD99jGd+xIqzKAh35lSsx7/X
         ODzUd2NXf7G9EvYMkDfzuGm2eC2KTh4Qa3m9K33wlCee6PTe04oN+fkzfKvBE+SYqrb5
         /04+wz+0CJIfluJV2uyTJmkiGOaPC+KOMPBf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=RT8xhX7Kl/bRpb+ZIQXTuflmmK0MiiKKO1tsrc1ezAA=;
        b=kjpETgIyuWCLdNLiAp+COn6+MQXN6A3JE1fZAY3p+eySo3YzxY0p+SOD6LtKQGBVD2
         6vJ8UdEoCXC/7amPXVcS//kDXDcIKVTRhemenm7mJr/N/9NLOHP41/AIDopl4wmgCW1S
         GQU2aPYlhSKRSyNxP+UP8YnOspsNZff5eWK5TbDOsW/EqTGyKqJxPfFIDoTGl+b1tY0F
         1bPLERJO4dFdN8/4hTgT3jrYCs3erKnf9x4hEAJ9P9AtLyPQsOiaCSHf9bGigqgEhZPG
         K1F5lkqx7YgRoxmwwl1wk7COVFjMns8i3eDrXr+J0SIivJT0s7USp/rvOuwTviJGgIzL
         82ew==
X-Gm-Message-State: AKS2vOzWcwGrGxk+5kBmINp5d7JKIWDmj0+ohOx19sCQ+Sg/zCFK35MQ
        F5UUolBBtO/15ffq
X-Received: by 10.223.145.78 with SMTP id j72mr18440561wrj.7.1497950346256;
        Tue, 20 Jun 2017 02:19:06 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5640:0:960b:2678:e223:c1c6])
        by smtp.gmail.com with ESMTPSA id y9sm16890744wry.32.2017.06.20.02.19.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Jun 2017 02:19:05 -0700 (PDT)
Date:   Tue, 20 Jun 2017 11:19:02 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christoph Hellwig <hch@lst.de>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: clean up and modularize arch dma_mapping interface
Message-ID: <20170620091902.2dldmf43vhazq6yh@phenom.ffwll.local>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20170608132609.32662-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170608132609.32662-1-hch@lst.de>
X-Operating-System: Linux phenom 4.9.0-2-amd64 
User-Agent: NeoMutt/20170306 (1.8.0)
Return-Path: <daniel@ffwll.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58680
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@ffwll.ch
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

On Thu, Jun 08, 2017 at 03:25:25PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> for a while we have a generic implementation of the dma mapping routines
> that call into per-arch or per-device operations.  But right now there
> still are various bits in the interfaces where don't clearly operate
> on these ops.  This series tries to clean up a lot of those (but not all
> yet, but the series is big enough).  It gets rid of the DMA_ERROR_CODE
> way of signaling failures of the mapping routines from the
> implementations to the generic code (and cleans up various drivers that
> were incorrectly using it), and gets rid of the ->set_dma_mask routine
> in favor of relying on the ->dma_capable method that can be used in
> the same way, but which requires less code duplication.
> 
> Btw, we don't seem to have a tree every-growing amount of common dma
> mapping code, and given that I have a fair amount of all over the tree
> work in that area in my plate I'd like to start one.  Any good reason
> to that?  Anyone willing to volunteer as co maintainer?
> 
> The whole series is also available in git:
> 
>     git://git.infradead.org/users/hch/misc.git dma-map

Ack for the 2 drm patches, but I can also pick them up through drm-misc if
you prefer that (but then it'll be 4.14).
-Daniel

> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-map
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
