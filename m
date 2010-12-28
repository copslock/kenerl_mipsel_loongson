Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Dec 2010 17:59:46 +0100 (CET)
Received: from p57B0EBE7.dip.t-dialin.net ([87.176.235.231]:33427 "EHLO
        h5.dl5rb.org.uk" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S1491021Ab0L1Q7j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Dec 2010 17:59:39 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oBSGxZIl004009;
        Tue, 28 Dec 2010 17:59:36 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oBSGxYHV004000;
        Tue, 28 Dec 2010 17:59:34 +0100
Date:   Tue, 28 Dec 2010 17:59:33 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: Declare uasm bbit0 and bbit1 functions.
Message-ID: <20101228165933.GB375@linux-mips.org>
References: <1292889290-12849-1-git-send-email-ddaney@caviumnetworks.com>
 <1292889290-12849-2-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1292889290-12849-2-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 20, 2010 at 03:54:49PM -0800, David Daney wrote:

> these are already defined, but declaring them allow them to be used
> outside of uasm.c.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
>  arch/mips/include/asm/uasm.h |    2 ++

Queued for 2.6.38 - but a few of your patches to uasm.h only apply with
fuzz so I'm wondering if I'm missing a patch or what your patches were
created against.

Thanks,

  Ralf
