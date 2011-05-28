Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 May 2011 22:56:39 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:51646 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491066Ab1E1U4g (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 28 May 2011 22:56:36 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p4SKudtk020038;
        Sat, 28 May 2011 21:56:40 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p4SKucar020036;
        Sat, 28 May 2011 21:56:38 +0100
Date:   Sat, 28 May 2011 21:56:38 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Rob Landley <rob@landley.net>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: MIPS panic in 2.6.39 (bisected to 7eaceaccab5f)
Message-ID: <20110528205638.GA20010@linux-mips.org>
References: <4DDB5673.5060206@landley.net>
 <20110524143937.GB30117@linux-mips.org>
 <4DDCB1EB.4020707@landley.net>
 <20110527075512.GE30117@linux-mips.org>
 <20110527140011.GF30117@linux-mips.org>
 <4DE0D303.8000106@landley.net>
 <20110528162807.GB7150@linux-mips.org>
 <4DE15373.8050708@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DE15373.8050708@landley.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, May 28, 2011 at 02:56:35PM -0500, Rob Landley wrote:

> > Thanks Rob!  I fixed that and the patch is now in the MIPS git.
> > 
> >   Ralf
> 
> Do you think it's a candidate for stable?

I'm afraid so it is indeed.  I copied the patch to the -stable branch
right away.

  Ralf
