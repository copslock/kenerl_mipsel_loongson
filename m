Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2011 00:35:37 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35733 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904090Ab1KQXfe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Nov 2011 00:35:34 +0100
Received: from akpm.mtv.corp.google.com (216-239-45-4.google.com [216.239.45.4])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A1E4A38E;
        Thu, 17 Nov 2011 23:33:53 +0000 (UTC)
Date:   Thu, 17 Nov 2011 15:35:26 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Rientjes <rientjes@google.com>
Cc:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>,
        linux-arch@vger.kernel.org, Robin Holt <holt@sgi.com>
Subject: Re: [patch] hugetlb: remove dummy definitions of HPAGE_MASK and
 HPAGE_SIZE
Message-Id: <20111117153526.f90ee248.akpm@linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1111171522131.20133@chino.kir.corp.google.com>
References: <1321567050-13197-1-git-send-email-ddaney.cavm@gmail.com>
        <alpine.DEB.2.00.1111171520130.20133@chino.kir.corp.google.com>
        <alpine.DEB.2.00.1111171522131.20133@chino.kir.corp.google.com>
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 31774
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14967

On Thu, 17 Nov 2011 15:22:53 -0800 (PST)
David Rientjes <rientjes@google.com> wrote:

> So, just remove the dummy and dangerous definitions since they are no
> longer needed and reveals the correct dependencies.  Tested on
> architectures using the definitions with allyesconfig: x86 (even with
> thp), hppa, mips, powerpc, s390, sh3, sh4, sparc, and sparc64, and
> with defconfig on ia64.

How could arch/mips/mm/tlb-r4k.c:local_flush_tlb_range() compile OK
with this change?

What that function is doing looks reasonable to me.  Why fill the poor
thing with an ifdef mess?

otoh, catching mistakes is good too.  Doing it at runtime as David
proposes is OK.
