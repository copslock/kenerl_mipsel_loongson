Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Nov 2010 05:24:00 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:45725 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492121Ab0KIEXR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 9 Nov 2010 05:23:17 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oA90mB2n010155;
        Tue, 9 Nov 2010 00:48:11 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oA90m9Qu010153;
        Tue, 9 Nov 2010 00:48:09 GMT
Date:   Tue, 9 Nov 2010 00:48:09 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Julia Lawall <julia@diku.dk>
Cc:     kernel-janitors@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/14] arch/mips/pmc-sierra/yosemite/setup.c: delete
 double assignment
Message-ID: <20101109004808.GA10116@linux-mips.org>
References: <1288088743-3725-1-git-send-email-julia@diku.dk>
 <1288088743-3725-7-git-send-email-julia@diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1288088743-3725-7-git-send-email-julia@diku.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28329
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 26, 2010 at 12:25:35PM +0200, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> Delete successive assignments to the same location.

[...]

> This change also makes the variable cpu_clock_freq be not used in the
> current file.  If this is the correct change to plat_time_init, then
> perhaps the declaration of that variable should be moved elsewhere, or the
> variable should be deleted completely.

The 2nd assignment is a temporary override for debugging purpose that is
it's there intionsionally.

Thanks!

  Ralf
