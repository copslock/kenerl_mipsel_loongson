Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 May 2010 00:52:34 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:34877 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492206Ab0ERWwb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 May 2010 00:52:31 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o4IMqIb7020351;
        Tue, 18 May 2010 23:52:19 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o4IMqGZA020349;
        Tue, 18 May 2010 23:52:16 +0100
Date:   Tue, 18 May 2010 23:52:16 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] MIPS: Don't overflow cevt-r4k.c calculations at high
 clock rates.
Message-ID: <20100518225216.GA18701@linux-mips.org>
References: <1274220676-4562-1-git-send-email-ddaney@caviumnetworks.com>
 <4BF31931.5040704@paralogos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BF31931.5040704@paralogos.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26758
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 18, 2010 at 03:48:17PM -0700, Kevin D. Kissell wrote:

> Easy for me to say, of course, but once this patch is accepted, the
> same thing needs to be done to smtc_clockevent_init() in
> cevt-smtc.c.

Thanks for the reminder, Kevin.  I'll take care of it.

That said, testing might be a bit harder - there is not enough liquid
helium on the world to get my CoreFPGA3 to run at > 1GHz.

  Ralf
