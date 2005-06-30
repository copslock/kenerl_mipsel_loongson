Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2005 21:22:09 +0100 (BST)
Received: from alg138.algor.co.uk ([IPv6:::ffff:62.254.210.138]:6889 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8226101AbVF3UVw>; Thu, 30 Jun 2005 21:21:52 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j5UKLCXA005350;
	Thu, 30 Jun 2005 21:21:12 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j5UKLBGS005349;
	Thu, 30 Jun 2005 21:21:11 +0100
Date:	Thu, 30 Jun 2005 21:21:11 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Bryan Althouse <bryan.althouse@3phoenix.com>
Cc:	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: Re: Seg fault when compiled with -mabi=64 and -lpthread
Message-ID: <20050630202111.GC3245@linux-mips.org>
References: <20050630173409Z8226102-3678+735@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050630173409Z8226102-3678+735@linux-mips.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8276
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 30, 2005 at 01:33:39PM -0400, Bryan Althouse wrote:

> The executable will seg fault.  If I remove the -lpthread, it is fine.
> Also, if I change the 64 to 32, it is fine.

I fear you may be hitting these problems simple because you're the first
through the mine field of 64-bit pthreads ;-)  So far most people are
simple running 32-bit software on their 64-bit kernels.  No reason to
panic though, most of the bits are in place, it's just the one or other
insect hiding in the code.

  Ralf
