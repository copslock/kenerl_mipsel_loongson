Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Mar 2011 15:13:10 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:46746 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491849Ab1CXONH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Mar 2011 15:13:07 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p2OEClpo000373;
        Thu, 24 Mar 2011 15:12:47 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p2OEClxS000365;
        Thu, 24 Mar 2011 15:12:47 +0100
Date:   Thu, 24 Mar 2011 15:12:47 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-mips@linux-mips.org
Subject: Re: [patch 05/38] mips: cavium-octeon: Convert to new irq_chip
 functions
Message-ID: <20110324141247.GE30990@linux-mips.org>
References: <20110323210437.398062704@linutronix.de>
 <20110323210535.042979916@linutronix.de>
 <4D8A66C5.4010503@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D8A66C5.4010503@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 23, 2011 at 02:31:49PM -0700, David Daney wrote:

> Argh!
> 
> This definitely collides with my Octeon IRQ rewrite, which does the
> same thing and more.  My patch is pending my cpu_{on,off}line chip
> function patch for the IRQ core.

I'll drop this patch and put 38/38 on hold for now then.

  Ralf
