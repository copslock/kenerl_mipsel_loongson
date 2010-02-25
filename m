Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2010 15:15:55 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:54367 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491848Ab0BYOPv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Feb 2010 15:15:51 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o1PEFn4J006682;
        Thu, 25 Feb 2010 15:15:49 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o1PEFnbo006680;
        Thu, 25 Feb 2010 15:15:49 +0100
Date:   Thu, 25 Feb 2010 15:15:49 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Optimize spinlocks.
Message-ID: <20100225141548.GB29565@linux-mips.org>
References: <1265311909-1679-1-git-send-email-ddaney@caviumnetworks.com>
 <20100224155336.GA5130@linux-mips.org>
 <4B8559F0.6080908@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B8559F0.6080908@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26044
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 24, 2010 at 08:55:12AM -0800, David Daney wrote:

> It is possible that by choosing a better nudge_writes()
> implementation for R10K, that the 3% degradation could be erased.
> Perhaps:
> 
> #define nudge_writes() do { } while (0)

raw_spin_unlock must provide a barrier so this wouldn't be a valid
implementation for nudge_writes().  Implementing it as barrier() this
is a pure compiler barrier is the most liberal valid implementation.

> Basically you want something that is fast, but that also forces the
> write to be globally visible as soon as possible.  Some processors
> have a prefetch instruction that does this.  On other processors a
> NOP is optimal as they don't combine writes in the write back
> buffer.
> 
> There is a wbflush() function that could potentially be used, but
> its implementation is too heavy on Octeon.

For IP27 which is a strongly ordered system nudge_writes() is implemented
as barrier().

Another experiment I did was alignment.  A branch on an R10000 has a
significant execution time penalty if it's delay slot is overlapping a
128 byte S-cache boundary.  Suitable alignment however didn't not seem
to make any difference at all on R10000.

  Ralf
