Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Dec 2009 15:18:39 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:50124 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492027AbZLXOSg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 Dec 2009 15:18:36 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nBOEIcoQ032257;
        Thu, 24 Dec 2009 15:18:38 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nBOEIc8J032255;
        Thu, 24 Dec 2009 15:18:38 +0100
Date:   Thu, 24 Dec 2009 15:18:38 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David VomLehn <dvomlehn@cisco.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] powertv: Remove extra r4k_clockevent_init() call
Message-ID: <20091224141838.GK29598@linux-mips.org>
References: <20091222014342.GA29079@dvomlehn-lnx2.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091222014342.GA29079@dvomlehn-lnx2.corp.sa.net>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 21, 2009 at 05:43:42PM -0800, David VomLehn wrote:

> A call to r4k_clocksource_init() was added to plat_time_init(), but
> when init_mips_clock_source() calls the same function, boot fails in
> clockevents_register_device(). This patch removes the extraneous call.
> 
> Signed-off-by: David VomLehn <dvomlehn@cisco.com>

Applied.  Thanks, Merry Christmas & Happy New Year!

  Ralf
