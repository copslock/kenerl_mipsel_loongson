Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 14:18:00 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:56715 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009598AbbCaMR6eNwiY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Mar 2015 14:17:58 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t2VCHwQb000720;
        Tue, 31 Mar 2015 14:17:58 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t2VCHws5000719;
        Tue, 31 Mar 2015 14:17:58 +0200
Date:   Tue, 31 Mar 2015 14:17:58 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] MIPS: R10000: Split R10000 definitions from R12000
 and up
Message-ID: <20150331121757.GD28951@linux-mips.org>
References: <54BFA0DF.8000104@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54BFA0DF.8000104@gentoo.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46647
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

On Wed, Jan 21, 2015 at 07:51:43AM -0500, Joshua Kinard wrote:

>  up
> Content-Type: text/plain; charset=utf-8
> 
> From: Joshua Kinard <kumba@gentoo.org>
> 
> This patch splits the old R10000 definitions so that the R10000_LLSC_WAR can be
> disabled and -mno-fix-r10000 passed to CFLAGS for systems running R12000 CPUs
> and greater.  This allows the kernel to build without branch-likely
> instructions, which are considered deprecated in current MIPS implementations.
>  Only R10000 systems with R2.6 and lower CPUs require branch-likely to work
> around a known hardware errata item.

The kernel doesn't use -mfix-r10000 rsp. -mno-fix-r10000 or any code that
would rely on the default setting for this option.  The kernel rather
opencodes all these atomic sequences in inline assembler.

Only platforms which are known to be equipped with R10000 v2.6 processors
enable R10000_LLSC_WAR and I've done so quite intentionally not just for
some CPU configuration but the entire platforms which at this time are IP27
and IP28.

Another mysterious question of course is why
arch/mips/include/asm/mach-pmcs-msp71xx/msp_regops.h caters for the case
where R10000_LLSC_WAR is enabled.  It won't be for that platform.

  Ralf
