Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 May 2014 15:26:50 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:56058 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6854801AbaEVN0sdRdGd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 May 2014 15:26:48 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s4MDQktO011809;
        Thu, 22 May 2014 15:26:46 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s4MDQjle011808;
        Thu, 22 May 2014 15:26:45 +0200
Date:   Thu, 22 May 2014 15:26:45 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Bolle <pebolle@tiscali.nl>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: cavium-octeon: remove checks for CONFIG_CAVIUM_GDB
Message-ID: <20140522132645.GC10287@linux-mips.org>
References: <1400602574.4912.43.camel@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1400602574.4912.43.camel@x220>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40240
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

On Tue, May 20, 2014 at 06:16:14PM +0200, Paul Bolle wrote:

> Three checks for CONFIG_CAVIUM_GDB were added in v2.6.29. But the
> Kconfig symbol CAVIUM_GDB was never added to the tree. Remove these
> checks.
> 
> Also remove the last reference to octeon_get_boot_debug_flag(). There is
> no definition of that function anyway.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>

Queued for 3.16.  Thanks Paul & Andreas!

> A follow up might be to remove plat_smp_ops.cpus_done. All these
> callbacks are now (basically) nops.

I'll think about it.  The hook is no useful if unused then again now and
then ordering issues in SMP startup of secondary CPUs are showing up and
it may be useful to solve those.  Maybe something like

void __init smp_cpus_done(unsigned int max_cpus)
{
- 	mp_ops->cpus_done();
+ 	if (cpus_done)
+ 		mp_ops->cpus_done();
}

which would make a NULL cpus_done function pointer safe and allow empty definitions
to be removed.

  Ralf
