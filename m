Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Dec 2010 18:00:18 +0100 (CET)
Received: from p57B0EBE7.dip.t-dialin.net ([87.176.235.231]:33430 "EHLO
        h5.dl5rb.org.uk" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S1491021Ab0L1RAH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Dec 2010 18:00:07 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oBSH0313004031;
        Tue, 28 Dec 2010 18:00:03 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oBSH03AV004030;
        Tue, 28 Dec 2010 18:00:03 +0100
Date:   Tue, 28 Dec 2010 18:00:03 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: Use BBIT instructions in TLB handlers
Message-ID: <20101228170003.GC375@linux-mips.org>
References: <1292889290-12849-1-git-send-email-ddaney@caviumnetworks.com>
 <1292889290-12849-3-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1292889290-12849-3-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28738
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 20, 2010 at 03:54:50PM -0800, David Daney wrote:

> If the CPU supports BBIT0 and BBIT1, use them in TLB handlers as they
> are more efficient than an AND followed by an branch and then
> restoring the clobbered register.

Queued for 2.6.38.  Thanks,

  Ralf
