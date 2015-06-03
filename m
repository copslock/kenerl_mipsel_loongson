Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2015 10:21:28 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:37343 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012161AbbFCIV0NQHHx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Jun 2015 10:21:26 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t538LPMk012815;
        Wed, 3 Jun 2015 10:21:25 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t538LPQ9012814;
        Wed, 3 Jun 2015 10:21:25 +0200
Date:   Wed, 3 Jun 2015 10:21:25 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH v3] MIPS: R12000: Enable branch prediction global history
Message-ID: <20150603082124.GH9839@linux-mips.org>
References: <556E2C6D.6070802@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <556E2C6D.6070802@gentoo.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47827
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

On Tue, Jun 02, 2015 at 06:21:33PM -0400, Joshua Kinard wrote:

> From: Joshua Kinard <kumba@gentoo.org>
> 
> The R12000 added a new feature to enhance branch prediction called
> "global history".  Per the Vr10000 Series User Manual (U10278EJ4V0UM),
> Coprocessor 0, Diagnostic Register (22):
> 
> """
> If bit 26 is set, branch prediction uses all eight bits of the global
> history register.  If bit 26 is not set, then bits 25:23 specify a count
> of the number of bits of global history to be used. Thus if bits 26:23
> are all zero, global history is disabled.
> 
> The global history contains a record of the taken/not-taken status of
> recently executed branches, and when used is XOR'ed with the PC of a
> branch being predicted to produce a hashed value for indexing the BPT.
> Some programs with small "working set of conditional branches" benefit
> significantly from the use of such hashing, some see slight performance
> degradation.
> """
> 
> This patch enables global history on R12000 CPUs and up by setting bit
> 26 in the branch prediction diagnostic register (CP0 $22) to '1'.  Bits
> 25:23 are left alone so that all eight bits of the global history
> register are available for branch prediction.

Will apply but could you also submit a patch to set cpu_has_bp_ghist to
0/1 as applicable in all cpu-feature-overrides.h?

Also the manual suggests this CPU feature may not always be neneficial
for performance so I'm wondering if we should add a way to modify it
at runtime.

I'm curious, have you checked the default setting of the global history
on kernel entry?

  Ralf
