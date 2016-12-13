Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Dec 2016 22:48:20 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:33360 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993080AbcLMVsNUsOSX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 13 Dec 2016 22:48:13 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id uBDLmAbg014303;
        Tue, 13 Dec 2016 22:48:10 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id uBDLm9Ur014302;
        Tue, 13 Dec 2016 22:48:09 +0100
Date:   Tue, 13 Dec 2016 22:48:09 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     Justin Chen <justinpopo6@gmail.com>, linux-mips@linux-mips.org,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Justin Chen <justin.chen@broadcom.com>
Subject: Re: [RFC] MIPS: Add cacheinfo support
Message-ID: <20161213214809.GA14262@linux-mips.org>
References: <20161208011626.20885-1-justinpopo6@gmail.com>
 <5849EC43.2070802@imgtec.com>
 <CAJx26kW0e-HC0VUTObZ5Or+XjFvE9KmtOToKbFvKYvhE--Vw5A@mail.gmail.com>
 <584A0281.3040505@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <584A0281.3040505@imgtec.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56041
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

On Thu, Dec 08, 2016 at 05:01:53PM -0800, Leonid Yegoshin wrote:

> CACHE instruction is not available in user space, only SYNCI on MIPS R2+ for
> trampoline.
> Any operation with CACHE requires a syscall.

Even worse, some older CPUs allow the execution of certain CACHE operations
from user space.  This is a feature which can be disabled by kernel.

> As for SYNCI (trampoline from L1D->L1I) the following information in user
> space is needed:
> 
>     1. L1 line size (available via RDHWR $x, $1). It is available now
> directly from CPU, but may be better to supply from kernel because some
> cores has no that.
> 
>     2. The flag that L1I is NOT coherent with L1D and SYNCI is needed and
> available
> 
> The knowledge about L1/L2 sizes is not needed for regular application...
> well, if application wants to get advantage of cache sizes, well, in this
> case it can be supplied.
> 
> But it is unreliable because app may be rescheduled into different kind of
> core which has a different L1 size (in heterogeneous system, BTW). It can be
> fixed by setting affinity, of course (not sure - can it be reliably done in
> BIG/LITTLE approach). But that requires in application the knowledge and
> understanding of system CPU structure... well why we can allow all that
> stuff besides information purpose? It corrupts the all efforts and
> optimization in kernel about performance and powersaving.

Also let's not forget about CPUs like Octeons which have CPUs that don't
quite fit in the usual scheme of doing things.

  Ralf
