Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jun 2010 14:25:53 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:46090 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490950Ab0FOMZu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Jun 2010 14:25:50 +0200
Received: by iwn3 with SMTP id 3so740957iwn.36
        for <linux-mips@linux-mips.org>; Tue, 15 Jun 2010 05:25:47 -0700 (PDT)
Received: by 10.231.139.66 with SMTP id d2mr7133328ibu.137.1276604747474;
        Tue, 15 Jun 2010 05:25:47 -0700 (PDT)
Received: from [10.161.2.200] ([122.181.19.78])
        by mx.google.com with ESMTPS id r12sm25730690ibi.2.2010.06.15.05.25.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 15 Jun 2010 05:25:46 -0700 (PDT)
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
Date:   Tue, 15 Jun 2010 17:56:34 +0530
Message-Id: <1276604794.19810.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.5 (2.24.5-2.fc10) 
Content-Transfer-Encoding: 7bit
X-archive-position: 27135
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pjohn@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 10264

Hello Jamie,

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
> 
> Perhaps MIPS udelay() should be disabling preemption itself, or
> (as x86 does) using raw_smp_processor_id() instead?

Sorry for the noise. I now find that raw_smp_processor_id() has been
implemented specific to MIPS in the latest kernel, I was using 2.6.32.

Thanks and regards,
Philby
