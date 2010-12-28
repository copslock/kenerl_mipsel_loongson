Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Dec 2010 16:31:17 +0100 (CET)
Received: from p57B0EBE7.dip.t-dialin.net ([87.176.235.231]:48536 "EHLO
        h5.dl5rb.org.uk" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S1491020Ab0L1PbO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Dec 2010 16:31:14 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oBSFV9WI000969;
        Tue, 28 Dec 2010 16:31:10 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oBSFV8bo000964;
        Tue, 28 Dec 2010 16:31:08 +0100
Date:   Tue, 28 Dec 2010 16:31:07 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Use WARN() in uasm for better diagnostics.
Message-ID: <20101228153107.GA375@linux-mips.org>
References: <1293502709-11454-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1293502709-11454-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 27, 2010 at 06:18:29PM -0800, David Daney wrote:

> On the off chance that uasm ever warns about overflow, there is no way
> to know what the offending instruction is.
> 
> Change the printks to WARNs, so we can get a nice stack trace.  It has
> the added benefit of being much more noticeable than the short single
> line warning message, so is less likely to be ignored.

Time to interrupt vacation for some patches :-)

Queued for 2.6.38.  Thanks!

  Ralf
