Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Sep 2015 20:36:32 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27013911AbbIRSg3PPVxa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Sep 2015 20:36:29 +0200
Date:   Fri, 18 Sep 2015 19:36:29 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
cc:     Luis Machado <lgustavo@codesourcery.com>,
        gdb-patches@sourceware.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Expect SI_KERNEL si_code for a MIPS software breakpoint
 trap
In-Reply-To: <55FC441F.6080804@gmail.com>
Message-ID: <alpine.LFD.2.20.1509181914150.10647@eddie.linux-mips.org>
References: <1442592647-3051-1-git-send-email-lgustavo@codesourcery.com> <alpine.LFD.2.20.1509181729100.10647@eddie.linux-mips.org> <55FC441F.6080804@gmail.com>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49238
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

On Fri, 18 Sep 2015, David Daney wrote:

> We have to be very careful changing the ABI here.
> 
> This is used by almost all userspace code to detect integer division by zero.
> Many things like the libgcj runtime use this to generate runtime exceptions,
> we don't want to break them.

 No worries here, integer division by 0 and overflow use `BREAK 7' and 
`BREAK 6' respectively (or corresponding trap instructions) and these 
cases are already handled correctly, as I implemented many years ago for 
regular MIPS user code and recently fixed for MIPS16 code (and less 
recently for microMIPS code as well).  Have a look at `do_trap_or_bp' in 
arch/mips/kernel/traps.c for details.

 There's no collision with `BREAK 5'; Linux code would of course have to 
treat 5 as an unrecognised for traps and would therefore handle the case 
right in `do_bp' like with kprobe breakpoints.

 I hope this clears your concerns.

  Maciej
