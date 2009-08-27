Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Aug 2009 12:57:07 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:41108 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492350AbZH0K47 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Aug 2009 12:56:59 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n7RAvwwV029899;
	Thu, 27 Aug 2009 11:57:58 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n7RAvwhx029897;
	Thu, 27 Aug 2009 11:57:58 +0100
Date:	Thu, 27 Aug 2009 11:57:58 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH] Alchemy: override loops_per_jiffy detection
Message-ID: <20090827105758.GA29561@linux-mips.org>
References: <1250957352-14359-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1250957352-14359-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Aug 22, 2009 at 06:09:12PM +0200, Manuel Lauss wrote:

> The loops_per_jiffy detection in generic calibrate_delay is a bit off
> (by ~0.5% usually); calculate the correct value based on detected core
> clock.  BogoMIPS value will now reflect cpu core clock correctly.

It think this is pretty much solving a non-problem.  The BogoMIPS number
should only be used for various delay functions and the only give a
guarantee for a minimum delay but barely any promise about accuracy of
the delay.  Due to interrupts consuming some CPU time and potencially
producing extra cache misses the measured BogoMIPS value is expected to
be a bit lower than what a naive calculation based on the CPU clock is
predicting; effects that not only impact the calculation of the BogoMIPS
number but also delays based on the BogoMIPS number.

Here's an even easier solution:

#include <linux/jiffies.h>
...
	preset_lpj = <loops_per_jiffie_value>;

Avoid the change to Kconfig that eventually will become messy if other
systems continue along this line.

  Ralf
