Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Oct 2016 01:07:50 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:40848 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992212AbcJFXHnJQxxm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Oct 2016 01:07:43 +0200
Date:   Fri, 7 Oct 2016 00:07:42 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
cc:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/9] MIPS: traps: 64bit kernels should read CP0_EBase
 64bit
In-Reply-To: <20161006225024.GJ19354@jhogan-linux.le.imgtec.org>
Message-ID: <alpine.LFD.2.20.1610062358550.1794@eddie.linux-mips.org>
References: <e826225b15736539cd96a1b6b2a99e2bb2b4eb87.1472747205.git-series.james.hogan@imgtec.com> <20160921130852.GA10899@linux-mips.org> <73eede89-af68-eb17-b0b3-2537084da819@imgtec.com> <alpine.LFD.2.20.1610021038190.25303@eddie.linux-mips.org>
 <20161005155653.GG15578@jhogan-linux.le.imgtec.org> <alpine.LFD.2.20.1610061709400.1794@eddie.linux-mips.org> <20161006180525.GG19354@jhogan-linux.le.imgtec.org> <alpine.LFD.2.20.1610062054500.1794@eddie.linux-mips.org> <20161006201943.GI19354@jhogan-linux.le.imgtec.org>
 <alpine.LFD.2.20.1610062335410.1794@eddie.linux-mips.org> <20161006225024.GJ19354@jhogan-linux.le.imgtec.org>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55363
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Thu, 6 Oct 2016, James Hogan wrote:

> I don't particularly object to always allocating our own vector when
> EBase is present. It'd probably break KVM, but that's KVM's fault for
> not emulating EBase properly yet.

 In most cases we'll use the default KSEG0 base address anyway, won't we?

> I suppose there is also an advantage to keeping the bootloader exception
> vector as alive as possible at least until Linux has set up its own one,
> as it allows early bugs to be caught by the bootloader, which can dump
> registers etc and even return to the bootloader prompt.

 Right, but I think using our own allocated memory actually helps that in 
that we can install our exception handlers first and only then switch 
EBase, which is atomic (modulo probing for WG, but perhaps we don't 
actually have to do that).  Whereas overwriting firmware memory already 
pointed to by EBase while installing exception handlers is pretty much 
destructive right away, as there'll always be a stage at which a partially 
installed handler is non-functional.

  Maciej
