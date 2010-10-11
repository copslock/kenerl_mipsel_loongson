Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Oct 2010 14:40:33 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:40255 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490958Ab0JKMka (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 11 Oct 2010 14:40:30 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o9BCeQJe027241;
        Mon, 11 Oct 2010 13:40:26 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o9BCeP5K027240;
        Mon, 11 Oct 2010 13:40:25 +0100
Date:   Mon, 11 Oct 2010 13:40:25 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wim Van Sebroeck <wim@iguana.be>
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 13/14] watchdog: octeon-wdt: Use I/O clock rate for
 timing calculations.
Message-ID: <20101011124025.GA27237@linux-mips.org>
References: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com>
 <1286492633-26885-14-git-send-email-ddaney@caviumnetworks.com>
 <20101010182342.GC24194@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20101010182342.GC24194@infomag.iguana.be>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28021
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Oct 10, 2010 at 08:23:42PM +0200, Wim Van Sebroeck wrote:

> > The creation of the I/O clock domain requires some adjustments.  Since
> > the watchdog counters are clocked by the I/O clock, use its rate for
> > timing calculations.
> > 
> > Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> > Cc: Wim Van Sebroeck <wim@iguana.be>
> > Cc: linux-watchdog@vger.kernel.org
> 
> Signed-off-by: Wim Van Sebroeck <wim@iguana.be> .
> 
> I prefer this one to go through the mips tree.

Yes, there are dependencies on other patches.  Applied.

Thanks!

  Ralf
