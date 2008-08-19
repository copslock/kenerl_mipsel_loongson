Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2008 10:13:02 +0100 (BST)
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:57751
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20027600AbYHSJMy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Aug 2008 10:12:54 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m7J9CmgD027289;
	Tue, 19 Aug 2008 10:12:50 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m7J9Cl3L027286;
	Tue, 19 Aug 2008 10:12:47 +0100
Date:	Tue, 19 Aug 2008 10:12:47 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 0/2] Initial support for OCTEON
Message-ID: <20080819091247.GB28692@linux-mips.org>
References: <48A9E6DA.8030208@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48A9E6DA.8030208@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20252
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 18, 2008 at 02:17:14PM -0700, Tomaso Paoletti wrote:

> This is a first (trivial) set of patches to pave the way for support of  
> OCTEON processors in the kernel.
>
> The set adds:
> - Detection of OCTEON CPU variants in cpu_probe_cavium()
> - Processor ID (PrID) constants
> - Workaround (WAR) include file
>
> Please consider for inclusion.

So with the evil email monster having kept these mails without sharing them
with us...

I normally insist that there are users for new header files or functions
since otherwise the kernel janitors will remove them shortly ...

  Ralf
