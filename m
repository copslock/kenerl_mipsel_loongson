Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 May 2010 23:38:23 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:45073 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492078Ab0ETViS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 May 2010 23:38:18 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o4KLcAsH009079;
        Thu, 20 May 2010 22:38:11 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o4KLc8sF009076;
        Thu, 20 May 2010 22:38:08 +0100
Date:   Thu, 20 May 2010 22:38:08 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: Don't overflow cevt-r4k.c calculations at high
 clock rates.
Message-ID: <20100520213808.GA8391@linux-mips.org>
References: <1274290853-16947-1-git-send-email-ddaney@caviumnetworks.com>
 <alpine.LFD.2.00.1005191942130.3368@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1005191942130.3368@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26774
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 19, 2010 at 07:42:44PM +0200, Thomas Gleixner wrote:

> >  arch/mips/kernel/cevt-r4k.c |    5 ++---
> >  1 files changed, 2 insertions(+), 3 deletions(-)

Diffstat says it must be good :)

Thanks folks, applied!

  Ralf
