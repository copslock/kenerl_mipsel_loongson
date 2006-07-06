Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jul 2006 23:57:36 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:61893 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S3489839AbWGFW50 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 6 Jul 2006 23:57:26 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k66MvMSx018434;
	Thu, 6 Jul 2006 23:57:22 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k66MvIG9018433;
	Thu, 6 Jul 2006 23:57:18 +0100
Date:	Thu, 6 Jul 2006 23:57:18 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>, a.voropay@equant.ru
Subject: Re: [PATCH] Fix process crash in 2.4 on attempt to use FPU on MIPS32
Message-ID: <20060706225718.GA18284@linux-mips.org>
References: <44AD7FBA.8000203@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44AD7FBA.8000203@ru.mvista.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11928
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 07, 2006 at 01:25:14AM +0400, Sergei Shtylyov wrote:

> If there's built-in FPU in a MIPS32 CPU the first time the process tries
> to use it, the kernel should crash with "reserved instruction" -- CPU will 
> try
> to execute 'dmtc1' which is a MIPS64 only insn. _init_fpu() was apprently 
> blindly copied form arch/mips64/... :-)
> 
> Since this occured with GXemul recently resending this 1.5 year old patch.

I didn't like the patch back then because it drops the optimizations
for 64-bit processors.  So I just took the 2.6 variant of the code and
bolted it into 2.4.

  Ralf
