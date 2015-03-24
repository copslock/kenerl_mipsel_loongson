Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Mar 2015 16:39:59 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:45643 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009677AbbCXPj5pZu3x (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Mar 2015 16:39:57 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t2OFdvwh009227;
        Tue, 24 Mar 2015 16:39:57 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t2OFdvPi009226;
        Tue, 24 Mar 2015 16:39:57 +0100
Date:   Tue, 24 Mar 2015 16:39:57 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/4] EVA fixes
Message-ID: <20150324153956.GA8061@linux-mips.org>
References: <1425912892-23133-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1425912892-23133-1-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46507
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

On Mon, Mar 09, 2015 at 02:54:48PM +0000, Markos Chandras wrote:

> These four patches fix unaligned accesses when EVA is enabled. The fixes
> CC stable as well, because they need to be applied all the way back to
> the 3.15 kernels where EVA was originally introduced.
> 
> Markos Chandras (4):
>   MIPS: asm: asm-eva: Introduce kernel load/store variants
>   MIPS: unaligned: Prevent EVA instructions on kernel unaligned accesses
>   MIPS: unaligned: Surround load/store macros in do {} while statements
>   MIPS: unaligned: Fix regular load/store instruction emulation for EVA
> 
>  arch/mips/include/asm/asm-eva.h | 137 ++++++++++------
>  arch/mips/kernel/unaligned.c    | 340 +++++++++++++++++++++++++++-------------
>  2 files changed, 324 insertions(+), 153 deletions(-)

Applying these patches I found that 2/4 doesn't apply to v3.19- because
it relies on other patches that only exist on 4.0+.  Markos agreed to sort
out the issue and post a new patchset.  I've applied the patches for
mainline but will drop them for my -stable branches.

  Ralf
