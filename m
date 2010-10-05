Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Oct 2010 10:08:26 +0200 (CEST)
Received: (from localhost user: 'ralf' uid#500 fake: STDIN
        (ralf@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S1490945Ab0JEIIX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Oct 2010 10:08:23 +0200
Date:   Tue, 5 Oct 2010 09:08:22 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>,
        Matt Fleming <matt@console-pimps.org>
Cc:     linux-mips@linux-mips.org, a.p.zijlstra@chello.nl,
        paulus@samba.org, mingo@elte.hu, acme@redhat.com,
        jamie.iles@picochip.com
Subject: Re: [PATCH v7 2/6] MIPS/Oprofile: extract PMU defines for sharing
Message-ID: <20101005080822.GA13217@linux-mips.org>
References: <1285837760-10362-1-git-send-email-dengcheng.zhu@gmail.com>
 <1285837760-10362-3-git-send-email-dengcheng.zhu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1285837760-10362-3-git-send-email-dengcheng.zhu@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 30, 2010 at 05:09:16PM +0800, Deng-Cheng Zhu wrote:

> Moving performance counter/control defines into a single header file, so
> that software using the MIPS PMU can share the code.

Matt Fleming has patches pending that reimplement oprofile as a layer
based on top of perf.  All things considered I'd be happier if you just
copied whatever perf needs from oprofile rather than sharing it.

  Ralf
