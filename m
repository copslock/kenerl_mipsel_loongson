Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Apr 2009 12:41:35 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:45778 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20027132AbZDSLl1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 19 Apr 2009 12:41:27 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n3JBfJOx018834;
	Sun, 19 Apr 2009 13:41:20 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n3JBfFRE018832;
	Sun, 19 Apr 2009 13:41:15 +0200
Date:	Sun, 19 Apr 2009 13:41:15 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Ingo Molnar <mingo@elte.hu>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org,
	Eduard - Gabriel Munteanu <eduard.munteanu@linux360.ro>,
	Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: mips build failure
Message-ID: <20090419114115.GA28982@linux-mips.org>
References: <20090419172436.6d0e741a.sfr@canb.auug.org.au> <1240126361.3423.5.camel@falcon> <20090419081641.GA23906@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090419081641.GA23906@elte.hu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22373
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Apr 19, 2009 at 10:16:41AM +0200, Ingo Molnar wrote:

> > in reality, there is a previous email sent by Ralf for it:
> > 
> > http://lkml.indiana.edu/hypermail/linux/kernel/0904.2/01152.html
> 
> Yes, that looks like the right kind of fix.
> 
> Ralf, will you push that fix upstream, or should i do it?

Linus is cc'ed on that patch so expect this patch to show up in his tree
right after the weekend.

  Ralf
