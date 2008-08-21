Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Aug 2008 07:58:44 +0100 (BST)
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:1949
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20026196AbYHUG60 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 21 Aug 2008 07:58:26 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m7L6wFa9025542;
	Thu, 21 Aug 2008 07:58:17 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m7L6wEga025540;
	Thu, 21 Aug 2008 07:58:14 +0100
Date:	Thu, 21 Aug 2008 07:58:14 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] OCTEON: Add workaround file
Message-ID: <20080821065813.GA12645@linux-mips.org>
References: <48A9E6DA.8030208@caviumnetworks.com> <1219263625-21540-1-git-send-email-tpaoletti@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1219263625-21540-1-git-send-email-tpaoletti@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 20, 2008 at 01:20:25PM -0700, Tomaso Paoletti wrote:

> Add OCTEON specific version of the workarounds file.
> None of these apply to OCTEON, but the file is required.

Yes - intentionally.  I want to force people having to think about if they
need any of the workaround enabled because the bugs from not having a
necessary workaround enabled could be painfully subtle.

  Ralf
