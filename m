Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Mar 2010 20:56:26 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:50338 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492490Ab0CPT4W (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Mar 2010 20:56:22 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o2GJuKgw008382;
        Tue, 16 Mar 2010 20:56:20 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o2GJuKcS008381;
        Tue, 16 Mar 2010 20:56:20 +0100
Date:   Tue, 16 Mar 2010 20:56:20 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 3/3] MIPS: Move signal trampolines off of the stack.
Message-ID: <20100316195619.GF20160@linux-mips.org>
References: <1266538385-29088-1-git-send-email-ddaney@caviumnetworks.com>
 <1266538385-29088-4-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1266538385-29088-4-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 18, 2010 at 04:13:05PM -0800, David Daney wrote:

> This is a follow on to the vdso patch.
> 
> Since all processes now have signal trampolines permanently mapped, we
> can use those instead of putting the trampoline on the stack and
> invalidating the corresponding icache across all CPUs.  We also get
> rid of a bunch of ICACHE_REFILLS_WORKAROUND_WAR code.

Thanks, applied.

  Ralf
