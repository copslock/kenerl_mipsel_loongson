Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2014 11:58:20 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:51296 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008584AbaIRJ6RsGPXa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 18 Sep 2014 11:58:17 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s8I9wEEl010052;
        Thu, 18 Sep 2014 11:58:14 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s8I9wD0G010051;
        Thu, 18 Sep 2014 11:58:13 +0200
Date:   Thu, 18 Sep 2014 11:58:13 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     minyard@acm.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH] mips: Save all registers when saving the frame
Message-ID: <20140918095813.GA9804@linux-mips.org>
References: <1410903925-10744-1-git-send-email-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1410903925-10744-1-git-send-email-minyard@acm.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42673
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

On Tue, Sep 16, 2014 at 04:45:25PM -0500, minyard@acm.org wrote:

> From: Corey Minyard <cminyard@mvista.com>
> 
> The MIPS frame save code was just saving a few registers, enough to
> do a backtrace if every function set up a frame.  However, this is
> not working if you are using DWARF unwinding, because most of the
> registers are wrong.  This was causing kdump backtraces to be short
> or bogus.
> 
> So save all the registers.

The stratey of partial and full stack frames was developed in '97 to bring
down the syscall overhead.  It certaily was very effective - it brought
down the syscall latency to the level of Alphas running at much higher
clock.

That certainly worked well back then for kernel 2.0 / 2.2.  But the syscall
code has become much more complex.  Since then support for 64 bit kernels,
two 32 bit ABIs running on a 64 bit kernels and numerous features that
changed the once simple syscall path have been implemented.  My gut feeling
is it might be worth to yank out the whole optimization to see how much
code complexity we get rid of in exchange for how much extra syscall
latency.

  Ralf
