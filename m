Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Apr 2010 19:05:06 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:42252 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492489Ab0DGRFD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Apr 2010 19:05:03 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o37H4YQr027950;
        Wed, 7 Apr 2010 18:04:34 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o37H4Wee027927;
        Wed, 7 Apr 2010 18:04:32 +0100
Date:   Wed, 7 Apr 2010 18:04:32 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Julia Lawall <julia@diku.dk>
Cc:     peterz@infradead.org, mingo@elte.hu, tglx@linutronix.de,
        oleg@redhat.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 4/7] arch/mips/kernel: Use set_cpus_allowed_ptr
Message-ID: <20100407170432.GB26242@linux-mips.org>
References: <Pine.LNX.4.64.1003262302480.6480@ask.diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1003262302480.6480@ask.diku.dk>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26368
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 26, 2010 at 11:03:07PM +0100, Julia Lawall wrote:

> From: Julia Lawall <julia@diku.dk>
> 
> Use set_cpus_allowed_ptr rather than set_cpus_allowed.

Thanks Julia, queued for 2.6.35.

  Ralf
