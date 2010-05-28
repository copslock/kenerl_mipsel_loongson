Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 May 2010 18:27:29 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:48805 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491896Ab0E1Q10 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 28 May 2010 18:27:26 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o4SGRNvv012425;
        Fri, 28 May 2010 17:27:25 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o4SGRMBp012423;
        Fri, 28 May 2010 17:27:22 +0100
Date:   Fri, 28 May 2010 17:27:22 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
Cc:     linux-mips <linux-mips@linux-mips.org>
Subject: Re: TITAN GE driver
Message-ID: <20100528162722.GB7148@linux-mips.org>
References: <A7DEA48C84FD0B48AAAE33F328C0201404E2D834@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A7DEA48C84FD0B48AAAE33F328C0201404E2D834@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26903
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, May 27, 2010 at 10:51:47PM -0700, Anoop P.A. wrote:

> Any body used titan GE device with more than 512MB physical memory?   
> 
>  
> 
> If buffer is getting allocated above physical address 0x1fff_ffff ( ie.
> 30 bit buffer address) we may have to consider setting XDMA_BUFFADDRPRE
> (0x5018 ) .This is not taken care in original driver.  Any body had luck
> in enabling this prefix. I have tried enabling it and I could do flood
> ping with out packet loss. However when I do mass data transfer kernel
> getting panic. Further investigation showed kenel panics because DMA
> copies data to wrong address (which is being used).

The driver has not been used in ages so it's generally in a sad shape,
doesn't even compile.  I think nobody touched this driver seriously in
5 years, probably longer.  So it's sort of expected to eat your cat or
do other nasty stuff.

  Ralf
