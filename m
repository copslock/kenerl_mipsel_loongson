Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Sep 2008 11:19:40 +0100 (BST)
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:63362
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20030620AbYIBKTh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 Sep 2008 11:19:37 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m82AJOhH010781;
	Tue, 2 Sep 2008 11:19:25 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m82AJMIQ010778;
	Tue, 2 Sep 2008 11:19:22 +0100
Date:	Tue, 2 Sep 2008 11:19:22 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Adrian Bunk <bunk@kernel.org>
Cc:	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-mips@linux-mips.org, linux-pcmcia@lists.infradead.org,
	source@mvista.com
Subject: Re: [2.6 patch] remove drivers/pcmcia/au1000_pb1x00.c
Message-ID: <20080902101922.GC6155@linux-mips.org>
References: <20080831160951.GB3695@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080831160951.GB3695@cs181140183.pp.htv.fi>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20403
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Aug 31, 2008 at 07:09:52PM +0300, Adrian Bunk wrote:

> drivers/pcmcia/au1000_pb1x00.c was added in 2003 but #include's 
> linux/tqueue.h that was removed in 2002.
> 
> This file clearly never compiled after it was added to the tree.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
