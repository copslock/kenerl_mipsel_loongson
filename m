Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Mar 2004 07:59:10 +0000 (GMT)
Received: from p508B7C93.dip.t-dialin.net ([IPv6:::ffff:80.139.124.147]:16970
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225200AbUCDH7J>; Thu, 4 Mar 2004 07:59:09 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i247x7ex012545;
	Thu, 4 Mar 2004 08:59:07 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i247x6xo012544;
	Thu, 4 Mar 2004 08:59:06 +0100
Date: Thu, 4 Mar 2004 08:59:06 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: sathis kanna <sathiskanna@yahoo.com>
Cc: linux-mips@linux-mips.org
Subject: Re: physical memory Limitation
Message-ID: <20040304075906.GB23688@linux-mips.org>
References: <20040303153505.2825.qmail@web14913.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303153505.2825.qmail@web14913.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4473
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 03, 2004 at 07:35:05AM -0800, sathis kanna wrote:

> For mips,
> is there any limitation for physical memory while
> uncomressing the image??(like i386 it is 4MB)
> 
> How to locate in code written in the kernel source?

We currently don't support compressed kernels.

But if we were supporting it the limitation would depend on size of
available memory and how it's used at boot time, that is the limit would
depend on the exact system.

  Ralf
