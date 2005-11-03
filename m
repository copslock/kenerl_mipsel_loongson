Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Nov 2005 17:59:20 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:34843 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133864AbVKCR7D (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 3 Nov 2005 17:59:03 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jA3Hxlh0030322;
	Thu, 3 Nov 2005 17:59:47 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jA3HxkIV030321;
	Thu, 3 Nov 2005 17:59:46 GMT
Date:	Thu, 3 Nov 2005 17:59:46 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Clem Taylor <clem.taylor@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: 2.6.14 on Au1550 panics in free_hot_cold_page from init
Message-ID: <20051103175945.GA7461@linux-mips.org>
References: <ecb4efd10511021735m24778203rb3e816a0d9a62833@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecb4efd10511021735m24778203rb3e816a0d9a62833@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 02, 2005 at 08:35:25PM -0500, Clem Taylor wrote:

> I was wondering if anyone has gotten 2.6.14 to run on an Au1550. I had
> 2.6.14-rc2 mostly working (except for jffs2 writes) and was previously
> using 2.6.13 (had a jffs2 sync problem on reboot) and 2.6.11 (seems
> okay).
> 
> I tried out a linux-mips-git tree from this afternoon
> (6e47ab8b0ad1ca7bddbc086e2ce7736632c18df4). 2.6.14 is panicing right
> after the 'Freeing unused kernel memory' with:

What you're running is actually post-linux 2.6.14 already, with a few
megs of finest breakage of Linus merged in.  I suggest you try
what's tagged as linux-2.6.14 instead.

I'm currently aggressivly following Linus and so the repository is gets
all the good and bad stuff from kernel.org in undilluted form on the
master branch.

  Ralf
