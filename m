Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 May 2008 22:58:46 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:57805 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20048428AbYEDV6o (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 4 May 2008 22:58:44 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m44LwcAr011294;
	Sun, 4 May 2008 22:58:38 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m44LwbMO011293;
	Sun, 4 May 2008 22:58:37 +0100
Date:	Sun, 4 May 2008 22:58:37 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix __fls for non mips32/mips64 cpus
Message-ID: <20080504215837.GA10198@linux-mips.org>
References: <20080503222502.52F3BFAB11@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080503222502.52F3BFAB11@solo.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, May 04, 2008 at 12:25:02AM +0200, Thomas Bogendoerfer wrote:

> Only MIPS32 and MIPS64 CPUs implement clz/dclz. Therefore don't
> export __ilog2() for non MIPS32/MIPS64 cpus and use generic
> __fls bitop code for these cpus.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Applied, thanks.  I committed a followup patch to get rid of __ilog2.

  Ralf
