Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Oct 2002 16:48:01 +0200 (CEST)
Received: from buserror-extern.convergence.de ([212.84.236.66]:14084 "EHLO
	hell") by linux-mips.org with ESMTP id <S1123396AbSJGOsB>;
	Mon, 7 Oct 2002 16:48:01 +0200
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 17yZAj-0004Mp-00
	for <linux-mips@linux-mips.org>; Mon, 07 Oct 2002 16:47:49 +0200
Date: Mon, 7 Oct 2002 16:47:49 +0200
From: Johannes Stezenbach <js@convergence.de>
To: linux-mips@linux-mips.org
Subject: Re: Once again: test_and_set for CPUs w/o LL/SC
Message-ID: <20021007144749.GB16641@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	linux-mips@linux-mips.org
References: <20020916164034.GA12489@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020916164034.GA12489@convergence.de>
User-Agent: Mutt/1.4i
Return-Path: <js@convergence.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@convergence.de
Precedence: bulk
X-list: linux-mips

Hi all,

On Mon, Sep 16, 2002 at 06:40:34PM +0200, I wrote:
> 
> The NEC VR41xx CPU has no LL/SC instructions, so they must
> be emulated by the kernel, which slows down the test-and-set
> and compare-and-swap operations (used by linux-threads)
> considerably. For the VR41xx (and other CPUs which have
> branch-likely instructions), there exisits a workaround
> which enables userspace-only atomic operations, with minor
> help from the kernel: The kernel must guarantee that register
> k1 is not equal to some magic value after every transition
> to userspace.
> 
> Two things were left open in July:
> - find out the minimal amount of changes to the kernel
>   to guarantee k1 != MAGIC after eret
> - determine how to tell glibc to use the branch-likely
>   workaround instead of emulated LL/SC

Since there have been no follow-ups I must assume that
this topic is no longer of interest. Is this so? Or
is the way I approach it deemed inappropriate?


Regards,
Johannes
