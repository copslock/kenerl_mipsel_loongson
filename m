Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jun 2013 16:35:55 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:57064 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6834874Ab3FMOfecqd5p (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Jun 2013 16:35:34 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5DEZUZC025180;
        Thu, 13 Jun 2013 16:35:30 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5DEZSdA025179;
        Thu, 13 Jun 2013 16:35:28 +0200
Date:   Thu, 13 Jun 2013 16:35:28 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: OCTEON: Don't clobber bootloader data structures.
Message-ID: <20130613143528.GC22906@linux-mips.org>
References: <1371061713-29028-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1371061713-29028-1-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36855
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

On Wed, Jun 12, 2013 at 11:28:33AM -0700, David Daney wrote:

> Commit abe77f90dc (MIPS: Octeon: Add kexec and kdump support) added a
> bootmem region for the kernel image itself.  The problem is that this
> is rounded up to a 0x100000 boundary, which is memory that may not be
> owned by the kernel.  Depending on the kernel's configuration based
> size, this 'extra' memory may contain data passed from the bootloader
> to the kernel itself, which if clobbered makes the kernel crash in
> various ways.
> 
> The fix: Quit rounding the size up, so that we only use memory
> assigned to the kernel.
> 
> Can be applied to v3.8 and later.

Thanks, applied.  Will send to Linus with the next pull request.

  Ralf
