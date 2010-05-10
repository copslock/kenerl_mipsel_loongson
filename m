Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 May 2010 22:20:08 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:37995 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492540Ab0EJUUF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 May 2010 22:20:05 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o4AKK0Sk000450;
        Mon, 10 May 2010 21:20:01 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o4AKJxSf000448;
        Mon, 10 May 2010 21:19:59 +0100
Date:   Mon, 10 May 2010 21:19:59 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: nofpu and nodsp only affect CPU0
Message-ID: <20100510201959.GB28820@linux-mips.org>
References: <0b6db1ee1efbe0daa1320b59ab5093ba5af377b8@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b6db1ee1efbe0daa1320b59ab5093ba5af377b8@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26652
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, May 02, 2010 at 02:43:52PM -0700, Kevin Cernekee wrote:

> The "nofpu" and "nodsp" kernel command line options currently do not
> affect CPUs that are brought online later in the boot process or
> hotplugged at runtime.  It is desirable to apply the nofpu/nodsp options
> to all CPUs in the system, so that surprising results are not seen when
> a process migrates from one CPU to another.

I like this patch; this solution is also cleaner than iterating over the
cpu data array.  However as it constitutes a change in established kernel
behaviour I prefer to queue this patch for 2.6.35 rather than applying it
immediately.

Thanks!

  Ralf
