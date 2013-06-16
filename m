Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Jun 2013 08:51:40 +0200 (CEST)
Received: from mail-ie0-f176.google.com ([209.85.223.176]:35712 "EHLO
        mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816521Ab3FPGvhWXDnX convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 16 Jun 2013 08:51:37 +0200
Received: by mail-ie0-f176.google.com with SMTP id ar20so4273388iec.7
        for <linux-mips@linux-mips.org>; Sat, 15 Jun 2013 23:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:subject:to:cc:references:in-reply-to:x-mailer:message-id
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:x-gm-message-state;
        bh=f6Cq6ny3Ln9TshtAtEK7ZfjTiSV8tp/i4YC8y65C90A=;
        b=bw14JyQMxqIKvXugE7jpulEO/qa5kvV3Qiqr28W6GhAhhsHYMK/5whot6KQkeGvy98
         nhsGjnfpDl/v6LXAkZe378KCuPAfQglLoLaccTlFbhFXNpf4zxryukVh71RcW5dP1svE
         mkEOV6M92OJBMTexOQP8YQEhU/d+USw3SF6NpzyOTFx2I8qwj2K6d610EbgWjezcnQ5B
         2NuIv+7A8+oYQAGx8o8QbivBkeV/fUqXw0C1ifHPgbPXOD7B9OOfZoFX2xRbfYhIkACa
         TS8MANhBVi0vupw2sJYre8aTg9xq+c2MV8/QsejjxLKCsQszddVWzyWes/66UmsIoPBX
         2FMQ==
X-Received: by 10.50.6.51 with SMTP id x19mr2358711igx.78.1371365490470;
        Sat, 15 Jun 2013 23:51:30 -0700 (PDT)
Received: from driftwood ([66.60.222.212])
        by mx.google.com with ESMTPSA id it3sm11122946igb.0.2013.06.15.23.51.28
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Jun 2013 23:51:29 -0700 (PDT)
Date:   Sun, 16 Jun 2013 01:51:26 -0500
From:   Rob Landley <rob@landley.net>
Subject: Re: Commit f9afbd45b0d0 broke mips r4k.
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-kernel@vger.kernel.org, sanjayl@kymasys.com,
        kvm@vger.kernel.org, linux-mips@linux-mips.org,
        Markos Chandras <markos.chandras@imgtec.com>
References: <1371090916.2776.104@driftwood>
        <20130613090002.GD7422@linux-mips.org>
In-Reply-To: <20130613090002.GD7422@linux-mips.org> (from
        ralf@linux-mips.org on Thu Jun 13 04:00:02 2013)
X-Mailer: Balsa 2.4.11
Message-Id: <1371365486.2776.113@driftwood>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Gm-Message-State: ALoCoQkqHucYCFq4/PucNyiXOutZyVlbD0jPtGjzSlVSN2ggYQImZGA+LNtDc6mm/krJm2Zb5FbF
Return-Path: <rob@landley.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rob@landley.net
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

On 06/13/2013 04:00:02 AM, Ralf Baechle wrote:
> On Wed, Jun 12, 2013 at 09:35:16PM -0500, Rob Landley wrote:
> 
> > My aboriginal linux project builds tiny linux systems to run under
> > qemu, producing as close to the same system as possible across a
> > bunch of different architectures. The above change broke the mips
> > r4k build I've been running under qemu.
> >
> > Here's a toolchain and reproduction sequence:
> >
> >   wget http://landley.net/aboriginal/bin/cross-compiler-mips.tar.bz2
> >   tar xvjf cross-compiler-mips.tar.bz2
> >   export PATH=$PWD/cross-compiler-mips/bin:$PATH
> >   make ARCH=mips allnoconfig KCONFIG_ALLCONFIG=miniconfig.mips
> >   make CROSS_COMPILE=mips- ARCH=mips
> >
> > (The file miniconfig.mips is attached.)
> >
> > It ends:
> >
> >   CC      init/version.o
> >   LD      init/built-in.o
> > arch/mips/built-in.o: In function `local_r4k_flush_cache_page':
> > c-r4k.c:(.text+0xe278): undefined reference to  
> `kvm_local_flush_tlb_all'
> > c-r4k.c:(.text+0xe278): relocation truncated to fit: R_MIPS_26
> > against `kvm_local_flush_tlb_all'
> > arch/mips/built-in.o: In function `local_flush_tlb_range':
> > (.text+0xe938): undefined reference to `kvm_local_flush_tlb_all'
> > arch/mips/built-in.o: In function `local_flush_tlb_range':
> > (.text+0xe938): relocation truncated to fit: R_MIPS_26 against
> > `kvm_local_flush_tlb_all'
> > arch/mips/built-in.o: In function `local_flush_tlb_mm':
> > (.text+0xed38): undefined reference to `kvm_local_flush_tlb_all'
> > arch/mips/built-in.o: In function `local_flush_tlb_mm':
> > (.text+0xed38): relocation truncated to fit: R_MIPS_26 against
> > `kvm_local_flush_tlb_all'
> > kernel/built-in.o: In function `__schedule':
> > core.c:(.sched.text+0x16a0): undefined reference to
> > `kvm_local_flush_tlb_all'
> > core.c:(.sched.text+0x16a0): relocation truncated to fit: R_MIPS_26
> > against `kvm_local_flush_tlb_all'
> > mm/built-in.o: In function `use_mm':
> > (.text+0x182c8): undefined reference to `kvm_local_flush_tlb_all'
> > mm/built-in.o: In function `use_mm':
> > (.text+0x182c8): relocation truncated to fit: R_MIPS_26 against
> > `kvm_local_flush_tlb_all'
> > fs/built-in.o:(.text+0x7b50): more undefined references to
> > `kvm_local_flush_tlb_all' follow
> > fs/built-in.o: In function `flush_old_exec':
> > (.text+0x7b50): relocation truncated to fit: R_MIPS_26 against
> > `kvm_local_flush_tlb_all'
> >
> > Revert the above commit and it builds to the end.
> 
> Commit d414976d1ca721456f7b7c603a8699d117c2ec07 [MIPS: include:
> mmu_context.h: Replace VIRTUALIZATION with KVM] fixes the issue and
> was pulled by Linus only yesterday.  I cannot reproduce the error
> following your receipe using the latest Linux/MIPS tree.

Confirmed, that fixed it.

Thanks,

Rob
From ralf@linux-mips.org Sun Jun 16 10:49:23 2013
Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Jun 2013 10:49:26 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:37762 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6817548Ab3FPItXx-Lwr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 16 Jun 2013 10:49:23 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5G8nB2v020938;
        Sun, 16 Jun 2013 10:49:11 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5G8n7dj020937;
        Sun, 16 Jun 2013 10:49:07 +0200
Date:   Sun, 16 Jun 2013 10:49:07 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, kvm@vger.kernel.org,
        Sanjay Lal <sanjayl@kymasys.com>, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 19/31] mips/kvm: Add host definitions for MIPS VZ based
 host.
Message-ID: <20130616084907.GA20046@linux-mips.org>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
 <1370646215-6543-20-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1370646215-6543-20-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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
Content-Length: 53
Lines: 3

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
