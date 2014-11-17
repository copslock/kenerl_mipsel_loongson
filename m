Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Nov 2014 17:38:55 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26351 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013852AbaKQQijSHoJA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Nov 2014 17:38:39 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 863C6BDFE7531;
        Mon, 17 Nov 2014 16:38:30 +0000 (GMT)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 17 Nov
 2014 16:38:33 +0000
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by klmail02.kl.imgtec.org
 (10.40.60.222) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 17 Nov
 2014 16:38:33 +0000
Received: from [192.168.159.30] (192.168.159.30) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Mon, 17 Nov
 2014 08:38:30 -0800
Message-ID: <546A2482.2040902@imgtec.com>
Date:   Mon, 17 Nov 2014 10:38:26 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@codesourcery.com>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH 5/7] MIPS: Fix microMIPS LL/SC immediate offsets
References: <alpine.DEB.1.10.1411140122420.2881@tp.orcam.me.uk> <alpine.DEB.1.10.1411152113210.2881@tp.orcam.me.uk>
In-Reply-To: <alpine.DEB.1.10.1411152113210.2881@tp.orcam.me.uk>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.159.30]
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

On 11/15/2014 04:08 PM, Maciej W. Rozycki wrote:
> In the microMIPS encoding some memory access instructions have their 
> immediate offset reduced to 12 bits only.  That does not match the GCC 
> `R' constraint we use in some places to satisfy the requirement, 
> resulting in build failures like this:
> 
> {standard input}: Assembler messages:
> {standard input}:720: Error: macro used $at after ".set noat"
> {standard input}:720: Warning: macro instruction expanded into multiple instructions
> 
> Fix the problem by defining a macro, `GCC_OFF12_ASM', that expands to 
> the right constraint depending on whether microMIPS or standard MIPS 
> code is produced.  Also apply the fix to where `m' is used as in the 
> worst case this change does nothing, e.g. where the pointer was already 
> in a register such as a function argument and no further offset was 
> requested, and in the best case it avoids an extraneous sequence of up 
> to two instructions to load the high 20 bits of the address in the LL/SC 
> loop.  This reduces the risk of lock contention that is the higher the 
> more instructions there are in the critical section between LL and SC.
> 
> Strictly speaking we could just bulk-replace `R' with `ZC' as the latter 
> constraint adjusts automatically depending on the ISA selected.  
> However it was only introduced with GCC 4.9 and we keep supporing older 
> compilers for the standard MIPS configuration, hence the slightly more 
> complicated approach I chose.
> 
> The choice of a zero-argument function-like rather than an object-like 
> macro was made so that it does not look like a function call taking the 
> C expression used for the constraint as an argument.  This is so as not 
> to confuse the reader or formatting checkers like `checkpatch.pl' and 
> follows previous practice.
> 
> Signed-off-by: Maciej W. Rozycki <macro@codesourcery.com>
> ---
> 
I am extremely pleased with this patch. We had discussed this problem
and various potential solutions a year or two ago, but I was never able
to find time to look at it again. Thanks for figuring this out.


Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
