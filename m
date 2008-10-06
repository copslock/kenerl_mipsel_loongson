Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2008 00:26:29 +0100 (BST)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:28300 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S20764279AbYJFX0K (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2008 00:26:10 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m96NQ34Y013533;
	Tue, 7 Oct 2008 00:26:03 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m96NQ1aO013531;
	Tue, 7 Oct 2008 00:26:01 +0100
Date:	Tue, 7 Oct 2008 00:26:01 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	C Michael Sundius <Michael.sundius@sciatl.com>
Cc:	Andy Whitcroft <apw@shadowen.org>,
	Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org,
	linux-mips@linux-mips.org, "VomLehn, David" <dvomlehn@cisco.com>,
	me94043@yahoo.com
Subject: Re: Have ever checked in your mips sparsemem code into mips-linux
	tree?
Message-ID: <20081006232601.GB4376@linux-mips.org>
References: <48EA71F5.1040200@sciatl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48EA71F5.1040200@sciatl.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20689
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 06, 2008 at 01:15:49PM -0700, C Michael Sundius wrote:

Btw, I'm planning to rip support for discontig memory from MIPS.  IP27
is the only platform using it and it also would be better off using
sparsemem instead.

  Ralf
