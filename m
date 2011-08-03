Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Aug 2011 18:26:31 +0200 (CEST)
Received: from mail-ey0-f170.google.com ([209.85.215.170]:36693 "EHLO
        mail-ey0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S2100414Ab1HCQ01 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Aug 2011 18:26:27 +0200
Received: by eyd10 with SMTP id 10so944784eyd.29
        for <multiple recipients>; Wed, 03 Aug 2011 09:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=fsoA+NQzTZZAtORdLxO279vF5SsEUQHpaeUBumdPqo0=;
        b=tTtZ5ha+ojSEJpTDqj9sXm9vsU+te2/zf+Z7jNmhtn6g+6nOPYcDvI+QLrugIyGDaC
         7O19d0iXe4i5+AweJ3DBYlY5PNGJR7PYym9rVZjUJrQNrD0TYbvL2c2H9QXHNkHF6CGp
         5s6C+wA8iMHG42kmpNxTpZIN2U26fz4P7GqFI=
Received: by 10.204.134.205 with SMTP id k13mr2279321bkt.252.1312388782297;
        Wed, 03 Aug 2011 09:26:22 -0700 (PDT)
Received: from htj.dyndns.org ([130.75.117.88])
        by mx.google.com with ESMTPS id f13sm290980bku.18.2011.08.03.09.26.20
        (version=SSLv3 cipher=OTHER);
        Wed, 03 Aug 2011 09:26:20 -0700 (PDT)
Date:   Wed, 3 Aug 2011 18:26:18 +0200
From:   Tejun Heo <tj@kernel.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     benh@kernel.crashing.org, yinghai@kernel.org, hpa@zytor.com,
        tony.luck@intel.com, schwidefsky@de.ibm.com,
        liqin.chen@sunplusct.com, lethal@linux-sh.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@redhat.com, linux-mips@linux-mips.org
Subject: Re: [PATCH 19/23] mips: Use HAVE_MEMBLOCK_NODE_MAP
Message-ID: <20110803162618.GB17477@htj.dyndns.org>
References: <1311694534-5161-1-git-send-email-tj@kernel.org>
 <1311694534-5161-20-git-send-email-tj@kernel.org>
 <20110803161745.GA13266@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110803161745.GA13266@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30827
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tj@kernel.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 2492

On Wed, Aug 03, 2011 at 05:17:45PM +0100, Ralf Baechle wrote:
> On Tue, Jul 26, 2011 at 05:35:30PM +0200, Tejun Heo wrote:
> 
> > mips used early_node_map[] just to prime free_area_init_nodes().  Now
> > memblock can be used for the same purpose and early_node_map[] is
> > scheduled to be dropped.  Use memblock instead.
> > 
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Yinghai Lu <yinghai@kernel.org>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: linux-mips@linux-mips.org
> > ---
> > Only compile tested.  Thanks.
> > 
> >  arch/mips/Kconfig                |    3 +++
> >  arch/mips/kernel/setup.c         |    3 ++-
> >  arch/mips/sgi-ip27/ip27-memory.c |    5 +++--
> >  3 files changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > index 653da62..368b2ec 100644
> > --- a/arch/mips/Kconfig
> > +++ b/arch/mips/Kconfig
> > @@ -24,6 +24,9 @@ config MIPS
> >  	select GENERIC_IRQ_PROBE
> >  	select GENERIC_IRQ_SHOW
> >  	select HAVE_ARCH_JUMP_LABEL
> > +	select HAVE_MEMBLOCK
> 
> This means <linux/memblock.h> will include <asm/memblock.h> which does
> not exist for MIPS.  Did you accidentally not post this new file?

Nope, earlier commit 24aa07882b and its fix patch (patch 0.5 in this
series) removes asm/memblock.h from all archs and drops it from
linux/memblock.h.

Thanks.

-- 
tejun
