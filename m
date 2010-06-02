Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jun 2010 16:16:00 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:59744 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491790Ab0FBOPx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Jun 2010 16:15:53 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o52EFpko016456;
        Wed, 2 Jun 2010 15:15:52 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o52EFpX5016454;
        Wed, 2 Jun 2010 15:15:51 +0100
Date:   Wed, 2 Jun 2010 15:15:51 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
Cc:     linux-mips <linux-mips@linux-mips.org>
Subject: Re: TITAN GE driver
Message-ID: <20100602141551.GA15753@linux-mips.org>
References: <A7DEA48C84FD0B48AAAE33F328C0201404E2D834@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
 <20100528162722.GB7148@linux-mips.org>
 <A7DEA48C84FD0B48AAAE33F328C0201404E2DC94@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
 <20100602083255.GA23868@linux-mips.org>
 <A7DEA48C84FD0B48AAAE33F328C0201404E2DCA0@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A7DEA48C84FD0B48AAAE33F328C0201404E2DCA0@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 27003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1382

On Wed, Jun 02, 2010 at 01:58:06AM -0700, Anoop P.A. wrote:

> [Anoop P.A.] You mean there are some flags available to force kmalloc to
> allocate memory below some address? I couldn't find one in kmalloc man
> pages.
> 
> BTW I am using 64 bit kernel.

There are:

 o GFP_DMA which usually means to allocate memory accessible to ISA DMA
   devices.
 o GFP_DMA32 which means memory in the low physical 4GB, that is memory
   accessible by 32-bit DMA devices.
 o GFP_HIGHMEM means any type of memory, even highmem.

All need to be explicitly supported by platform code which the existing
code doesn't.

Passing none of these flags would mean to allocate any non-highmem.  On
32-bit kernels that would be below 512MB physical but on 64-bit kernels
where there never is highmem it would just mean to allocate any memory.

I just hope the NIC isn't as braindead as you were describing but I got
no time to read up the docs again.

  Ralf
