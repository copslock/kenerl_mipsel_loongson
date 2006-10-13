Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Oct 2006 10:51:57 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:9914 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S20038719AbWJMJvz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 13 Oct 2006 10:51:55 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id AB5674569D; Fri, 13 Oct 2006 11:51:54 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1GYJi2-00018i-K5; Fri, 13 Oct 2006 10:52:06 +0100
Date:	Fri, 13 Oct 2006 10:52:06 +0100
To:	Aurelien Jarno <aurelien@aurel32.net>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: SYS_personality does not work correctly on mips(el)64
Message-ID: <20061013095206.GA4027@networkno.de>
References: <452EB653.7070604@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452EB653.7070604@aurel32.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12926
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Aurelien Jarno wrote:
> Hi all,
> 
> On mips(el), when doing multiple call to the syscall SYS_personality in 
> order to get the current personality (using 0xffffffff for the first 
> argument), on a 64-bit kernel, the second and subsequent syscalls are 
> failing. That works correctly with a 32-bit kernels and on other 
> architectures.

That's caused by mis-handling broken sign extensions, see also
http://bugs.debian.org/380531.


Thiemo
