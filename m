Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2017 13:35:47 +0100 (CET)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44772 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990504AbdLAMfhvkaKR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Dec 2017 13:35:37 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76B7880D;
        Fri,  1 Dec 2017 04:35:29 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F069E3F318;
        Fri,  1 Dec 2017 04:35:27 -0800 (PST)
Date:   Fri, 1 Dec 2017 12:35:25 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     "Maciej W. Rozycki" <macro@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        Paul Burton <Paul.Burton@mips.com>,
        Alex Smith <alex@alex-smith.me.uk>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 4/5] MIPS: Execute any partial write of the last register
 with PTRACE_SETREGSET
Message-ID: <20171201123525.GS22781@e103592.cambridge.arm.com>
References: <alpine.DEB.2.00.1711290152040.31156@tp.orcam.me.uk>
 <alpine.DEB.2.00.1711291226320.31156@tp.orcam.me.uk>
 <20171130172839.GQ22781@e103592.cambridge.arm.com>
 <alpine.DEB.2.00.1711301831540.31156@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1711301831540.31156@tp.orcam.me.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <Dave.Martin@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61262
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Dave.Martin@arm.com
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

From: Dave Martin <Dave.Martin@arm.com>
To: "Maciej W. Rozycki" <macro@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, James Hogan <james.hogan@mips.com>,
Subject: Re: [PATCH 4/5] MIPS: Execute any partial write of the last register
 with PTRACE_SETREGSET
In-Reply-To: <alpine.DEB.2.00.1711301831540.31156@tp.orcam.me.uk>

On Thu, Nov 30, 2017 at 07:38:25PM +0000, Maciej W. Rozycki wrote:

[...]

> > If we can end up with that somehow, then this patch reintroduces the
> > issue d614fd58a283 aims to fix, whereby fpr_val can contain
> > uninitialised kernel stack which userspace can then obtain via
> > PTRACE_GETREGSET.
> 
>  That wasn't actually clarified in the referred commit's description, 
> which it should in the first place, and I wasn't able to track down any 
> review of your change as submitted, which would be the potential second 
> source of such support information.  The description isn't even correct, 
> as it states that if a short buffer is supplied, then the old values held 
> in thread's registers are preserved, which clearly isn't correct as 
> individual registers do get written from the beginning of the regset up to 
> the point no more data is available to fill a whole register.

FYI, this this patch wasn't discussed on the public lists because of the
security implications of kernel stack exposure.  IIRC, James and Ralf
were Cc'd on the discussion.

There's an awkward balance to be struck between giving a full
description of the change and the motivation for it, and avoiding
announcing publicly exactly how to exploit the bug.  Opinions differ on
where the correct balance lies.

So, the commit message was intentionally kept vague, but could have
been better in this instance, since it doesn't correctly describe the
change as committed.

Cheers
---Dave
