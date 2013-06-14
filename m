Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jun 2013 13:42:23 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:60761 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822998Ab3FNLmUF76vH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Jun 2013 13:42:20 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5EBfnF8020788;
        Fri, 14 Jun 2013 13:41:57 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5EBfI5R020745;
        Fri, 14 Jun 2013 13:41:18 +0200
Date:   Fri, 14 Jun 2013 13:41:18 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     linux-mips@linux-mips.org, kvm@vger.kernel.org,
        Sanjay Lal <sanjayl@kymasys.com>, linux-kernel@vger.kernel.org,
        David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH 01/31] MIPS: Move allocate_kscratch to cpu-probe.c and
 make it public.
Message-ID: <20130614114118.GD15775@linux-mips.org>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
 <1370646215-6543-2-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1370646215-6543-2-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36879
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

On Fri, Jun 07, 2013 at 04:03:05PM -0700, David Daney wrote:
> Date:   Fri,  7 Jun 2013 16:03:05 -0700
> From: David Daney <ddaney.cavm@gmail.com>
> To: linux-mips@linux-mips.org, ralf@linux-mips.org, kvm@vger.kernel.org,
>  Sanjay Lal <sanjayl@kymasys.com>
> Cc: linux-kernel@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>
> Subject: [PATCH 01/31] MIPS: Move allocate_kscratch to cpu-probe.c and make
>  it public.
> 
> From: David Daney <ddaney@caviumnetworks.com>

I'd just like to add a note about compatibility.  Code optimized for
LL/SC-less CPUs has made use of the fact that exception handlers will
clobber k0/k1 to a non-zero value.  On a MIPS II or better CPU a branch
likely instruction could be used to atomically test k0/k1 and depending
on the test, execute a store instruction like:

	.set	noreorder
	beqzl	$k0, ok
	sw	$reg, offset($reg)
	/* if we get here, our SC emulation has failed  */
ok:	...

In particular Sony had elected to do this for the R5900 (after I explained
the concept to somebody and told it'd be a _bad_ idea for compatibility
reasons).  Bad ideas are infectious so I'm sure others have used it, too.

I don't think this should stop your patch nor should we unless this turns
out to be an actual problem add any kludges to support such cowboy style
hacks.  But I wanted to mention and document the issue; maybe this should
be mentioned in the log message of the next version of this patch.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
