Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jun 2010 10:33:02 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:46143 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492556Ab0FBIc6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Jun 2010 10:32:58 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o528Wv7B009830;
        Wed, 2 Jun 2010 09:32:57 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o528WuX6009828;
        Wed, 2 Jun 2010 09:32:56 +0100
Date:   Wed, 2 Jun 2010 09:32:56 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
Cc:     linux-mips <linux-mips@linux-mips.org>
Subject: Re: TITAN GE driver
Message-ID: <20100602083255.GA23868@linux-mips.org>
References: <A7DEA48C84FD0B48AAAE33F328C0201404E2D834@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
 <20100528162722.GB7148@linux-mips.org>
 <A7DEA48C84FD0B48AAAE33F328C0201404E2DC94@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A7DEA48C84FD0B48AAAE33F328C0201404E2DC94@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 26991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1106

On Wed, Jun 02, 2010 at 01:10:17AM -0700, Anoop P.A. wrote:

> >From the datasheets and design discussion it looks like prefix has been
> designed to be static i.e they are expecting all buffers to get
> allocated with same prefix. In another words all the buffers should be
> below < 0x1fff_ffff ( physical address) or between 0x2000_0000 and
> 0x3fff_ffff like that.
> 
> Is there any way to force kmalloc to allocate memory in certain region
> or below some region?

Nothing that would uniformly work for 32-bit and 64-bit kernels and also
Linux only has flags that allocate below certain addresses; nothing that
tells the allocator "give me something between 0x20000000 and 0x3fffffff".

  Ralf
