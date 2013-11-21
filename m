Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Nov 2013 23:43:05 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:34789 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6826005Ab3KUWnDoDWTC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Nov 2013 23:43:03 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id rALMh2bO031862;
        Thu, 21 Nov 2013 23:43:02 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id rALMh1YP031861;
        Thu, 21 Nov 2013 23:43:01 +0100
Date:   Thu, 21 Nov 2013 23:43:01 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: R2300 (not the hay baler)
Message-ID: <20131121224301.GY10382@linux-mips.org>
References: <528B466A.3050906@imgtec.com>
 <alpine.LFD.2.03.1311191156570.3267@linux-mips.org>
 <528B60B3.6030406@imgtec.com>
 <alpine.LFD.2.03.1311211934420.3267@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.03.1311211934420.3267@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38570
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

On Thu, Nov 21, 2013 at 07:52:04PM +0000, Maciej W. Rozycki wrote:

>  I think the discussion was off-list (Ralf, would you mind if I digged up 
> any clues from there?).

Please go ahead.

>  The format has been set long ago, and is also odd 
> enough to have 32 64-bit slots in the PTRACE_GETFPREGS/PTRACE_SETFPREGS 
> structure even for o32 processes (that now should be unexpectedly helpful 
> for FP64 o32 processes though), so there's little sense discussing its 
> prettiness or ugliness at this point in the game.
> 
>  Also I'm not sure what the core file format is for the FP context, it may 
> be worth double-checking too.

Is there some test suite for that kind of stuff?

>  Please feel free to poke me directly if you have any further issues about 
> MIPS I ISA compatibility.

Makes me wonder if there's a MIPS emulator that emulates a MIPS I system
faithfully.

  Ralf
