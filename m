Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2015 02:11:00 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27006984AbbBXBK6sakUn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Feb 2015 02:10:58 +0100
Date:   Tue, 24 Feb 2015 01:10:58 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] Revert "MIPS: mm: tlbex: Use cpu_has_mips_r2_exec_hazard
 for the EHB instruction"
In-Reply-To: <1424731974-27926-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <alpine.LFD.2.11.1502240059330.17311@eddie.linux-mips.org>
References: <1424731974-27926-1-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45902
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

On Mon, 23 Feb 2015, David Daney wrote:

> From: David Daney <david.daney@cavium.com>
> 
> This reverts commit 77f3ee59ee7cfe19e0ee48d9a990c7967fbfcbed.
> 
> There are two problems:
> 
> 1) It breaks OCTEON, which will now crash in early boot with:
> 
>   Kernel panic - not syncing: No TLB refill handler yet (CPU type: 80)
> 
> 2) The logic is broken.
> 
> The meaning of cpu_has_mips_r2_exec_hazard is that the EHB instruction
> is required.  The offending patch attempts (and fails) to change the
> meaning to be that EHB is part of the ISA.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---

 Code affected will have to be reconsidered including possibly older 
changes as well.  Meanwhile, to revert the immediate regression, you have 
my:

Reviewed-by: Maciej W. Rozycki <macro@linux-mips.org>

Next time please try to use the imperative mood for the commit message 
though, as per Documentation/SubmittingPatches.

 Overall I think it makes sense to have a look back there every once in a 
while to avoid getting trapped in routine.  Some breakage we fall into 
from time to time results from missing the guidelines set there, sigh.

  Maciej
