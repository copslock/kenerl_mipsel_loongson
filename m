Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2011 17:12:36 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45041 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491152Ab1INPMc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Sep 2011 17:12:32 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p8EFCSX9013666;
        Wed, 14 Sep 2011 17:12:28 +0200
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p8EFCRPA013664;
        Wed, 14 Sep 2011 17:12:27 +0200
Date:   Wed, 14 Sep 2011 17:12:27 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
        David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: SMTC: Correct saving of CP0_STATUS
Message-ID: <20110914151227.GA13290@linux-mips.org>
References: <20110829232029.GA15763@zapo>
 <4E5C2490.6040203@cavium.com>
 <4E5C26D4.3000906@paralogos.com>
 <4E5C2B62.9040007@cavium.com>
 <4E5C3060.70302@paralogos.com>
 <20110830111603.GB14243@edde.se.axis.com>
 <4E5D15DD.2020201@paralogos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E5D15DD.2020201@paralogos.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31079
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7186

On Tue, Aug 30, 2011 at 09:54:53AM -0700, Kevin D. Kissell wrote:

> It could very well have been a QEMU issue.  At the time, I did spend
> a while staring at the diffs between the working and non-working
> kernel sources and I was unable to spot anything obviously suspect.
> > It makes me wonder, what is the state of SMTC kernels? Are they widely
> > used and considered stable?
> > Or is the SMP mode (1 TC per VPE) the common choice?
> The virtual SMP mode is far more common.  SMTC has the advantage
> that it allows the maximum throughput to be extracted from a 34K
> core - depending on the application/benchmark, the "sweet spot"
> may be more than 2 concurrent threads - but it's less well maintained.

Not to mention that SMTC was developed for a single 34K core.  It has
never been pimped up to support multi-core systems such as the 1004K
which would add some considerable complexity.

  Ralf
