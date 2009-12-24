Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Dec 2009 15:06:57 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57467 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492020AbZLXOGx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 Dec 2009 15:06:53 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nBOE6tVT031736;
        Thu, 24 Dec 2009 15:06:56 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nBOE6tuC031734;
        Thu, 24 Dec 2009 15:06:55 +0100
Date:   Thu, 24 Dec 2009 15:06:55 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Add sched_clock() to csrc-octeon.c
Message-ID: <20091224140655.GJ29598@linux-mips.org>
References: <1261603134-27310-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1261603134-27310-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25461
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 23, 2009 at 01:18:54PM -0800, David Daney wrote:

> With the advent of function graph tracing on MIPS, Octeon needs a high
> precision sched_clock() implementation.  Without it, most timing
> numbers are reported as 0.000.
> 
> This new sched_clock just uses the 64-bit cycle counter appropriately
> scaled.

Thanks, applied!

  Ralf
