Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jan 2008 17:21:48 +0000 (GMT)
Received: from relay01.mx.bawue.net ([193.7.176.67]:56984 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20024116AbYADRVj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 4 Jan 2008 17:21:39 +0000
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id DDC7348906;
	Fri,  4 Jan 2008 18:21:33 +0100 (CET)
Received: from ths by lagash with local (Exim 4.68)
	(envelope-from <ths@networkno.de>)
	id 1JAqEi-0001va-Fm; Fri, 04 Jan 2008 17:21:36 +0000
Date:	Fri, 4 Jan 2008 17:21:36 +0000
From:	Thiemo Seufer <ths@networkno.de>
To:	Gregor Waltz <gregor.waltz@raritan.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Toshiba JMR 3927 working setup?
Message-ID: <20080104172136.GD22809@networkno.de>
References: <477E6296.7090605@raritan.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <477E6296.7090605@raritan.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Gregor Waltz wrote:
> I have been working on a JMR 3927 based system for a number of years. For 
> all of that time, we have been running:
> binutils 2.11.90.0.1
> gcc 2.95.3
> glibc 2.2.1
> linux 2.4.12
>
>
> We want to update to a 2.6 kernel, recent build tools, and saner system 
> libraries. Although, it seems that the JMR 3927 is still technically 
> supported, I have not found any info on whether anybody is still running 
> Linux on it and what combination of software they are using. Any idea?
> Is there a combination of software versions that are known to work on this 
> hardware?
>
>
> I have used crosstool 0.43 to build:
> binutils 2.15
> gcc 3.4.5
> glibc 2.3.6

http://www.linux-mips.org/wiki/Toolchains recommends binutils 2.16.1 and
gcc 3.4.4, but I believe your choice is also ok for 32-bit systems.

> I cannot get these kernels to build:
> linux-2.6.13
> linux-2.6.15
> linux-2.6.16.57
> linux-2.6.17.14
> linux-2.6.9
>
> My colleague and I have built these:
> linux-2.6.21.7
> linux-2.6.23.9
> linux-2.6.23.12
>
> However, they all yield a TLBL exception similar to the following:
>
> Exception! EPC=80056eb4 CAUSE=30000008(TLBL)
> 80056eb4 8ce4000c lw      a0,12(a3)                         # 0xc
>
> Each build has different exception values. The values are the same each 
> attempt with the same build.
>
> Is this a problem in the kernel code or the build tools?
> Any ideas on how to make it run?

Hard to tell from so little information, it would help to see the whole
boot log.


Thiemo
