Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2014 01:50:35 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:59569 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012836AbaKGAudW5BjX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Nov 2014 01:50:33 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sA70oWTf023490;
        Fri, 7 Nov 2014 01:50:32 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sA70oWgj023489;
        Fri, 7 Nov 2014 01:50:32 +0100
Date:   Fri, 7 Nov 2014 01:50:32 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Mans Rullgard <mans@mansr.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [RFC PATCH] MIPS: optimise 32-bit do_div() with constant divisor
Message-ID: <20141107005031.GA22697@linux-mips.org>
References: <1415290998-10328-1-git-send-email-mans@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1415290998-10328-1-git-send-email-mans@mansr.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43888
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

On Thu, Nov 06, 2014 at 04:23:18PM +0000, Mans Rullgard wrote:

> This is an adaptation of the optimised do_div() for ARM by
> Nicolas Pitre implementing division by a constant using a
> multiplication by the inverse.  Ideally, the compiler would
> do this internally as it does for 32-bit operands, but it
> doesn't.
> 
> This version of the code requires an assembler with support
> for the DSP ASE syntax since accessing the hi/lo registers
> sanely from inline asm is impossible without this.  Building
> for a CPU without this extension still works, however.
> 
> It also does not protect against the WAR hazards for the
> hi/lo registers present on CPUs prior to MIPS IV.
> 
> I have only tested it as far as booting and light use with
> the BUG_ON enabled wihtout encountering any issues.
> 
> The inverse computation code is a straight copy from ARM,
> so this should probably be moved to a shared location.

Can you explain why you need __div64_fls()?  There's __fls() which on
MIPS is carefully written to make use of the CLZ rsp. DCLZ instructions
where available; the fallback implementation is looking fairly similar
to your code.

MADD is named MAD on some older CPUs; yet other CPUs don't have it
at all.  I take it you tried to make GCC emit the instruction but it
doesn't?

  Ralf
