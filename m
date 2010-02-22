Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Feb 2010 21:36:14 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:42620 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491834Ab0BVUgK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 22 Feb 2010 21:36:10 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o1MKa8ow003761;
        Mon, 22 Feb 2010 21:36:09 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o1MKa7CE003757;
        Mon, 22 Feb 2010 21:36:07 +0100
Date:   Mon, 22 Feb 2010 21:36:07 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Bcm47xx: Fix 128MB RAM support
Message-ID: <20100222203607.GA1548@linux-mips.org>
References: <1266691880-372-1-git-send-email-hauke@hauke-m.de>
 <20100222191440.GA12818@linux-mips.org>
 <4B82E827.8030005@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B82E827.8030005@hauke-m.de>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25984
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 22, 2010 at 09:25:11PM +0100, Hauke Mehrtens wrote:

> > Is this a hardware issue prefetching issue?  The kernel should not try
> > CPU prefetch instructions at all on non-coherent CPUs such as the
> > BCM47xx.
> 
> This is a hardware issue on the bcm47xx when 128MB ram is present. This
> workaround is out of broadcom's kernel sources and is included in
> OpenWRT for some months. Without this patch the kernel does not even
> print out anything and with this patch it is working.

Thanks!

I was asking to ensure this isn't a workaround for an already solved
kernel software issue.  Patch applied,

  Ralf
