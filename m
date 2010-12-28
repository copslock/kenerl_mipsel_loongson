Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Dec 2010 18:04:23 +0100 (CET)
Received: from p57B0EBE7.dip.t-dialin.net ([87.176.235.231]:37471 "EHLO
        h5.dl5rb.org.uk" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S1491021Ab0L1REU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Dec 2010 18:04:20 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oBSH4HJc004512;
        Tue, 28 Dec 2010 18:04:17 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oBSH4HhF004501;
        Tue, 28 Dec 2010 18:04:17 +0100
Date:   Tue, 28 Dec 2010 18:04:17 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2 2/3] MIPS: Add DINSM to uasm.
Message-ID: <20101228170416.GE375@linux-mips.org>
References: <1292969951-11418-1-git-send-email-ddaney@caviumnetworks.com>
 <1292969951-11418-3-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1292969951-11418-3-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28740
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 21, 2010 at 02:19:10PM -0800, David Daney wrote:

>  arch/mips/include/asm/uasm.h |    1 +

The same uasm.h fuzz problem with this patch as previously mentioned.

Queued for 2.6.38.  Thanks,

  Ralf
