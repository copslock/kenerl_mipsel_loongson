Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jan 2010 14:24:00 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:48823 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492627Ab0A2NX4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 29 Jan 2010 14:23:56 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o0TDO7k9016406;
        Fri, 29 Jan 2010 14:24:07 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o0TDO7GI016396;
        Fri, 29 Jan 2010 14:24:07 +0100
Date:   Fri, 29 Jan 2010 14:24:07 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Guenter Roeck <guenter.roeck@ericsson.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: Kernel crash in 2.6.32.6 / bcm1480 with 16k page size
Message-ID: <20100129132406.GD5685@linux-mips.org>
References: <20100128155514.GA31611@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100128155514.GA31611@ericsson.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 25736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18816

On Thu, Jan 28, 2010 at 07:55:14AM -0800, Guenter Roeck wrote:
> 
> I get the following kernel crash when running a 2.6.32.6 kernel on a bcm1480 cpu.
> It only happens if I configure a page size of 16k or 64k; 4k page size is fine.
> 
> A similar problem was recently fixed for ppc. It turned out to be a problem in ppc
> specific memory management code, so that fix won't help here.
> 
> Has anyone else seen this before ? Any idea where to start looking for the problem ?

Supposedly this was working for SB1.  I suggest you find an older kernel
version that works for your with 16k pages then use git bisect to find
the problem.

  Ralf
