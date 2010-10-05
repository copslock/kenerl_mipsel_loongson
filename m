Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Oct 2010 09:52:45 +0200 (CEST)
Received: from arkanian.console-pimps.org ([212.110.184.194]:52285 "EHLO
        arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490945Ab0JEHwl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Oct 2010 09:52:41 +0200
Received: by arkanian.console-pimps.org (Postfix, from userid 1000)
        id 0847960350; Tue,  5 Oct 2010 08:52:38 +0100 (BST)
Date:   Tue, 5 Oct 2010 08:52:37 +0100
From:   Matt Fleming <matt@console-pimps.org>
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, Robert Richter <robert.richter@amd.com>
Subject: Re: [PATCH v7 0/6] MIPS performance event support v7
Message-ID: <20101005075237.GC22830@console-pimps.org>
References: <1285837760-10362-1-git-send-email-dengcheng.zhu@gmail.com> <20101004193329.GF1670@console-pimps.org> <AANLkTimygG29VWat0XoNBxOPeB4+vdSoQdO5+G=emecz@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTimygG29VWat0XoNBxOPeB4+vdSoQdO5+G=emecz@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <matt@console-pimps.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27941
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt@console-pimps.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 05, 2010 at 08:06:26AM +0800, Deng-Cheng Zhu wrote:
> I have a question about your "generalise" patchset: Do you see any issues
> or needed changes for the existing x86 (or sparc) Perf and Oprofile code by
> merging your patchset?
> 
> 
> Deng-Cheng

Just to be clear, if my patches are merged it won't break any existing
architectures - it is an optional interface and each architecture must
opt-in. Having said that, I'm sure the maintainers for other
architectures will be looking to move over to the new interface. It
certainly makes sense from a maintenance point of view.

If any problems are discovered with the generic perf-oprofile code
while trying to migrate architectures then they can be fixed. Rather
than trying to accomplish the mamoth task of guessing everybody's
requirements, I decided it would be easier to just get support for SH
and ARM working first and others can follow.
