Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jan 2008 00:17:47 +0000 (GMT)
Received: from relay01.mx.bawue.net ([193.7.176.67]:8916 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20029297AbYAIAR3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 9 Jan 2008 00:17:29 +0000
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id 7BC2E4890D;
	Wed,  9 Jan 2008 01:17:24 +0100 (CET)
Received: from ths by lagash with local (Exim 4.68)
	(envelope-from <ths@networkno.de>)
	id 1JCOdT-0004yd-Tw; Wed, 09 Jan 2008 00:17:35 +0000
Date:	Wed, 9 Jan 2008 00:17:35 +0000
From:	Thiemo Seufer <ths@networkno.de>
To:	Gregor Waltz <gregor.waltz@raritan.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Toshiba JMR 3927 working setup?
Message-ID: <20080109001735.GG16799@networkno.de>
References: <477E6296.7090605@raritan.com> <20080105144535.GA12824@linux-mips.org> <47840D53.50009@raritan.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47840D53.50009@raritan.com>
User-Agent: Mutt/1.5.17 (2007-12-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17960
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Gregor Waltz wrote:
> Ralf Baechle wrote:
>> You may want to switch to a recent binutils like 2.18 and gcc 4.2.2.
>
> Ralf, are you or anybody else using that combination for mips?
>
> With which versions of glibc and glibc-linuxthreads?
>
> I have been having a joyous time trying to build more recent tools.
> I keep getting errors like the following when building glibc of any  
> version (tried from 2.3.6 through 2.7):
> sysdeps/unix/sysv/linux/waitid.c:51: error: memory input 6 is not  
> directly addressable
>
> I found a patch for that  
> (http://sourceware.org/ml/crossgcc/2005-04/msg00208.html), but, after  
> passing that file, it fails similarly on pread.c. It seems to be an  
> issue with INLINE_SYSCALL, rather than the call sites, that appears to  
> be related to later versions of gcc.
>
> Later versions of glibc (2.7, 2.6...) fail at configure time with the  
> error: "The mipsel is not supported."

This suggests you are missing the "ports" add-on.

> So, what are the lastest versions of the build tools that people are  
> using on mips?

Debian uses binutils 2.18+, gcc 4.2 and glibc 2.7 in the "unstable"
development branch. This environment works fine for me.


Thiemo
