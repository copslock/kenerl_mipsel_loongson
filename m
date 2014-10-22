Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2014 01:22:37 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:42257 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012187AbaJVXWftNnpv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Oct 2014 01:22:35 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s9MNMYGC020286;
        Thu, 23 Oct 2014 01:22:34 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s9MNMYqU020285;
        Thu, 23 Oct 2014 01:22:34 +0200
Date:   Thu, 23 Oct 2014 01:22:34 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
Subject: Re: Single MIPS kernel
Message-ID: <20141022232233.GF12502@linux-mips.org>
References: <20141022083437.GB18581@linux-mips.org>
 <5447F155.60106@gmail.com>
 <20141022192018.GD12502@linux-mips.org>
 <1414016140.5994.9.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1414016140.5994.9.camel@decadent.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43511
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

On Wed, Oct 22, 2014 at 11:15:40PM +0100, Ben Hutchings wrote:

> > 
> > That's probably more of an implementation detail.  I'm more concerned about
> > the overall bloat.  I think many embedded users are so addivted to benchmark
> > results that this going to make or break the whole scheme.
> 
> If you can make relocation a configuration option (as on x86), it would
> allow distributions to build multiplatform kernels without preventing
> embedded users from building a kernel optimised for their specific
> system.  But I know very little about MIPS or how intrusive the changes
> for relocation would have to be.  Perhaps it would be too much of a
> maintenance burden to make this an option.

The scope of the changes is relativly limited - we're much more concerned
about the impact on binary size, memory size or performance of the
various approaches under discussion.

I wonder kernels for which platforms would Debian want to unify?

  Ralf
