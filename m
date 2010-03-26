Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Mar 2010 15:52:47 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:47348 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492070Ab0CZOwn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 26 Mar 2010 15:52:43 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o2QEqeYa026144;
        Fri, 26 Mar 2010 15:52:41 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o2QEqbbC026143;
        Fri, 26 Mar 2010 15:52:37 +0100
Date:   Fri, 26 Mar 2010 15:52:36 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Anton Altaparmakov <aia21@cam.ac.uk>
Cc:     Chris Dearman <chris@mips.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix __vmalloc(), etc on MIPS for non-GPL modules
Message-ID: <20100326145236.GX4554@linux-mips.org>
References: <Pine.LNX.4.64.1003252017360.17596@hermes-2.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1003252017360.17596@hermes-2.csi.cam.ac.uk>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26318
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 25, 2010 at 08:48:12PM +0000, Anton Altaparmakov wrote:

> The commit 351336929ccf222ae38ff0cb7a8dd5fd5c6236a0 which can be seen 
> here:

Which was in 2.6.26 ...

> I therefore propose that the EXPORT_SYMBOL_GPL(_page_cachable_default) is 
> changed to EXPORT_SYMBOL(_page_cachable_default) to re-instate the 
> ability for non-GPL modules to call __vmalloc(), vmap(), vm_map_ram(), 
> and such like.
> 
> Here is a patch that does this.  If you approve, please apply it.

I approve - but applying would be easier if this patch had not been
linewrapped ...

Applied to master and -stable.  Thanks!

  Ralf
