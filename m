Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Feb 2014 16:57:32 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57760 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6834791AbaBDP5amw4Gm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 4 Feb 2014 16:57:30 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s14FvRhl017016;
        Tue, 4 Feb 2014 16:57:27 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s14FvQkH017015;
        Tue, 4 Feb 2014 16:57:26 +0100
Date:   Tue, 4 Feb 2014 16:57:26 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: mm: c-r4k: Detect instruction cache aliases
Message-ID: <20140204155726.GE19285@linux-mips.org>
References: <52E93795.8000205@imgtec.com>
 <1391102489-1403-1-git-send-email-markos.chandras@imgtec.com>
 <52EA9AEB.5090606@cogentembedded.com>
 <52EA8D77.2050804@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52EA8D77.2050804@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39207
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

On Thu, Jan 30, 2014 at 05:35:51PM +0000, Markos Chandras wrote:

> >>The *Aptiv cores can use the CONF7/IAR bit to detect if the core
> >>has hardware support to remove instruction cache aliasing.
> >
> >>This also defines the CONF7/AR bit in order to avoid using
> >>the '16' magic number.
> >
> >>Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> >[...]
> >
> >>diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> >>index 13b549a..8017f6e 100644
> >>--- a/arch/mips/mm/c-r4k.c
> >>+++ b/arch/mips/mm/c-r4k.c
> >>@@ -1110,7 +1110,10 @@ static void probe_pcache(void)
> >>      case CPU_PROAPTIV:
> >>          if (current_cpu_type() == CPU_74K)
> >>              alias_74k_erratum(c);
> >>-        if ((read_c0_config7() & (1 << 16))) {
> >>+        if (!(read_c0_config7() & MIPS_CONF7_IAR) &&
> >>+            (c->icache.waysize > PAGE_SIZE))
> >>+                c->icache.flags |= MIPS_CACHE_ALIASES;
> >
> >     Sigh, you forgot to "outdent" this statement by a tab... :-(
> >
> >WBR, Sergei
> >
> Indeed I did :) I will make sure the one committed will be fixed properly.
> 

I fixed that in my commit along with the non-Linux-codingstyle compliant
comment.

Thanks,

  Ralf
