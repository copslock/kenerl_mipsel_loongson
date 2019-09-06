Return-Path: <SRS0=3GK8=XB=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBF7C43331
	for <linux-mips@archiver.kernel.org>; Fri,  6 Sep 2019 13:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05F3206BB
	for <linux-mips@archiver.kernel.org>; Fri,  6 Sep 2019 13:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567774952;
	bh=cS+jKt5ph0FPxFV3bytX1mCFf3/6EuAElXCY755Qphs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H3KM+5hSZbAapyBuh3hZrpE0va3+7pf+VqIH5coWn05gkgrYh+V5mi2CCgYc+rlj0
	 q0QbZ8d+gEv/r6JFLmhm7N768HbIug/t4+8Ipz7Yq0Z2Oe4j4uQCTP21qAZfdFKKr0
	 g6/dW0h7zpDqqfGdvuy75+OYx1sHeyVN/5pAqzEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389471AbfIFNCc (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 6 Sep 2019 09:02:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727914AbfIFNCc (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 6 Sep 2019 09:02:32 -0400
Received: from rapoport-lnx (unknown [87.71.71.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 291C520578;
        Fri,  6 Sep 2019 13:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567774951;
        bh=cS+jKt5ph0FPxFV3bytX1mCFf3/6EuAElXCY755Qphs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k9eBe8u5TKKzZ0KdndmsTfF3GToYgcWW7XpSdb2POg6+ywj+6iniQzlnoH1pi7ODO
         +8BUTlpWcjhnXZVPD1hjeMZlszKHrcAOpPXfwa2PADjv6v6MnM9tygYHLi/WWhzS9D
         KyVu0nxVFAFPf7V7kwwvHVSBHjabjuzzczosEOsM=
Date:   Fri, 6 Sep 2019 16:02:24 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH] mips: sgi-ip27: switch from DISCONTIGMEM to SPARSEMEM
Message-ID: <20190906130223.GA17704@rapoport-lnx>
References: <1567662477-27404-1-git-send-email-rppt@kernel.org>
 <20190905152150.f7ff6ef70726085de63df828@suse.de>
 <20190905133251.GA3650@rapoport-lnx>
 <20190905154831.88b7853b47ba7db7bd7626bd@suse.de>
 <20190905154747.GB3650@rapoport-lnx>
 <20190905233800.0f6b3fb3722cde2f5a88663a@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190905233800.0f6b3fb3722cde2f5a88663a@suse.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Thu, Sep 05, 2019 at 11:38:00PM +0200, Thomas Bogendoerfer wrote:
> On Thu, 5 Sep 2019 18:47:49 +0300
> Mike Rapoport <rppt@kernel.org> wrote:
> 
> > On Thu, Sep 05, 2019 at 03:48:31PM +0200, Thomas Bogendoerfer wrote:
> > > On Thu, 5 Sep 2019 16:32:53 +0300
> > > Mike Rapoport <rppt@kernel.org> wrote:
> > > 
> > > > On Thu, Sep 05, 2019 at 03:21:50PM +0200, Thomas Bogendoerfer wrote:
> > > > > On Thu,  5 Sep 2019 08:47:57 +0300
> > > > > Mike Rapoport <rppt@kernel.org> wrote:
> > > > > 
> > > > > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > > > > 
> > > > > > The memory initialization of SGI-IP27 is already half-way to support
> > > > > > SPARSEMEM and only a call to sparse_init() was missing. Add it to
> > > > > > prom_meminit() and adjust arch/mips/Kconfig to enable SPARSEMEM and
> > > > > > SPARSEMEM_EXTREME for SGI-IP27
> > > > > > 
> > > > > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > > > > > ---
> > > > > > 
> > > > > > Thomas, could you please test this on your Origin machine?
> > > > > 
> > > > > it crashes in sparse_early_usemaps_alloc_pgdat_section(). Since there is
> > > > > already a sparse_init() in arch_mem_setup() I removed it from ip27-memory.c.
> > > > 
> > > > Oops, missed that.
> > > > 
> > > > > With this booting made more progress but I get an unaligned access in
> > > > > kernel_init_free_pages(). 
> > > > 
> > > > Can you please share the log?
> > > 
> > > sure
> > 
> > Nothing looked particularly suspicious, but I've found that I've missed the
> > definition of pfn_to_nid() is for DISCONTIGMEM only, maybe making it
> > available for SPARSE would help :)
> > 
> > I'm pretty much shooting in the dark here, but can you please try the patch
> > below on top of the original one:
> 
> doesn't compile: 
> 
> /home/tbogendoerfer/wip/mips/linux/include/linux/mmzone.h:1367:0: warning: "pfn_to_nid" redefined
>  #define pfn_to_nid(pfn)       \
> 
> 
> For testing I've removed the version in linux/mmzone.h, but kernel still crashes. Only
> difference is that several CPUs are printing the oops in unaligned handler in parallel.
> With the sparse_init() in prom_meminit() kernel dies at the same spot as before.

Well, apparently the generic pfn_to_nid() is better :)

I suspect that unaligned access comes from __page_to_pfn, can you please
check what scripts/fadd2line reports for kernel_init_free_pages+0xcc/0x138?

> Thomas.
> 
> -- 
> SUSE Software Solutions Germany GmbH
> HRB 247165 (AG M�nchen)
> Gesch�ftsf�hrer: Felix Imend�rffer

-- 
Sincerely yours,
Mike.
