Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2011 17:05:04 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:50820 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491152Ab1INPE7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Sep 2011 17:04:59 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p8EF4udu012992;
        Wed, 14 Sep 2011 17:04:56 +0200
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p8EF4qHF012987;
        Wed, 14 Sep 2011 17:04:52 +0200
Date:   Wed, 14 Sep 2011 17:04:52 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maxin B. John" <maxin.john@gmail.com>
Cc:     David Daney <david.daney@cavium.com>,
        Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: mm: tlbex.c: Fix compiler warnings
Message-ID: <20110914150452.GA12638@linux-mips.org>
References: <20110908220559.GA3040@maxin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110908220559.GA3040@maxin>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7183

On Fri, Sep 09, 2011 at 01:06:00AM +0300, Maxin B. John wrote:

>  CC      arch/mips/mm/tlbex.o
> cc1: warnings being treated as errors
> arch/mips/mm/tlbex.c: In function 'build_r3000_tlb_modify_handler':
> arch/mips/mm/tlbex.c:1769: error: 'wr.r1' is used uninitialized in this function
> arch/mips/mm/tlbex.c:1769: error: 'wr.r2' is used uninitialized in this function
> arch/mips/mm/tlbex.c:1769: error: 'wr.r3' is used uninitialized in this function
> make[2]: *** [arch/mips/mm/tlbex.o] Error 1
> make[1]: *** [arch/mips/mm] Error 2
> make: *** [arch/mips] Error 2

This was fixed by 949cb4ca0aa53e97ea5f524536593ad2d2946b73.  The real
fix to not pass the wr members to build_pte_modifiable() because they
just are not needed.

Thanks,

  Ralf
