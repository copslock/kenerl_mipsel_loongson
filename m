Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 May 2012 15:58:52 +0200 (CEST)
Received: from h9.dl5rb.org.uk ([81.2.74.9]:54688 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903607Ab2EWN6s (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 May 2012 15:58:48 +0200
Received: from h5.dl5rb.org.uk (h5.dl5rb.org.uk [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.5/8.14.3) with ESMTP id q4NDwlRf028248;
        Wed, 23 May 2012 14:58:47 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.5/8.14.5/Submit) id q4NDwkHX028246;
        Wed, 23 May 2012 14:58:46 +0100
Date:   Wed, 23 May 2012 14:58:46 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Hill, Steven" <sjhill@mips.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "Yegoshin, Leonid" <yegoshin@mips.com>
Subject: Re: [PATCH v2] Fix race condition with FPU thread task flag during
 context switch.
Message-ID: <20120523135846.GC25531@linux-mips.org>
References: <1336717702-731-1-git-send-email-sjhill@mips.com>
 <20120523100003.GA25531@linux-mips.org>
 <31E06A9FC96CEC488B43B19E2957C1B80114694EB4@exchdb03.mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31E06A9FC96CEC488B43B19E2957C1B80114694EB4@exchdb03.mips.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33438
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, May 23, 2012 at 01:34:04PM +0000, Hill, Steven wrote:

> Leonid is the author of this patch. The r2300_switch.S is easy enough to
> fix, but octeon_switch.S is nothing like the others, so someone else will
> have to fix that.

octeon_switch.S thanks to Octeon not featuring an FPU does not require
this fix.  I've already patched that up here, was just waiting for
confirmation of authorship to get the commit right.

Thanks!

  Ralf
