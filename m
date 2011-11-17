Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2011 00:45:04 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:44104 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904090Ab1KQXo7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Nov 2011 00:44:59 +0100
Received: by ggnb1 with SMTP id b1so2176781ggn.36
        for <linux-mips@linux-mips.org>; Thu, 17 Nov 2011 15:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=nh0+qcNac41q+BikpY77ogfKInCpOlfG7r5MJMDMz+U=;
        b=QiKWibe0Sj9zxj2OgRhYiMe1A301rCrT0cvYXiajMr4Gr2raJlihznhoG6rGQiWxOq
         J9fd0ZQS1A42WoucwSGw==
Received: by 10.50.169.1 with SMTP id aa1mr825064igc.9.1321573493312;
        Thu, 17 Nov 2011 15:44:53 -0800 (PST)
Received: by 10.50.169.1 with SMTP id aa1mr825028igc.9.1321573493143;
        Thu, 17 Nov 2011 15:44:53 -0800 (PST)
Received: from [2620:0:1008:1201:be30:5bff:fed8:5e64] ([2620:0:1008:1201:be30:5bff:fed8:5e64])
        by mx.google.com with ESMTPS id wo4sm24709179igc.5.2011.11.17.15.44.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 15:44:52 -0800 (PST)
Date:   Thu, 17 Nov 2011 15:44:50 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>,
        linux-arch@vger.kernel.org, Robin Holt <holt@sgi.com>
Subject: Re: [patch] hugetlb: remove dummy definitions of HPAGE_MASK and
 HPAGE_SIZE
In-Reply-To: <20111117153526.f90ee248.akpm@linux-foundation.org>
Message-ID: <alpine.DEB.2.00.1111171538540.13555@chino.kir.corp.google.com>
References: <1321567050-13197-1-git-send-email-ddaney.cavm@gmail.com> <alpine.DEB.2.00.1111171520130.20133@chino.kir.corp.google.com> <alpine.DEB.2.00.1111171522131.20133@chino.kir.corp.google.com> <20111117153526.f90ee248.akpm@linux-foundation.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 31776
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rientjes@google.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14977

On Thu, 17 Nov 2011, Andrew Morton wrote:

> > So, just remove the dummy and dangerous definitions since they are no
> > longer needed and reveals the correct dependencies.  Tested on
> > architectures using the definitions with allyesconfig: x86 (even with
> > thp), hppa, mips, powerpc, s390, sh3, sh4, sparc, and sparc64, and
> > with defconfig on ia64.
> 
> How could arch/mips/mm/tlb-r4k.c:local_flush_tlb_range() compile OK
> with this change?
> 

This was tested on Linus' tree, not on Ralf's linux-next tree.  All uses 
of HPAGE_* are protected by CONFIG_HUGETLB_PAGE as it appropriately should 
be in Linus' tree in that file.

> What that function is doing looks reasonable to me.  Why fill the poor
> thing with an ifdef mess?
> 
> otoh, catching mistakes is good too.  Doing it at runtime as David
> proposes is OK.
> 

Nobody else needs it other than Ralf's pending change, and you're 
suggesting we need them in a generic header file when any sane arch that 
uses hugepages (all of them, in the current tree) declares these 
themselves in arch/*/include/asm/page.h where it's supposed to be done?

Why on earth do we have CONFIG_HUGETLB_PAGE for at all, then?  To catch 
code that's operating on hugepages when our kernel doesn't support it.  
I'd much rather break the build than get a runtime BUG() because we want 
to avoid an #ifdef or actually write well-written code like every other 
arch has!  Panicking the code to find errors like this is just insanity.
