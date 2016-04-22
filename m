Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Apr 2016 21:29:11 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:54380 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27027309AbcDVT3IYnvN2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Apr 2016 21:29:08 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u3MJT72P027323;
        Fri, 22 Apr 2016 21:29:07 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u3MJT7D5027322;
        Fri, 22 Apr 2016 21:29:07 +0200
Date:   Fri, 22 Apr 2016 21:29:07 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     "Maciej W. Rozycki" <macro@imgtec.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 3/4] MIPS: malta-time: Don't use PIT timer for cevt/csrc
Message-ID: <20160422192906.GO24051@linux-mips.org>
References: <1461345557-2763-1-git-send-email-james.hogan@imgtec.com>
 <1461345557-2763-4-git-send-email-james.hogan@imgtec.com>
 <alpine.DEB.2.00.1604221951290.21846@tp.orcam.me.uk>
 <20160422192312.GM7859@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160422192312.GM7859@jhogan-linux.le.imgtec.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53220
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

On Fri, Apr 22, 2016 at 08:23:12PM +0100, James Hogan wrote:

> >  Not everyone uses virtualisation, so it's a functional regression for 
> > them.  Can't you lower the priority for the timer instead so that it is 
> > not selected by default, just as it's done with other platforms providing 
> > a choice of timers?
> 
> I'll look into that. Looking back at my IRC logs I suspect I meant to
> check why the PIT was taking priority before submitting upstream, but
> forgot.

The PIT already has a very low rating and should only be used if everything
else fails.  Clock scaling for example would make the cycle counter
unusable, there might be no GIC available etc.  Otoh with SMP the PIT is
only usable as a clock source but not clock event device.

  Ralf
