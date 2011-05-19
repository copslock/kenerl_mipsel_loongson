Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 May 2011 13:06:46 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:38627 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491055Ab1ESLGk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 May 2011 13:06:40 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p4JB6dPt014486;
        Thu, 19 May 2011 12:06:39 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p4JB6cnl014484;
        Thu, 19 May 2011 12:06:38 +0100
Date:   Thu, 19 May 2011 12:06:38 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     dediao@cisco.com, ddaney@caviumnetworks.com, dvomlehn@cisco.com,
        sshtylyov@mvista.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] MIPS: HIGHMEM DMA on noncoherent MIPS32 processors
Message-ID: <20110519110638.GA11371@linux-mips.org>
References: <002fbbeb01a5a51fff8015af85d5d101@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002fbbeb01a5a51fff8015af85d5d101@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 13, 2010 at 04:57:35PM -0700, Kevin Cernekee wrote:

> [v4: Patch applies to linux-queue.git with kmap_atomic patches:
>  https://patchwork.kernel.org/patch/189932/
>  https://patchwork.kernel.org/patch/194552/
>  https://patchwork.kernel.org/patch/189912/ ]
> 
> The MIPS DMA coherency functions do not work properly (i.e. kernel oops)
> when HIGHMEM pages are passed in as arguments.  Use kmap_atomic() to
> temporarily map high pages for cache maintenance operations.
> 
> Tested on a 2.6.36-rc7 1GB HIGHMEM SMP no-alias system.

And I don't think it's going to work on an alias system.  __dma_sync maps
a page but it doesn't know the previous mapping (or could there be any
other mappings at the same time?).  That's going to fail with aliases.
Not that this was previously working so I don't blame you for it.

Who is the author of this patch, you or Dezhong Diao?

  Ralf
