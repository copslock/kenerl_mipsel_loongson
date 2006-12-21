Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Dec 2006 15:23:30 +0000 (GMT)
Received: from phoenix.bawue.net ([193.7.176.60]:57803 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S28643801AbWLUPXZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 21 Dec 2006 15:23:25 +0000
Received: from lagash (p54A47735.dip.t-dialin.net [84.164.119.53])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id EB9BFBBC16;
	Thu, 21 Dec 2006 16:14:19 +0100 (CET)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1GxPdO-0006d5-8T; Thu, 21 Dec 2006 15:15:02 +0000
Date:	Thu, 21 Dec 2006 15:15:02 +0000
To:	Amarjit Sathi <A.Sathi@cs.bham.ac.uk>
Cc:	linux-mips@linux-mips.org
Subject: Re: Choices choices...
Message-ID: <20061221151501.GC30873@networkno.de>
References: <458A9A00.2030506@cs.bham.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <458A9A00.2030506@cs.bham.ac.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13507
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Amarjit Sathi wrote:
> I have been given an SGI Onyx2 rackmount system with 16 MIPS RS10000 
> processors.

The graphics engine is not supported, the rest of the system is basically
an Origin 2000, which is semi-supported.

> I want to put linux on it and I was wondering if anyone had 
> experience of linux on this system or would recommend a flavour of linux 
>  for it.

The usual suspects for this are Gentoo Linux and Debian Linux.
AFAIK Gentoo has a live CD with precompiled Kernel, for Debian
you have to patch and build your own Kernel for now.

> I have a collection of RedHat servers at the moment so something that 
> would allow me to integrate them would be good.

I don't know of a .rpm based Distribution which would support SGI Origin.


Thiemo
