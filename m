Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jun 2010 15:48:37 +0200 (CEST)
Received: from imr3.ericy.com ([198.24.6.13]:42246 "EHLO imr3.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491795Ab0FBNsa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Jun 2010 15:48:30 +0200
Received: from eusaamw0712.eamcs.ericsson.se ([147.117.20.181])
        by imr3.ericy.com (8.13.8/8.13.8) with ESMTP id o52DmCv7011264
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 2 Jun 2010 08:48:19 -0500
Received: from localhost (147.117.20.212) by eusaamw0712.eamcs.ericsson.se
 (147.117.20.182) with Microsoft SMTP Server id 8.2.234.1; Wed, 2 Jun 2010
 09:48:10 -0400
Date:   Wed, 2 Jun 2010 06:48:10 -0700
From:   Guenter Roeck <guenter.roeck@ericsson.com>
To:     "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: TITAN GE driver
Message-ID: <20100602134810.GC4388@ericsson.com>
References: <A7DEA48C84FD0B48AAAE33F328C0201404E2D834@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
 <20100528162722.GB7148@linux-mips.org>
 <A7DEA48C84FD0B48AAAE33F328C0201404E2DC94@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
 <20100602083255.GA23868@linux-mips.org>
 <A7DEA48C84FD0B48AAAE33F328C0201404E2DCA0@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <A7DEA48C84FD0B48AAAE33F328C0201404E2DCA0@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 27001
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1360

On Wed, Jun 02, 2010 at 04:58:06AM -0400, Anoop P.A. wrote:
> Ralf,
> 
> Thanks for the reply. 
> 
> > > allocated with same prefix. In another words all the buffers should
> be
> > > below < 0x1fff_ffff ( physical address) or between 0x2000_0000 and
> > > 0x3fff_ffff like that.
> > >
> > > Is there any way to force kmalloc to allocate memory in certain
> region
> > > or below some region?
> > 
> > Nothing that would uniformly work for 32-bit and 64-bit kernels and
> also
> > Linux only has flags that allocate below certain addresses; nothing
> that
> > tells the allocator "give me something between 0x20000000 and
> 0x3fffffff".
> > 
> >   Ralf
> [Anoop P.A.] You mean there are some flags available to force kmalloc to
> allocate memory below some address? I couldn't find one in kmalloc man
> pages.
> 
Ralf said "nothing". My reading is that such a flag is _not_ available.

Guenter
