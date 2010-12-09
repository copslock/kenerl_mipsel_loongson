Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Dec 2010 19:46:45 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:56951 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491194Ab0LISqm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Dec 2010 19:46:42 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oB9IkdaU019512;
        Thu, 9 Dec 2010 18:46:40 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oB9Ikcj6019510;
        Thu, 9 Dec 2010 18:46:39 GMT
Date:   Thu, 9 Dec 2010 18:46:38 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Dmitri Vorobiev <dmitri.vorobiev@movial.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Fix build failure for IP22
Message-ID: <20101209184638.GD30923@linux-mips.org>
References: <1290511948-10347-1-git-send-email-dmitri.vorobiev@movial.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1290511948-10347-1-git-send-email-dmitri.vorobiev@movial.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28629
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 23, 2010 at 01:32:28PM +0200, Dmitri Vorobiev wrote:

> Commit 48e1fd5a81416a037f5a48120bf281102f2584e2 changed the name
> of the MIPS-specific dma_cache_sync() routine by prefixing it with
> `mips_', and removed the export for its symbol. Two drivers, which
> did use dma_cache_sync(), namely, sgiseeq and sgiwd93, were not
> converted to use the new function, which led to build failure for
> the IP22 platform.
> 
> This patch fixes the build failure by fixing the call sites of
> mips_dma_cache_sync() and exporting the symbol for this routine as
> a GPL symbol. While at it, some minor changes to improve Kconfig
> help entries were done.

dma_cache_sync isn't MIPS specific - mips_dma_cache_sync is but the
function wasn't renamed everywhere.  Looking into what went wrong now
but your patch surely is not correct.

  Ralf
