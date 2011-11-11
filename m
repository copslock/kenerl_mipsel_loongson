Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2011 13:58:38 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:58186 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903957Ab1KKM6f (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Nov 2011 13:58:35 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pABCwX2v008760;
        Fri, 11 Nov 2011 12:58:33 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pABCwXGe008758;
        Fri, 11 Nov 2011 12:58:33 GMT
Date:   Fri, 11 Nov 2011 12:58:33 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH V2 3/8] MIPS: BMIPS: Add CFLAGS, Makefile entries for
 BMIPS
Message-ID: <20111111125832.GE28303@linux-mips.org>
References: <5f9666eb295ce196b2a9688afab07dea@localhost>
 <f130d5d9c038f61fa3176b971526cd5f@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f130d5d9c038f61fa3176b971526cd5f@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31556
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10270

On Thu, Nov 10, 2011 at 10:30:26PM -0800, Kevin Cernekee wrote:

> +cflags-$(CONFIG_CPU_BMIPS)	+= -march=mips32 -Wa,-mips32 -Wa,--trap

> +#define MODULE_PROC_FAMILY "BMIPS "

If BMIPS is just a MIPS32 with no relevant extensions to the instruction
set, why don't you just call it a MIPS32 processor and use something
like CPU_MIPS32_R2?

It's small things like that which can sometimes avoid many unnecessary
recompilations which really saves times when rebuilding all defconfigs
on a way to slow machine :)

  Ralf
