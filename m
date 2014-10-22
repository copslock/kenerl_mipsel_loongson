Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 21:20:22 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:40952 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012165AbaJVTUUbPwIh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 Oct 2014 21:20:20 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s9MJKJd8016235;
        Wed, 22 Oct 2014 21:20:19 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s9MJKJZK016234;
        Wed, 22 Oct 2014 21:20:19 +0200
Date:   Wed, 22 Oct 2014 21:20:19 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Single MIPS kernel
Message-ID: <20141022192018.GD12502@linux-mips.org>
References: <20141022083437.GB18581@linux-mips.org>
 <5447F155.60106@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5447F155.60106@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43503
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

On Wed, Oct 22, 2014 at 11:03:01AM -0700, David Daney wrote:

> There is another reason to have a relocatable kernel:  The security people
> are starting to demand it so that they can randomize the load address.

That may work for some platforms - but in the MIPS world we still have to
deal with very claustrophobic systems which barely leave any space to
move a kernel around.

> This is the approach I was thinking of taking.  There would be a small PIC
> wrapper that applied the relocations, and then passed control to the real
> entry point.
> 
> We would have to be careful of the ex_table, as that is now sorted at build
> time.  For that, we could go to the scheme used by x86, and have that
> addresses in the ex_table be relative, build time sorting is already working
> for x86 relocatable kernels.

That's probably more of an implementation detail.  I'm more concerned about
the overall bloat.  I think many embedded users are so addivted to benchmark
results that this going to make or break the whole scheme.

  Ralf
