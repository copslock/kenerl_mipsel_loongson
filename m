Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jan 2005 19:06:12 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:43082
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225428AbVAGTGH>; Fri, 7 Jan 2005 19:06:07 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CmzR0-0003Jk-00
	for <linux-mips@linux-mips.org>; Fri, 07 Jan 2005 20:06:06 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CmzQz-0003vY-00
	for <linux-mips@linux-mips.org>; Fri, 07 Jan 2005 20:06:05 +0100
Date: Fri, 7 Jan 2005 20:06:05 +0100
To: linux-mips@linux-mips.org
Subject: Re: [PATCH] Further TLB handler optimizations
Message-ID: <20050107190605.GG31335@rembrandt.csv.ica.uni-stuttgart.de>
References: <20041223202526.GA2254@deprecation.cyrius.com> <20041224040051.93587.qmail@web52806.mail.yahoo.com> <20041224085645.GJ3539@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041224085645.GJ3539@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.5.6+20040907i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> Manish Lachwani wrote:
> > Hello !
> > 
> > In what way does it break? Can you please provide more
> > details. Also, does it break on UP or SMP?
> 
> Userland starts to fail for simple tasks like 'ls -la'. The test was
> done with 64bit SMP on a board which needs the m3 workaround. The
> current CVS version works.
> 
> I guess the failure is caused by some missing bits for the m3
> workaround which only show up for the optimized handlers in 64bit mode.

Actually, it was caused by a stupid bug. The label to restart
the TLB modification on concurrent SMP updates was defined twice,
meaning it failed to re-execute the first half.

This also means that current 32bit SMP kernels have an easily
observable race condition there.

I updated the patch now and checked it in. Please test, especially
for cases I couldn't do, like R3000-style TLB handling and MIPS32
CPUs with 64bit physaddr.


Thiemo
