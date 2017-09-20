Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Sep 2017 16:07:43 +0200 (CEST)
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:10328 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991743AbdITOHfxEBup (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Sep 2017 16:07:35 +0200
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 5356D3F6A8;
        Wed, 20 Sep 2017 16:07:32 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1F2_sMtEe2me; Wed, 20 Sep 2017 16:07:29 +0200 (CEST)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 40CD23F53E;
        Wed, 20 Sep 2017 16:07:21 +0200 (CEST)
Date:   Wed, 20 Sep 2017 16:07:17 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: Add basic R5900 support
Message-ID: <20170920140715.GA9255@localhost.localdomain>
References: <20170911151737.GA2265@localhost.localdomain>
 <alpine.DEB.2.00.1709141423180.16752@tp.orcam.me.uk>
 <20170916133423.GB32582@localhost.localdomain>
 <alpine.DEB.2.00.1709171001160.16752@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1709171001160.16752@tp.orcam.me.uk>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
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

Hi Maciej,

>  Can you add a diagnostic consistency check to the context restoration 
> code, i.e. all the macros called from RESTORE_ALL (in <asm/stackframe.h>), 
> such as a `break 12' (BRK_BUG) instruction if a register value is not 
> correctly sign-extended?

Hmm... I think some details need to be sorted out for this. The LW
instruction used to restore registers sign-extends to register length by
definition (p. A-70 in the TX79 manual), so I assume that isn't what we
are going to check unless we suspect a grave hardware error with LW? (Do
we need to check the register values immediately prior to LW?)

Another possibility would be to check that saved registers in SAVE_ALL
will be restored properly. That is, immediately after SW check that LW
(to a temporary register such as k1) will restore to the same value by
64-bit comparison and trap if unequal (TNE). I thought that made sense.
Something like for example

	sw	$17, PT_R17(sp)
	lw	k1, PT_R17(sp)
	tne	k1, $17, 12

as a replacement for

	LONG_S	$17, PT_R17(sp)

in SAVE_STATIC?

A question is whether registers are clobbered within the kernel itself
(via interrupts or some such) or for user programs.

Fredrik
