Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2011 17:05:42 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:42145 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491839Ab1EMPFj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 May 2011 17:05:39 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p4DF78pm026500;
        Fri, 13 May 2011 16:07:08 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p4DF77UO026498;
        Fri, 13 May 2011 16:07:07 +0100
Date:   Fri, 13 May 2011 16:07:07 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] MIPS: Replace _PAGE_READ with _PAGE_NO_READ
Message-ID: <20110513150707.GA26389@linux-mips.org>
References: <7aa38c32b7748a95e814e5bb0583f967@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7aa38c32b7748a95e814e5bb0583f967@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29993
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Apr 16, 2011 at 09:44:29AM -0700, Kevin Cernekee wrote:

> Reuse more of the same definitions for the non-RIXI and RIXI cases.  This
> avoids having special cases for kernel_uses_smartmips_rixi cluttering up
> the pgtable*.h files.
> 
> On hardware that does not support RI/XI, EntryLo bits 31:30 / 63:62 will
> remain unset and RI/XI permissions will not be enforced.

Nice idea but it breaks on 64-bit hardware running 32-bit kernels.  On
those the RI/XI bits written to c0_entrylo0/1 31:30 will be interpreted as
physical address bits 37:36.

I'm removing this patch series from the 2.6.40 patch queue until we can
sort this out.

  Ralf
