Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Apr 2010 17:39:54 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:37742 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492398Ab0DGPjv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Apr 2010 17:39:51 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o37FdgqY025150;
        Wed, 7 Apr 2010 16:39:42 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o37FddpJ025148;
        Wed, 7 Apr 2010 16:39:39 +0100
Date:   Wed, 7 Apr 2010 16:39:39 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Calculate proper ebase value for 64-bit kernels
Message-ID: <20100407153937.GA24982@linux-mips.org>
References: <1270585790-12730-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1270585790-12730-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26361
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 06, 2010 at 01:29:50PM -0700, David Daney wrote:

> The ebase is relative to CKSEG0 not CAC_BASE.  On a 32-bit kernel they
> are the same thing, for a 64-bit kernel they are not.
> 
> It happens to kind of work on a 64-bit kernel as they both reference
> the same physical memory.  However since the CPU uses the CKSEG0 base,
> determining if a J instruction will reach always gives the wrong
> result unless we use the same number the CPU uses.

Applied, thanks!

  Ralf
