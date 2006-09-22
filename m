Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Sep 2006 17:39:33 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:7332 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038772AbWIVQjb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 22 Sep 2006 17:39:31 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k8MGeIa0031458;
	Fri, 22 Sep 2006 17:40:18 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k8MGeHTe031457;
	Fri, 22 Sep 2006 17:40:17 +0100
Date:	Fri, 22 Sep 2006 17:40:17 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Samium Gromoff <deepfire@elvees.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: 16KB PAGE_SIZE on r4k
Message-ID: <20060922164017.GC30382@linux-mips.org>
References: <200609221906.30516.deepfire@elvees.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609221906.30516.deepfire@elvees.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12629
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 22, 2006 at 07:06:30PM +0400, Samium Gromoff wrote:

> How reliable is 16KB PAGE_SIZE on r4k-likes in kernels around 2.6.17?
> 
> Is it known to work?

it's certainly not as well tested as 4k pages but several people have
reported success, most recently also on 32-bit kernels.

Btw, r4k is a bit ambigous, did you mean R4000 or 4K?

  Ralf
