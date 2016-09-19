Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2016 00:30:32 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:60982 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992991AbcISWaZHbiS0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Sep 2016 00:30:25 +0200
Date:   Mon, 19 Sep 2016 23:30:25 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: dec: Avoid la pseudo-instruction in delay slots
In-Reply-To: <20160902141902.2478-1-paul.burton@imgtec.com>
Message-ID: <alpine.LFD.2.20.1609192323450.19345@eddie.linux-mips.org>
References: <20160902141902.2478-1-paul.burton@imgtec.com>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55188
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Fri, 2 Sep 2016, Paul Burton wrote:

> When expanding the la or dla pseudo-instruction in a delay slot the GNU
> assembler will complain should the pseudo-instruction expand to multiple
> actual instructions, since only the first of them will be in the delay
> slot leading to the pseudo-instruction being only partially executed if
> the branch is taken. Use of PTR_LA in the dec int-handler.S leads to
> such warnings:
> 
>   arch/mips/dec/int-handler.S: Assembler messages:
>   arch/mips/dec/int-handler.S:149: Warning: macro instruction expanded into multiple instructions in a branch delay slot
>   arch/mips/dec/int-handler.S:198: Warning: macro instruction expanded into multiple instructions in a branch delay slot
> 
> Avoid this by placing nops in the delay slots of the affected branches,
> leading to the PTR_LA macros being placed after the branches & their
> delay slots. Although the nop isn't strictly needed, it's an
> insignificant cost & satisfies the assembler easily with more
> readable code than the possible alternative of manually expanding the
> la/dla pseudo-instructions & placing the appropriate first instruction
> into the delay slots.

 I take it it's a quest for a clean compilation with no warnings reported, 
as the message is otherwise harmless and correct code is produced here.

 Some of the systems affected are not necessarily fast (e.g. clocked at 
12MHz), so I wonder if we shouldn't just bite the bullet and expand the 
%hi/%lo pair here.  Even with R4k DECstations we only support `-msym32' 
compilation only, due to R4k errata, so it's not like the higher parts 
will ever be needed for address calculation.

 Alternatively we could have a `.set warn'/`.set nowarn' setting in GAS, 
previously discussed I believe, although it would take a bit to propagate.

  Maciej
