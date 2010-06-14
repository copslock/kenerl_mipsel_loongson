Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jun 2010 18:39:42 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:37819 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491874Ab0FNQjj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Jun 2010 18:39:39 +0200
Received: by pwj6 with SMTP id 6so3261898pwj.36
        for <linux-mips@linux-mips.org>; Mon, 14 Jun 2010 09:39:31 -0700 (PDT)
Received: by 10.142.60.11 with SMTP id i11mr4093246wfa.211.1276533571195;
        Mon, 14 Jun 2010 09:39:31 -0700 (PDT)
Received: from [10.161.2.200] ([122.181.19.78])
        by mx.google.com with ESMTPS id x35sm1870811wfh.18.2010.06.14.09.39.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Jun 2010 09:39:30 -0700 (PDT)
Subject: Re: [PATCH] mtd: Fix bug using smp_processor_id() in preemptible
 ubi_bgt1d kthread
From:   Philby John <pjohn@mvista.com>
Reply-To: pjohn@mvista.com
To:     Jamie Lokier <jamie@shareable.org>
Cc:     linux-mtd@lists.infradead.org, linux-mips@linux-mips.org,
        David Daney <ddaney@caviumnetworks.com>,
        linux-kernel@vger.kernel.org,
        Artem Bityutskiy <dedekind1@gmail.com>
In-Reply-To: <20100614150425.GC9550@shareable.org>
References: <1276513457.16642.3.camel@localhost.localdomain>
         <20100614150425.GC9550@shareable.org>
Content-Type: text/plain
Date:   Mon, 14 Jun 2010 22:10:18 +0530
Message-Id: <1276533618.17818.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.5 (2.24.5-2.fc10) 
Content-Transfer-Encoding: 7bit
X-archive-position: 27133
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pjohn@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 9608

On Mon, 2010-06-14 at 16:04 +0100, Jamie Lokier wrote:
> Philby John wrote:
> > mtd: Fix bug using smp_processor_id() in preemptible ubi_bgt1d kthread
> > 
> > On a MIPS Cavium Octeon CN5020 when trying to create a UBI volume,
> > on the NOR flash, the kernel thread ubi_bgt1d calls
> > cfi_amdstd_write_buffers() --> do_write_buffer() -->
> > INVALIDATE_CACHE_UDELAY --> __udelay(). Its __udelay() that calls
> > smp_processor_id() in preemptible code, which you are not supposed to.
> > Fix the problem by disabling preemption.
> 
> The MTD code just calls udelay().
> Are you sure it isn't permitted to call udelay() from preemptible code?
> I think it is fine.

It isn't really udelay() but smp_processor_id() that you are not to call
from a preemptible thread. Now I also see Ed Swierk has done a similar
thing https://patchwork.kernel.org/patch/4049/ and he comments "..which
calls smp_processor_id(), which is not supposed to be called from a
preemptible thread."


So perhaps I can use preempt_disable() around just this call in function
__udelay()?

Regards,
Philby
