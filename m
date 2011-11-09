Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2011 00:21:19 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:45649 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1904253Ab1KIXVP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Nov 2011 00:21:15 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pA9NLD4D005251;
        Wed, 9 Nov 2011 23:21:13 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pA9NLCqH005249;
        Wed, 9 Nov 2011 23:21:12 GMT
Date:   Wed, 9 Nov 2011 23:21:12 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Octeon: Fix compile error in
 arch/mips/cavium-octeon/flash_setup.c
Message-ID: <20111109232112.GA5197@linux-mips.org>
References: <1320880396-14193-1-git-send-email-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1320880396-14193-1-git-send-email-david.daney@cavium.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8313

On Wed, Nov 09, 2011 at 03:13:16PM -0800, David Daney wrote:

> The parse_mtd_partitions() and mtd_device_register() functions were
> combined into mtd_device_parse_register().  So call that instead.

Thanks, applied.

  Ralf
