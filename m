Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Oct 2010 14:58:15 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:37257 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491137Ab0JUM6M (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Oct 2010 14:58:12 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o9LCwAV9006816;
        Thu, 21 Oct 2010 13:58:10 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o9LCw9xd006814;
        Thu, 21 Oct 2010 13:58:09 +0100
Date:   Thu, 21 Oct 2010 13:58:09 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/9] MIPS: Honor L2 bypass bit
Message-ID: <20101021125809.GA15031@linux-mips.org>
References: <74b5d3ba9506b2e6d885546bd6dcdaec@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74b5d3ba9506b2e6d885546bd6dcdaec@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28183
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 20, 2010 at 08:05:42PM -0700, Kevin Cernekee wrote:

> On many of the newer MIPS32 cores, CP0 CONFIG2 bit 12 (L2B) indicates
> that the L2 cache is disabled and therefore Linux should not attempt
> to use it.

I did a bit of research in the meantime.  Turns out that some MIPS
customers are using their own L2 cache controller.  That means a simple
check by the CPU PrID is not sufficient and we will need some sort of
platform-specific probe, sigh.

I've moved all the code your patch adds to a separate function and added
a comment so at least people working on platforms with different L2
conntrollers will have a small chance of figuring out what mine blew up
under their feet.

  Ralf
