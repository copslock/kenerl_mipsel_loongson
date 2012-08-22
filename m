Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Aug 2012 23:43:59 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:41606 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903669Ab2HVVnz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 Aug 2012 23:43:55 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q7MLhqV3023671;
        Wed, 22 Aug 2012 23:43:52 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q7MLhoi3023660;
        Wed, 22 Aug 2012 23:43:50 +0200
Date:   Wed, 22 Aug 2012 23:43:50 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     John Crispin <john@phrozen.org>
Cc:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v2] spi: Add SPI master controller for OCTEON SOCs.
Message-ID: <20120822214350.GC22805@linux-mips.org>
References: <1345663507-15423-1-git-send-email-ddaney.cavm@gmail.com>
 <5035429B.6040202@phrozen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5035429B.6040202@phrozen.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 25021

On Wed, Aug 22, 2012 at 10:35:39PM +0200, John Crispin wrote:

> > Add the driver, link it into the kbuild system and provide device tree
> > binding documentation.
> > 
> > Signed-off-by: David Daney <david.daney@cavium.com>
> > Acked-by: Grant Likely <grant.likely@secretlab.ca>
> > ---
> > 
> > This should replace the version merged up by blogic.
> > 
> > It builds against linux-next where in addition to the fixes requested
> > by the SPI maintainers, I fixed some errors caused by now improper
> >  #includes.
> 
> Thanks, queued for 3.7 (replacing the previous version)

Updated also.  Thanks folks!

  Ralf
