Return-Path: <SRS0=tpP8=S2=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B136C282CE
	for <linux-mips@archiver.kernel.org>; Wed, 24 Apr 2019 19:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC7A205ED
	for <linux-mips@archiver.kernel.org>; Wed, 24 Apr 2019 19:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mrQLtjdF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfDXTSc (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:18:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47324 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfDXTSb (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 24 Apr 2019 15:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=P+OfGyLgTHL2L1RnCJWgVoo8gkrh4zgwRL/+i5lcAZE=; b=mrQLtjdFQvWaJbGQaT55TTvth
        NOVOud4leyMRqSMYunVTLEw/Td40gtqCM0TCBkuC5uvAOduxbypNOG3qqbfATcl8n+W7IaH7+XtLK
        +hJ+ZISDncsKBPkEJEDg9XsfxcKM/UXlk3LJ9/KuuDP7RCJrEQPhbmzI7lbkrrX9LaP7T2PPjd8Zz
        MYmOOsXis2V1APWd8wnaYW6rXwKX4qhEuHWxji2rV3R4ZNir78GSm8YMAMvI/k+n7Wg0A9j5OHQ26
        DBgps9O0g04jCIvjxLm6aD4lqh08SDujttlnL9iMztT3xcStfimyJP3KNy5MyH5aC2o/YCxgMicUj
        IrldlGUNg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJNPa-0003Yt-Qz; Wed, 24 Apr 2019 19:18:30 +0000
Date:   Wed, 24 Apr 2019 12:18:30 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     linux-mips@vger.kernel.org, linux-mm@kvack.org
Subject: Re: MIPS/CI20: BUG: Bad page state
Message-ID: <20190424191830.GF19031@bombadil.infradead.org>
References: <20190424182012.GA21072@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424182012.GA21072@darkstar.musicnaut.iki.fi>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Wed, Apr 24, 2019 at 09:20:12PM +0300, Aaro Koskinen wrote:
> [33617.740799] BUG: Bad page state in process cc1plus  pfn:3df51
> [33617.746545] page:81023764 count:0 mapcount:-64768 mapping:00000000 index:0x1
> [33617.753577] flags: 0x40000000()
> [33617.756716] raw: 40000000 00000100 00000200 00000000 00000001 00000000 ffff02ff 00000000
> [33617.742940] raw: 00000000
> [33617.745548] page dumped because: nonzero mapcount

When a page is freed, it's not supposed to be mapped to userspace
any more, so mapcount should be 0.  In your case, it's either -64768,
which is a massive underflow, or it's 0xffff02ff which is a nonsensical
combination of flags.  Or a user is putting their own information into
that field (as, eg, slab does).  Or it's become corrupted for some reason
unknown to me.

> [33617.760052] Call Trace:
> [33617.740656] [<80019c7c>] show_stack+0x8c/0x130
> [33617.745092] [<8009cf78>] bad_page+0x138/0x140
> [33617.749437] [<8009d764>] free_pcppages_bulk+0x15c/0x4dc
> [33617.754652] [<8009eca8>] free_unref_page_list+0x130/0x168
> [33617.760041] [<800a7b90>] release_pages+0x98/0x404
> [33617.742894] [<800cea78>] tlb_flush_mmu_free+0x54/0x60
> [33617.747934] [<800c5874>] unmap_page_range+0x574/0x864
> [33617.752972] [<800c5cf8>] unmap_vmas+0x70/0x78
> [33617.757319] [<800cc690>] exit_mmap+0x110/0x1b8

Given this stack trace, the page was mapped into userspace, so something's
gone terribly wrong.  My money is on corruption; I haven't seen anyone
report anything like this before.

