Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Aug 2009 10:41:31 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:58572 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492204AbZHCIlY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Aug 2009 10:41:24 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n738frbg030649;
	Mon, 3 Aug 2009 09:41:53 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n738fqns030647;
	Mon, 3 Aug 2009 09:41:52 +0100
Date:	Mon, 3 Aug 2009 09:41:52 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Octeon: Run IPI code with interrupts disabled.
Message-ID: <20090803084152.GA30431@linux-mips.org>
References: <1249075807-18619-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1249075807-18619-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 31, 2009 at 02:30:07PM -0700, David Daney wrote:

> In mm/slab.c the function do_ccupdate_local requires that interrupts
> be disabled.  If they are not, we panic with CONFIG_DEBUG_SLAB.
> 
> So we disable interrupts while processing IPIs.  Also these are not
> shared irqs, so get rid of the IRQF_SHARED flag.

Yes, this one will ruin your day.

  Ralf
