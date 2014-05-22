Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 May 2014 10:01:32 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:54517 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822270AbaEVIB0L6VCE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 May 2014 10:01:26 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s4M80GNJ031818;
        Thu, 22 May 2014 10:00:16 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s4M7xYqt031779;
        Thu, 22 May 2014 09:59:34 +0200
Date:   Thu, 22 May 2014 09:59:34 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, David Daney <ddaney.cavm@gmail.com>,
        James Hogan <james.hogan@imgtec.com>, kvm@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 06/15] MIPS: Add minimal support for OCTEON3 to c-r4k.c
Message-ID: <20140522075934.GU10287@linux-mips.org>
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <1400597236-11352-7-git-send-email-andreas.herrmann@caviumnetworks.com>
 <20140521124041.GP10287@linux-mips.org>
 <20140521210212.GH11800@alberich>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140521210212.GH11800@alberich>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40233
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

On Wed, May 21, 2014 at 11:02:12PM +0200, Andreas Herrmann wrote:

> On Wed, May 21, 2014 at 02:40:41PM +0200, Ralf Baechle wrote:
> > On Tue, May 20, 2014 at 04:47:07PM +0200, Andreas Herrmann wrote:
> > 
> > > +static inline void r4k_blast_dcache_page_dc128(unsigned long addr)
> > > +{
> > > +	R4600_HIT_CACHEOP_WAR_IMPL;
> > 
> > The R4600 has 32 byte cache lines that is this line will never be
> > executed on an R4600 thus can be dropped.
> 
> So the line can also be removed from r4k_blast_dcache_page_dc64?

Yes, indeed.  Just did that now.

  Ralf
