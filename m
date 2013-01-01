Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jan 2013 10:48:00 +0100 (CET)
Received: from mail-da0-f51.google.com ([209.85.210.51]:34409 "EHLO
        mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6815858Ab3AAJr7SrKp- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Jan 2013 10:47:59 +0100
Received: by mail-da0-f51.google.com with SMTP id i30so6039100dad.24
        for <multiple recipients>; Tue, 01 Jan 2013 01:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9I4L2Bb0VjBiaa8azq5VOB3nhCN8YUzRQFrR3iw0ksk=;
        b=IUVzkpmvY4dHx/L/1y5vCMEw7vN0mKVRs58/MhYJSsGhEkJGR4ez8Wr47QB7oFvnoN
         GNLmVgwZwrrOufq/2Jx30U8nrG2T9YZQ+j9f5lm5b7rb8VoKuo0xoR1sSes6scjjtFxb
         KGylyUqWFdHJ+gJ4eH+FPJvfXIoJoVB3R3nVDt1JDsQTV2VXHujLm7FqfecvOshGHIpv
         2zObU1G2iO6cv1AsSNWqNKwTks1KjNgUb9jBTCwBxeLTGkttW0B09kXk7r+GpRtAFUiF
         6g1LPhQAKgjWwhpURH8XwZ+GqAFHCqCg9XZo4/aIHEIJNnt3SHBCFy/XR85n1ZxkoEWp
         HspQ==
MIME-Version: 1.0
Received: by 10.68.194.6 with SMTP id hs6mr134421114pbc.77.1357033672369; Tue,
 01 Jan 2013 01:47:52 -0800 (PST)
Received: by 10.68.135.41 with HTTP; Tue, 1 Jan 2013 01:47:52 -0800 (PST)
In-Reply-To: <20130101112340.0a0e8c08@pixies.home.jungo.com>
References: <20130101112340.0a0e8c08@pixies.home.jungo.com>
Date:   Tue, 1 Jan 2013 01:47:52 -0800
Message-ID: <CAJiQ=7DZq7CO3FHtDe3OX12fZy70AUTJxAq90G5GXEewZdgqHw@mail.gmail.com>
Subject: Re: Regarding commit a16dad7 [MIPS: Fix potencial corruption]
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Shmulik Ladkani <shmulik.ladkani@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 35353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Jan 1, 2013 at 1:23 AM, Shmulik Ladkani
<shmulik.ladkani@gmail.com> wrote:
> Following a8ca8b64, another commit was submitted, adding similar
> 'cache_op' instructions to 'mips_sc_inv' - namely 96983ffe
> (MIPS: MIPSxx SC: Avoid destructive invalidation on partial L2 cachelines).
>
> Its purpose was to extend a8ca8b64, aligning behavior of 'mips_sc_inv'
> to be similar to 'r4k_dma_cache_inv'.
>
> Since the explicit 'cache_op' instrcutions are now removed from
> 'r4k_dma_cache_inv' (as of a16dad77), it probably makes sense to remove
> them from 'mips_sc_inv' as well.
>
> Any reason to keep these 'cache_op's? If not, I'll submit a patch.

There were a couple of USB drivers that stored DMA buffers inside a
struct with other data, and invalidating the whole cacheline tended to
clobber the other data.  For instance, intr_buff in
drivers/net/usb/pegasus.h .

Does CONFIG_DMA_API_DEBUG complain if it sees unaligned start
addresses or sizes?  That would be a much nicer way of catching the
problem, than troubleshooting random corruption.
