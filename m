Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Feb 2010 20:14:47 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:55242 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491155Ab0BVTOn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 22 Feb 2010 20:14:43 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o1MJEfOg013430;
        Mon, 22 Feb 2010 20:14:41 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o1MJEeQH013428;
        Mon, 22 Feb 2010 20:14:40 +0100
Date:   Mon, 22 Feb 2010 20:14:40 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Bcm47xx: Fix 128MB RAM support
Message-ID: <20100222191440.GA12818@linux-mips.org>
References: <1266691880-372-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1266691880-372-1-git-send-email-hauke@hauke-m.de>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Feb 20, 2010 at 07:51:20PM +0100, Hauke Mehrtens wrote:

> Ignoring the last page when ddr size is 128M. Cached
> accesses to last page is causing the processor to prefetch
> using address above 128M stepping out of the ddr address
> space.

Is this a hardware issue prefetching issue?  The kernel should not try
CPU prefetch instructions at all on non-coherent CPUs such as the
BCM47xx.

  Ralf
