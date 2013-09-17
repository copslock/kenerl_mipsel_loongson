Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2013 18:02:24 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46973 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6861528Ab3IQQCWJhBI- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Sep 2013 18:02:22 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r8HG2Kbo001174;
        Tue, 17 Sep 2013 18:02:20 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r8HG2JZX001173;
        Tue, 17 Sep 2013 18:02:19 +0200
Date:   Tue, 17 Sep 2013 18:02:19 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Fix accessing to per-cpu data when flushing the
 cache
Message-ID: <20130917160219.GF22468@linux-mips.org>
References: <1379411005-20829-1-git-send-email-markos.chandras@imgtec.com>
 <20130917104431.GB22468@linux-mips.org>
 <5238353B.9050001@imgtec.com>
 <20130917114356.GE22468@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130917114356.GE22468@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37834
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

On Tue, Sep 17, 2013 at 01:43:56PM +0200, Ralf Baechle wrote:

> > >I'd prefer if we change the caller otherwise depending on the platform
> > >a single cache flush might involve several preempt_disable/-enable
> > >invocations.  Something like below.
> > >
> > >And it also keeps the header file more usable outside the core kernel
> > >which Florian's recent zboot a little easier.
> > >
> > 
> > Hi Ralf,
> > 
> > Changing the caller instead of the function in the header file looks
> > good to me. Thanks for fixing it.
> 
> I think in the end the patch below is the better way of fixing it.

No, it's not.  Most systems have identical caches for all processors
in a system but there are exceptions, so my first patch is the right
one.

  Ralf
