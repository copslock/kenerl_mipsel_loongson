Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jul 2017 12:56:18 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52684 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992936AbdGKK4Ivj80p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Jul 2017 12:56:08 +0200
Date:   Tue, 11 Jul 2017 11:56:08 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: Fix MIPS I ISA /proc/cpuinfo reporting
In-Reply-To: <20170711101746.GQ31455@jhogan-linux.le.imgtec.org>
Message-ID: <alpine.LFD.2.20.1707111149220.2054@eddie.linux-mips.org>
References: <alpine.LFD.2.20.1707082259380.5208@eddie.linux-mips.org> <20170711101746.GQ31455@jhogan-linux.le.imgtec.org>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59092
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

On Tue, 11 Jul 2017, James Hogan wrote:

> On Sat, Jul 08, 2017 at 11:24:44PM +0100, Maciej W. Rozycki wrote:
> > Cc: stable@vger.kernel.org # 3.19+
> > Fixes: 515a6393dbac ("MIPS: kernel: proc: Add MIPS R6 support to /proc/cpuinfo")
> 
> That commit landed in v4.0-rc1, not 3.19.

 Hmm:

$ git show 515a6393dbac:Makefile | head -5
VERSION = 3
PATCHLEVEL = 19
SUBLEVEL = 0
EXTRAVERSION = -rc4
NAME = Diseased Newt
$ 

I just trusted that.

> Most stable tags with comments also have square brackets around the
> email too, i.e.:
> Cc: <stable@vger.kernel.org> # 4.0+
> 
> (though maybe thats just not to confuse git-send-email).

 It doesn't seem so obvious, it looks fairly random to me.  If you say 
it helps, then I can adjust -- any pointers to a previous discussion?

> Otherwise:
> Reviewed-by: James Hogan <james.hogan@imgtec.com>
> 
> Nice catch!

 Thanks for your review.  I actually spotted it visually in the course 
of the recent Octeon ISA level discussion, before verifying the fix with 
actual hardware.

  Maciej
