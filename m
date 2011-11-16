Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2011 00:18:31 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:63034 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903878Ab1KPXS0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Nov 2011 00:18:26 +0100
Received: by ywp31 with SMTP id 31so372438ywp.36
        for <linux-mips@linux-mips.org>; Wed, 16 Nov 2011 15:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=+/5fZQKm1ToZZp6IfIpCWgT+DZ0EFPWYxG06rXb5pVs=;
        b=AOeMO7HFDuyenNAXEYbxvc/ojvg7e0vLaxzp6DIxSXfhmfAIOwrjirQIOCVrrL39W6
         1gQlqtveCwrxdaP5BpQg==
Received: by 10.101.10.26 with SMTP id n26mr7827688ani.43.1321485499613;
        Wed, 16 Nov 2011 15:18:19 -0800 (PST)
Received: by 10.101.10.26 with SMTP id n26mr7827657ani.43.1321485499308;
        Wed, 16 Nov 2011 15:18:19 -0800 (PST)
Received: from [2620:0:1008:1201:be30:5bff:fed8:5e64] ([2620:0:1008:1201:be30:5bff:fed8:5e64])
        by mx.google.com with ESMTPS id u10sm42378179anj.6.2011.11.16.15.18.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Nov 2011 15:18:18 -0800 (PST)
Date:   Wed, 16 Nov 2011 15:18:16 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     David Daney <ddaney.cavm@gmail.com>
cc:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        William Irwin <wli@holomorphy.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] hugetlb: Provide a default HPAGE_SHIFT if
 !CONFIG_HUGETLB_PAGE
In-Reply-To: <4EC43488.3070400@gmail.com>
Message-ID: <alpine.DEB.2.00.1111161512371.16596@chino.kir.corp.google.com>
References: <1321472611-13283-1-git-send-email-ddaney.cavm@gmail.com> <alpine.DEB.2.00.1111161327180.16596@chino.kir.corp.google.com> <4EC43488.3070400@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 31709
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rientjes@google.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13960

On Wed, 16 Nov 2011, David Daney wrote:

> > > This is required now to get MIPS kernels to compile with
> > > !CONFIG_HUGETLB_PAGE.
> > > 
> > 
> > Why?
> 
> I should have been more specific.  The failure is in Ralf's
> mips-for-linux-next branch.
> 

I can't find that branch (it's not in Ralf's tree at git.kernel.org), so 
I'm looking at next-20111116.  It doesn't compile for mips for other 
reasons related to arch/mips/sgi-ip22/ip22-gio.c.

> > This is definitely the wrong fix, anyway, and it would require a change to
> > arch/mips/include/asm/page.h instead since it's localized to mips,
> 
> No, all we are doing is supplying a dummy definition for HPAGE_SHIFT as we
> currently have for HPAGE_SIZE and HPAGE_MASK.
> 

Which is wrong.  MIPS code should not be using HPAGE_SHIFT without 
CONFIG_HUGETLB_PAGE and in fact defines it itself for such a configuration 
in arch/mips/include/asm/page.h.  The only generic uses are in 
page_alloc.c where we need CONFIG_HUGETLB_PAGE_SIZE_VARIABLE, which isn't 
available on mips, and in mm/hugetlb.c which requires CONFIG_HUGETLB_PAGE 
by way of CONFIG_HUGETLBFS.

So feel free to show the actual compile error this time and I'll suggest a 
mips fix for it.

> > so nack.
> > 
> > > Signed-off-by: David Daney<david.daney@cavium.com>
> > > ---
> > >   include/linux/hugetlb.h |    1 +
> > >   1 files changed, 1 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > > index 19644e0..746d543 100644
> > > --- a/include/linux/hugetlb.h
> > > +++ b/include/linux/hugetlb.h
> > > @@ -113,6 +113,7 @@ static inline void copy_huge_page(struct page *dst,
> > > struct page *src)
> > >   #ifndef HPAGE_MASK
> > >   #define HPAGE_MASK	PAGE_MASK		/* Keep the compiler
> > > happy */
> > >   #define HPAGE_SIZE	PAGE_SIZE
> 
> Why didn't you NACK the addition of these two lines too?
> 
> Following your logic, we should remove these and patch up all the architecture
> specific files instead.
> 

I think it's a worthwhile goal to remove these as well, yes.
