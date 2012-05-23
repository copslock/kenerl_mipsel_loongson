Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 May 2012 12:00:09 +0200 (CEST)
Received: from h9.dl5rb.org.uk ([81.2.74.9]:53031 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903605Ab2EWKAG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 May 2012 12:00:06 +0200
Received: from h5.dl5rb.org.uk (h5.dl5rb.org.uk [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.5/8.14.3) with ESMTP id q4NA04hF020642;
        Wed, 23 May 2012 11:00:04 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.5/8.14.5/Submit) id q4NA03rG020641;
        Wed, 23 May 2012 11:00:03 +0100
Date:   Wed, 23 May 2012 11:00:03 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <sjhill@mips.com>
Cc:     linux-mips@linux-mips.org, Leonid Yegoshin <yegoshin@mips.com>
Subject: Re: [PATCH v2] Fix race condition with FPU thread task flag during
 context switch.
Message-ID: <20120523100003.GA25531@linux-mips.org>
References: <1336717702-731-1-git-send-email-sjhill@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1336717702-731-1-git-send-email-sjhill@mips.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33436
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, May 11, 2012 at 01:28:22AM -0500, Steven J. Hill wrote:

> From: "Steven J. Hill" <sjhill@mips.com>
> 
> Signed-off-by: Leonid Yegoshin <yegoshin@mips.com>
> Signed-off-by: Steven J. Hill <sjhill@mips.com>

Good catch - but r2300_switch.S and octeon_switch.S needed the same
modification.  Also, who is the author, Leonid or Steven?

  Ralf
