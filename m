Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Aug 2016 20:07:31 +0200 (CEST)
Received: from mail-it0-f51.google.com ([209.85.214.51]:36967 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992195AbcH1SHYc5xOA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Aug 2016 20:07:24 +0200
Received: by mail-it0-f51.google.com with SMTP id d65so68154954ith.0
        for <linux-mips@linux-mips.org>; Sun, 28 Aug 2016 11:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f/ePXNmiuOEUTac/W9myb04i7LBnhgm/OaXJFnsKdec=;
        b=To0+g/yEE3Ezbz4LyMTDrg5jUV9350ASaoNRyFSe7pCCIY7aks+PkfVtAAYOi54d/J
         jgtmknSLLVE69FIgiXeB9tcr96xKENargKf/wS0IgK+aAFZE4eiYryxH5y7vzHyTDZtm
         1Qg80tlcjUsXJAPYeWCDv5nkXfIFumK11Ye2LjPj9PCAx/32mcLdeM3DqWIutTUmUf1D
         TQGED70iYV3uWaml2+jhayVGdp/XMWYI5Yxdn0dwpmhuFcVGlmiWrMdps7jJhwCs1JYz
         FcjSO97Cay0NnqgEYkNBf17lN4Xdp8z00Ij6X4FKkwj1eDQskYN7zTyoHeCGPzK271qi
         x3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f/ePXNmiuOEUTac/W9myb04i7LBnhgm/OaXJFnsKdec=;
        b=H2EETZc9F4lyVqJIRLi3BxZCWTPjUffx39fyEPKbJGo+1QN5oO/12gU6QJPP1cuD/F
         yik4yna9iGP0+I8DfOvFkJ8CRiHnWUugqmo8OEgJEzjzodzDPq2QSzw0xwCZhhau/AV0
         w7i2lRH8iwz7MTQ7mDZD+eFgyKRChupPVxP48vt21KRWL40vQvMaXGxsLDWkfsYHKFV9
         YZX3ZDjPkqNyiMsGakDKZKfrOakR+MndD/x79rqdxDRqHCTdWx7h4s1Hlq/QMSjoY1u3
         nB7vXuHJTe6hDzy5Lj9BciSSHu/LSzyZOvbpsy7vKN5tpEhvAfz/kcWAZJPkPskSrFyU
         Aq2A==
X-Gm-Message-State: AE9vXwOoMFSbB9aIKQ8MoyCdoGC3eyXGh9b8tKgnjjyQrjnmY0q7w2w34W1AdRm2gFWCRGrsfA68yCoUrmQ9/A==
X-Received: by 10.36.40.144 with SMTP id h138mr10234516ith.31.1472407638418;
 Sun, 28 Aug 2016 11:07:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.168.129 with HTTP; Sun, 28 Aug 2016 11:06:38 -0700 (PDT)
In-Reply-To: <21a02eff-9bd0-c3b9-9845-21b302b8d5ca@gentoo.org>
References: <034a1d88-bdf2-8724-6e04-5ae0ba3aef62@gentoo.org> <21a02eff-9bd0-c3b9-9845-21b302b8d5ca@gentoo.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Sun, 28 Aug 2016 11:06:38 -0700
Message-ID: <CAGVrzcZ-UsWr_KTLmCHPjv0Qz=GmCp-g3Cqtq8Q3LfeXRFVHLQ@mail.gmail.com>
Subject: Re: SGI Octane && Bridge DMA bug
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54827
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

2016-08-28 9:58 GMT-07:00 Joshua Kinard <kumba@gentoo.org>:
> On 08/28/2016 08:01, Joshua Kinard wrote:
>> Trying to tackle the bug on SGI Octane systems where the machine misbehaves if
>> the amount of installed RAM is >2GB.  Reading some hints from the OpenBSD
>> xbridge.c driver, it seems Octane's (and maybe IP27's?) Bridge IOMMU is weird
>> in that, it cannot translate DMA addresses that go over 0x7fffffff (1ULL <<
>> 31).  Which is complicated by the fact that Octane's physical memory is offset
>> by 512MB, so I think the real DMA limits need to be 0x20000000 to 0x9fffffff.
>>
>> Been messing around in the dma-coherence.h header for Octane, and so far, with
>> 4GB of RAM installed, it gets all the way down to bringing up the MD raid
>> stuff, then throws an instruction bus error for address 0xffffffffa0013ea0.  I
>> can't make a determination if that's a DMA address or something else.  It's
>> sign-extended, so it's not any valid 64-bit address (including Crosstalk or
>> something attached to HEART).  It's very consistent, though, as it's in the EPC
>> register after each crash.
>>
>> The problem with Linux's DMA code is it is basically rigged to handle DMA for
>> PCI devices.  This includes the MIPS-specific DMA stuff.  The Impact video
>> board in an Octane is not a PCI device, but rather a pure Crosstalk device, and
>> it has no issues with DMA (as far as I know).  So I need to find a way to limit
>> DMA addresses for the Bridge driver only, but not mangle Impact DMA addresses.
>>
>> Ideas?
>
> I think the 0xffffffffa0013ea0 address I keep hitting from multiple, unrelated
> *alloc*() functions is, by virtue of being in CKSEG1 space, an exception
> handler.  Or was.  Seems like those are getting blown away somehow when
> something triggers an Oops -- seems the disk layer (MD, XFS, or qla1280), doing
> a DMA function and probably (though not confirmed) running into that Bridge
> issue of limited DMA addressing.
>
> Cause it seems that when the Oops happens, the MIPS trap code dumps the stack
> and registers, but when it goes to print the code trace, that trips up an
> instruction bus error on 0xffffffffa0013ea0, followed by one or more data bus
> errors.
>
> Seems to be the only explanation that I can think of.  Is it likely I'll have
> to write Octane-specific DMA alloc functions instead of the default-dma.c
> versions?  It seems dma-coherence.h is for dealing with addresses that have
> already been allocated, when I think I'll have to intercept the DMA calls and
> make sure nothing over 0x7fffffff in physmem for Bridge gets allocated.

Regarding your first question, for all plat_dma_* operations you
should be able to inspect the struct device properties and provide the
correct implementation based on whether this device is a child of the
Bridge IOMMU or not (e.g: looking at dev->parent.name for instance?)

You are right that this only works for addresses that have already
been allocated, if you need to make sure that the allocation falls
under a particular range as well, which is not taken care of by
dma-default.c, either setting an appropriate dma_mask, or providing a
custom implementation for dma_ma_ops may be required here.

HTH
-- 
Florian
