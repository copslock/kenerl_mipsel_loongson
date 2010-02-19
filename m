Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Feb 2010 14:57:36 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:39478 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492468Ab0BSN5c (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Feb 2010 14:57:32 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o1JDvT1s018845;
        Fri, 19 Feb 2010 14:57:30 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o1JDvSfb018843;
        Fri, 19 Feb 2010 14:57:28 +0100
Date:   Fri, 19 Feb 2010 14:57:27 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 0/3] MIPS vdso and signal delivery optimization (v2)
Message-ID: <20100219135727.GA15581@linux-mips.org>
References: <1266538385-29088-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1266538385-29088-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 18, 2010 at 04:13:02PM -0800, David Daney wrote:

> Before:
> n64 - Signal handler overhead: 14.517 microseconds
> n32 - Signal handler overhead: 14.497 microseconds
> o32 - Signal handler overhead: 16.637 microseconds
> 
> After:
> 
> n64 - Signal handler overhead: 7.935 microseconds
> n32 - Signal handler overhead: 7.334 microseconds
> o32 - Signal handler overhead: 8.628 microsecond

On a 180MHz 2 CPU single-node IP27:

Before:
Signal handler installation: 3.524 microseconds
Signal handler overhead: 37.009 microseconds
Protection fault: 4.264 microseconds

After:
Signal handler installation: 3.536 microseconds
Signal handler overhead: 14.331 microseconds
Protection fault: 3.600 microseconds

Everything meassured with very ancient O32 lmbench 2-alpha11 binaries.
IP27 has processors in separate packages so the cache-to-cache overhead
and thus the speedup is much higher than you have observed.

In 2.4 we used to have drastically better signal latency numbers btw.  I
wonder where all that performance went down the drain.

  Ralf
