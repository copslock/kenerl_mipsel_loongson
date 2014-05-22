Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 May 2014 15:36:38 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:56112 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6817074AbaEVNggbH2pA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 May 2014 15:36:36 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s4MDaZCI012202;
        Thu, 22 May 2014 15:36:35 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s4MDaZ9B012201;
        Thu, 22 May 2014 15:36:35 +0200
Date:   Thu, 22 May 2014 15:36:35 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Bolle <pebolle@tiscali.nl>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: BCM1480: remove checks for
 CONFIG_SIBYTE_BCM1480_PROF
Message-ID: <20140522133635.GE10287@linux-mips.org>
References: <1400750659.16832.24.camel@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1400750659.16832.24.camel@x220>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40242
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

On Thu, May 22, 2014 at 11:24:19AM +0200, Paul Bolle wrote:

> There are two checks for CONFIG_SIBYTE_BCM1480_PROF in the tree since
> v2.6.15. The related Kconfig symbol has never been added to the tree. So
> these checks have always evaluated to false. Besides, one of these
> checks guards a call of sbprof_cpu_intr(). But that function is not
> defined. Remove all this.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Untested.
> 
> Until v2.6.23 there also were checks for CONFIG_SIBYTE_SB1250_PROF in
> the tree. There also was a Kconfig symbol SIBYTE_SB1250_PROF so it was
> possible to make these checks evaluate to true. But, since one of these
> checks also guarded a call of sbprof_cpu_intr(), that should have made
> the build fail with an error.

The Sibyte profiling was far inferior to later solutions such as oprofile
or perf and non-standard anyway.  So let's kill what's left over.

  Ralf
