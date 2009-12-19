Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Dec 2009 23:07:48 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:32895 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1494515AbZLSWHp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 19 Dec 2009 23:07:45 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nBJM7iQS023634;
        Sat, 19 Dec 2009 22:07:44 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nBJM7i0E023631;
        Sat, 19 Dec 2009 22:07:44 GMT
Date:   Sat, 19 Dec 2009 22:07:43 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Dmitri Vorobiev <dmitri.vorobiev@movial.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] [MIPS] Fix MIPSsim build after command-line cleanup
Message-ID: <20091219220743.GA23526@linux-mips.org>
References: <20091205104158.GA11800@linux-mips.org>
 <1260014960-16415-1-git-send-email-dmitri.vorobiev@movial.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1260014960-16415-1-git-send-email-dmitri.vorobiev@movial.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Dec 05, 2009 at 02:09:20PM +0200, Dmitri Vorobiev wrote:

> Commit `MIPSsim: Remove unused code' removed the file
> arch/mips/mipssim/sim_cmdline.c but did not clean the
> reference to the corresponding object file.  This patch
> is to fix the build breakage resulted from the above.

I've already done this change myself to what was in the 2.6.33 before it
went upstream, so this is no longer necessary.

Thanks anyway!

  Ralf
