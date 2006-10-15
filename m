Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Oct 2006 22:27:45 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:13001 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S20039504AbWJOV1o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 15 Oct 2006 22:27:44 +0100
Received: from lagash (88-106-179-150.dynamic.dsl.as9105.com [88.106.179.150])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 3C067445DB; Sun, 15 Oct 2006 23:27:43 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1GZDWM-0006g7-VI; Sun, 15 Oct 2006 22:27:46 +0100
Date:	Sun, 15 Oct 2006 22:27:46 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Aurelien Jarno <aurelien@aurel32.net>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: SYS_personality does not work correctly on mips(el)64
Message-ID: <20061015212746.GA25607@networkno.de>
References: <452EB653.7070604@aurel32.net> <20061013095206.GA4027@networkno.de> <4532A415.1080801@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <4532A415.1080801@aurel32.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Aurelien Jarno wrote:
> Thiemo Seufer a écrit :
> >Aurelien Jarno wrote:
> >>Hi all,
> >>
> >>On mips(el), when doing multiple call to the syscall SYS_personality in 
> >>order to get the current personality (using 0xffffffff for the first 
> >>argument), on a 64-bit kernel, the second and subsequent syscalls are 
> >>failing. That works correctly with a 32-bit kernels and on other 
> >>architectures.
> >
> >That's caused by mis-handling broken sign extensions, see also
> >http://bugs.debian.org/380531.
> 
> I still got the exact same problem with this patch applied.

I works for me on a bcm91480b in big endian mode.


Thiemo
