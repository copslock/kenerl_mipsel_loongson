Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Sep 2009 11:15:56 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:48438 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492205AbZIWJPs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 23 Sep 2009 11:15:48 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n8N9Ba1o005883;
	Wed, 23 Sep 2009 10:11:36 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n8N9Bahj005882;
	Wed, 23 Sep 2009 10:11:36 +0100
Date:	Wed, 23 Sep 2009 10:11:35 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jaswinder Singh Rajput <jaswinder@kernel.org>
Cc:	linux-mips <linux-mips@linux-mips.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: includecheck fix: smp.c
Message-ID: <20090923091135.GB5457@linux-mips.org>
References: <1253626167.3784.15.camel@ht.satnam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1253626167.3784.15.camel@ht.satnam>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 22, 2009 at 06:59:27PM +0530, Jaswinder Singh Rajput wrote:

> fix the following 'make includecheck' warning:
> 
>   arch/mips/kernel/smp.c: linux/smp.h is included more than once.
> 
> Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>

I've already merged a patch which didn't yet make it to kernel.org for this 
issue a few days ago.

Thanks anyway!

  Ralf
