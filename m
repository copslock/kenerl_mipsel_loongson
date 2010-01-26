Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2010 14:08:40 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:49324 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1493316Ab0AZNIh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Jan 2010 14:08:37 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o0QD8iRO024009;
        Tue, 26 Jan 2010 14:08:45 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o0QD8i9Q024005;
        Tue, 26 Jan 2010 14:08:44 +0100
Date:   Tue, 26 Jan 2010 14:08:43 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David VomLehn <dvomlehn@cisco.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] powertv: streamline access to platform device registers
Message-ID: <20100126130843.GB17849@linux-mips.org>
References: <20091224013446.GA10835@dvomlehn-lnx2.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091224013446.GA10835@dvomlehn-lnx2.corp.sa.net>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 25670
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16669

On Wed, Dec 23, 2009 at 05:34:46PM -0800, David VomLehn wrote:

> Pre-compute addresses for the basic ASIC registers. This speeds up access
> and allows memory for unused configurations to be freed. In addition,
> uninitialized register addresses will be returned as NULL to catch bad
> usage quickly.
> 
> Signed-off-by: David VomLehn <dvomlehn@cisco.com>

Queued for 2.6.34.  Thanks!

  Ralf
