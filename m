Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Mar 2010 18:49:12 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:33382 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492375Ab0CORtJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Mar 2010 18:49:09 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o2FHn6HA021200;
        Mon, 15 Mar 2010 18:49:07 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o2FHn5Xu021198;
        Mon, 15 Mar 2010 18:49:05 +0100
Date:   Mon, 15 Mar 2010 18:49:05 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wolfram Sang <w.sang@pengutronix.de>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        kernel-janitors@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arch/mips/txx9/generic: init dynamic bin_attribute
 structures
Message-ID: <20100315174905.GC20055@linux-mips.org>
References: <1268377431-11671-1-git-send-email-w.sang@pengutronix.de>
 <1268377431-11671-2-git-send-email-w.sang@pengutronix.de>
 <20100312183450.GC8736@core.coreip.homeip.net>
 <20100313022855.GD4034@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100313022855.GD4034@pengutronix.de>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Mar 13, 2010 at 03:28:55AM +0100, Wolfram Sang wrote:

> > Regarding all 3 - it looks like these dynamically alocated attributes
> > could be converted to statically allocated ones. I'd recommend doing
> > that instead (in fact, I posted patch for the firmware_class couple days
> > ago).
> 
> I agree for the firmware-patch. Regarding the MIPS one, 'size' might differ and
> 'private' will differ per instance. Regarding the RTC driver, 'size' might also
> differ. I don't know if somebody really wants two RTCs or the SRAM for MIPS can
> be instantiated more than once. Unless somebody with actual hardware jumps in,
> I'd say better safe than sorry.

On the txx9 platform you've posted the patch for additional RTCs or SRAMs
would not normally be expected.  On other platforms such as IP27 there
would be one per node that is potencially very many.

  Ralf
