Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 May 2008 10:31:45 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:5272 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20035267AbYEOJbn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 May 2008 10:31:43 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m4F9VYOu005198;
	Thu, 15 May 2008 10:31:34 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m4F9VXEO005197;
	Thu, 15 May 2008 10:31:33 +0100
Date:	Thu, 15 May 2008 10:31:33 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [UPDATED PATCH] Fix check for valid stack pointer during
	backtrace
Message-ID: <20080515093133.GA2638@linux-mips.org>
References: <20080512155849.29DB4DE534@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080512155849.29DB4DE534@solo.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19277
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 12, 2008 at 05:58:48PM +0200, Thomas Bogendoerfer wrote:

> The newly added check for valid stack pointer address breaks at least for
> 64bit kernels.  Use __get_user() for accessing stack content to avoid crashes,
> when doing the backtrace.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Applied.  Thanks,

  Ralf
