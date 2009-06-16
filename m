Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jun 2009 12:33:17 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:33510 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492792AbZFPKdJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Jun 2009 12:33:09 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n5GAVb7P026591;
	Tue, 16 Jun 2009 11:31:37 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n5GAVbMK026589;
	Tue, 16 Jun 2009 11:31:37 +0100
Date:	Tue, 16 Jun 2009 11:31:37 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/2] Clean up CP0 hwrena code in traps.c
Message-ID: <20090616103137.GF13622@linux-mips.org>
References: <4A0B5077.2010600@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A0B5077.2010600@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 13, 2009 at 03:57:59PM -0700, David Daney wrote:

> There is an ugly #ifdef CONFIG_CPU_CAVIUM_OCTEON in the middle of
> traps.c.  We can get rid of it if we add a cpu feature for
> implementation dependent hwrena bits.  The first patch adds the
> feature macro and the second removes the #ifdef by setting the feature
> for Octeon.

I was wondering if maybe this should be a per-CPU thing but then again
hitting such a highly assymetric system is unlikely even in the embedded
world.

Thanks, queued for 2.6.31,

  Ralf
