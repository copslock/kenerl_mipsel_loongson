Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2014 22:22:57 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:34452 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013426AbaKKVWzkUUro (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Nov 2014 22:22:55 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sABLMsC2012135;
        Tue, 11 Nov 2014 22:22:54 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sABLMsBZ012134;
        Tue, 11 Nov 2014 22:22:54 +0100
Date:   Tue, 11 Nov 2014 22:22:54 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: R14000: Add missing CPU_R14000 reference in
 cpu_needs_post_dma_flush()
Message-ID: <20141111212253.GA11943@linux-mips.org>
References: <543490B9.7070302@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <543490B9.7070302@gentoo.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44015
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

On Tue, Oct 07, 2014 at 09:17:45PM -0400, Joshua Kinard wrote:

> cpu_needs_post_dma_flush() in arch/mips/mm/dma-default.c is missing a check for
> CPU_R14000, where it already has checks for CPU_R10000 and CPU_R12000.  This
> patch adds the missing CPU_R14000 check.

Patch is entirely correct.  Except.

This is only used on systems which don't have DMA cache coherency.  Those
systems are the IP28 and IP22 which featured an R10000 rsp.  R10000 or
R12000 processor which is why the R14000 is intentionally not listed in
this if().  Saves a few bytes and cycles.  And probably deserves a
comment in the code!

  Ralf
