Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jun 2017 10:34:21 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:38118 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993972AbdF1IeNcyc4X (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Jun 2017 10:34:13 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v5S8YCde019683;
        Wed, 28 Jun 2017 10:34:12 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v5S8YBDq019681;
        Wed, 28 Jun 2017 10:34:11 +0200
Date:   Wed, 28 Jun 2017 10:34:11 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Matt Redfearn <Matt.Redfearn@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        James Hogan <James.Hogan@imgtec.com>,
        Paul Burton <Paul.Burton@imgtec.com>,
        Raghu Gandham <Raghu.Gandham@imgtec.com>,
        Douglas Leung <Douglas.Leung@imgtec.com>,
        Petar Jovanovic <Petar.Jovanovic@imgtec.com>,
        Miodrag Dinic <Miodrag.Dinic@imgtec.com>,
        Goran Ferenc <Goran.Ferenc@imgtec.com>
Subject: Re: [PATCH 3/8] MIPS: R6: Fix PREF instruction usage by memcpy for
 MIPS R6
Message-ID: <20170628083411.GD6738@linux-mips.org>
References: <1497887415-13825-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1497887415-13825-4-git-send-email-aleksandar.markovic@rt-rk.com>
 <a5842e4b-a75b-2dde-d835-6a488790dbda@imgtec.com>
 <20170628005853.GC6738@linux-mips.org>
 <alpine.DEB.2.00.1706280224120.31404@tp.orcam.me.uk>
 <9915e476-70fe-4281-a1e4-85ca2e8683b3@imgtec.com>
 <alpine.DEB.2.00.1706280329280.31404@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1706280329280.31404@tp.orcam.me.uk>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58844
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

On Wed, Jun 28, 2017 at 03:36:54AM +0100, Maciej W. Rozycki wrote:

> On Wed, 28 Jun 2017, Leonid Yegoshin wrote:
> 
> > The bigger problem is a prefetch overrun to device registers. AT use is just
> > nuisance.
> 
>  That isn't however what the patch addresses, not at least according to 
> the description provided.
> 
>  How far beyond the data copied do we prefetch anyway, and can't we simply 
> waste a page's worth of space or so at the physical end of each RAM area 
> present in a given system?  Or perhaps use it for something we know for 
> sure that won't ever be copied.

Prefetching may also bring data which has just been flushed back into
caches so until this is fixed properly it's not a good idea on non-coherent
platforms.

  Ralf
