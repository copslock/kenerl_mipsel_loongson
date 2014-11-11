Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2014 15:19:39 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:59725 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013387AbaKKOThyzaMD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Nov 2014 15:19:37 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sABEJa3t004012;
        Tue, 11 Nov 2014 15:19:36 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sABEJaaS004009;
        Tue, 11 Nov 2014 15:19:36 +0100
Date:   Tue, 11 Nov 2014 15:19:36 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 01/11] MIPS: push .set arch=r4000 into the functions
 needing it
Message-ID: <20141111141935.GB29662@linux-mips.org>
References: <1411551942-11153-1-git-send-email-paul.burton@imgtec.com>
 <1411551942-11153-2-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1411551942-11153-2-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44001
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

On Wed, Sep 24, 2014 at 10:45:32AM +0100, Paul Burton wrote:

> The {save,restore}_fp_context{,32} functions require that the assembler
> allows the use of sdc instructions on any FP register, and this is
> acomplished by setting the arch to r4000. However this has the effect
> of enabling the assembler to use mips64 instructions in the expansion
> of pseudo-instructions. This was done in the (now-reverted) commit
> eec43a224cf1 "MIPS: Save/restore MSA context around signals" which
> led to my mistakenly believing that there was an assembler bug, when
> in reality the assembler was just emitting mips64 instructions. Avoid
> the issue for future commits which will add code to r4k_fpu.S by
> pushing the .set arch=r4000 directives into the functions that require
> it, and remove the spurious assertion declaring the assembler bug.

I'm getting rejects applying patches 1 and 2 of this series and 3 looks
like it's likely not to apply either.  I suspect that's due to a
conflict with 842dfc11 (MIPS: Fix build with binutils 2.24.51+).  Can
you respin?

Thanks!

  Ralf
