Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Nov 2016 12:20:47 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:65084 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992078AbcKHLUk6iZog (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Nov 2016 12:20:40 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 12B71E5064A6B;
        Tue,  8 Nov 2016 11:20:32 +0000 (GMT)
Received: from [10.20.78.54] (10.20.78.54) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Tue, 8 Nov 2016
 11:20:33 +0000
Date:   Tue, 8 Nov 2016 11:20:24 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 03/10] MIPS: End asm function prologue macros with
 .insn
In-Reply-To: <12999809.y5kg6YqSxt@np-p-burton>
Message-ID: <alpine.DEB.2.20.17.1611080608140.10580@tp.orcam.me.uk>
References: <20161107111417.11486-1-paul.burton@imgtec.com> <20161107111417.11486-4-paul.burton@imgtec.com> <alpine.DEB.2.20.17.1611071400340.10580@tp.orcam.me.uk> <12999809.y5kg6YqSxt@np-p-burton>
User-Agent: Alpine 2.20.17 (DEB 179 2016-10-28)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.54]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

Hi Paul,

> And thanks for your review :)

 You're welcome!

> For the record, the reason I went with placing the EXPORT_SYMBOL invocations 
> at the start of the functions rather than the end is that the end isn't always 
> the end of the code in question. For example (until another patch of mine) 
> memcpy ends part way through user_copy, with code continuing afterwards. We 
> would then need to place a .insn after the use of EXPORT_SYMBOL if any code 
> may branch there. Containing the need for .insn to the start of the function 
> seems neater since a function should always begin with an instruction, which 
> after this patch will be marked as such, and users of the macros will just get 
> behaviour that seems natural & expected.

 Well, the real end is where END (`.end') is, and I think placing `.end' 
midway-through a code block is really bad style, partly because it affects 
frame annotation (all the stuff from `.frame', `.mask', etc.) recorded 
in the object assembled.  A LEAF/NESTED (`.ent') and END (`.end') pair 
should really only mark the physical beginning and ending of a whole 
single function.

 If a function has alternative entry points, then FEXPORT should be used 
for those, which on the MIPS target should include a `.aent' pseudo-op as 
a part of the symbol definition and I can't really tell why why we don't 
(trivial patch now in the works).

 NB in the MIPS assembly dialect `.type symbol, @function' is redundant in 
the presence of either `.ent symbol' or `.aent symbol', as is `.size 
symbol, . - symbol' where `.end symbol' is also present.  There's no harm 
either though.

> Of course another alternative would be to place EXPORT_SYMBOL before LEAF/
> NESTED/FEXPORT, but I don't think that would really make any difference  
> presuming people agree that this patch is a good idea regardless.

 TBH I do maintain keeping all the EXPORT_SYMBOL stuff outside function 
bodies would be the cleanest approach, grouping the handling for all given 
function's intended entry points after its final END, arranged as I 
described above.  Do you find this proposal problematic for some reason?

  Maciej
