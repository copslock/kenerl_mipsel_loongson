Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Oct 2010 20:57:01 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:40029 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491132Ab0JQS46 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Oct 2010 20:56:58 +0200
Date:   Sun, 17 Oct 2010 19:56:58 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     "wilbur.chan" <wilbur512@gmail.com>
cc:     Adam Jiang <jiang.adam@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: Where is the definition of i_j macro ?
In-Reply-To: <AANLkTimkiwssyA=1Ub3qgekcsqECKPy+uuvFxkATqOmn@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1010171948440.15889@eddie.linux-mips.org>
References: <AANLkTik4BddKpVm0x4EpCKCdUff0L=XiYRjfhJaPmX23@mail.gmail.com>        <20101016155552.GE23119@capricorn-x61> <AANLkTimkiwssyA=1Ub3qgekcsqECKPy+uuvFxkATqOmn@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28123
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, 17 Oct 2010, wilbur.chan wrote:

> I_u1(_j);  They just make up pieces of  asm opt code into a  string
> and copy them to ebase:
> 
> memcpy((void *)ebase, final_handler, 0x100);
> 
> 
> Why they did like this seemed strange to me, maybe in the
> consideration of portability.

 This is a performance-critical piece of code that varies vastly across 
processors supported.  As we started losing control of the original 
preprocessor-based approach and had no way to keep performance optimal 
this way anyway, late Thiemo Seufer came up with this brilliant solution 
of generating this code at the run time, early during bootstrap.  This 
solution enabled us with tailoring code used specifically for each 
processor supported, up to including certain processor errata workarounds 
on the as-needed basis.

  Maciej
