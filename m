Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2010 15:33:19 +0200 (CEST)
Received: from arkanian.console-pimps.org ([212.110.184.194]:35160 "EHLO
        arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491159Ab0HRNdL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Aug 2010 15:33:11 +0200
Received: by arkanian.console-pimps.org (Postfix, from userid 1000)
        id 8B88548046; Wed, 18 Aug 2010 14:33:11 +0100 (BST)
Date:   Wed, 18 Aug 2010 14:33:11 +0100
From:   Matt Fleming <matt@console-pimps.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>, gcc@gcc.gnu.org
Subject: Re: MIPS: Get rid of branches to .subsections.
Message-ID: <20100818133311.GB17957@console-pimps.org>
References: <20100818124310.GA23744@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100818124310.GA23744@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <matt@console-pimps.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27633
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt@console-pimps.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 18, 2010 at 01:43:10PM +0100, Ralf Baechle wrote:
> It was a nice optimization - on paper at least.  In practice it results in
> branches that may exceed the maximum legal range for a branch.  We can
> fight that problem with -ffunction-sections but -ffunction-sections again
> is incompatible with -pg used by the function tracer.

I'm pretty sure that this check in GCC is historic. I know it has been
discussed in the past but I don't think a solution was ever reached
and my google skills are failing me, I can't find the discussion in
the archives.

We maintain a patch at work that removes this check because we always
use -ffunction-sections and also needed to be able to profile
things. We've never seen any issues.

GCC guys, is this check still needed? Does anyone know which
architecture required this restriction?
