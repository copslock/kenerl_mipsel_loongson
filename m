Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Aug 2010 02:54:28 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:49570 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490947Ab0HWAyY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Aug 2010 02:54:24 +0200
Date:   Mon, 23 Aug 2010 01:54:24 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: MIPS: Get rid of branches to .subsections.
In-Reply-To: <20100818124310.GA23744@linux-mips.org>
Message-ID: <alpine.LFD.2.00.1008230139480.900@eddie.linux-mips.org>
References: <20100818124310.GA23744@linux-mips.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27661
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 18 Aug 2010, Ralf Baechle wrote:

> By rewriting the loop around all simple LL/SC blocks to C we reduce reduce
> the amount of inline assembler and at the same time allow GCC to often
> fill the branch delay slots with something sensible or whever else clever
> optimization it may have up in its sleeve.

 Are you sure it won't reorder anything there that actually relies on the 
atomic access to have succeeded?  I suggest adding barrier() after the 
loop.

  Maciej
