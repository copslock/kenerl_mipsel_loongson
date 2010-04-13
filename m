Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Apr 2010 19:16:22 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:54552 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492525Ab0DMRQT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 13 Apr 2010 19:16:19 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o3DHGBvA017726;
        Tue, 13 Apr 2010 18:16:11 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o3DHGAKY017724;
        Tue, 13 Apr 2010 18:16:10 +0100
Date:   Tue, 13 Apr 2010 18:16:10 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Calculate proper ebase value for 64-bit kernels
Message-ID: <20100413171610.GA16578@linux-mips.org>
References: <1270585790-12730-1-git-send-email-ddaney@caviumnetworks.com>
 <1271135034.25797.41.camel@falcon>
 <20100413073435.GA6371@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100413073435.GA6371@alpha.franken.de>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26394
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 13, 2010 at 09:34:38AM +0200, Thomas Bogendoerfer wrote:

> On Tue, Apr 13, 2010 at 01:03:54PM +0800, Wu Zhangjin wrote:
> > This patch have broken the support to the MIPS variants whose
> > cpu_has_mips_r2 is 0 for the CAC_BASE and CKSEG0 is completely different
> > in these MIPSs.
> 
> I've checked R4k and R10k manulas and the exception base is at CKSEG0, so
> about CPU we are talking ? And wouldn't it make for senso to have
> an extra define for the exception base then ?

C0_ebase's design was a short-sigthed only considering 32-bit processors.
So the exception base is in CKSEG0 on every 64-bit processor, be it R2 or
older.  So yes, there is a bug as I've verified by testing but the patch
is unfortunately incorrect.

  Ralf
