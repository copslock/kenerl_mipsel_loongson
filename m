Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Aug 2005 16:49:32 +0100 (BST)
Received: from mx01.qsc.de ([IPv6:::ffff:213.148.129.14]:52438 "EHLO
	mx01.qsc.de") by linux-mips.org with ESMTP id <S8225326AbVHaPtP>;
	Wed, 31 Aug 2005 16:49:15 +0100
Received: from port-195-158-167-225.dynamic.qsc.de ([195.158.167.225] helo=hattusa.textio)
	by mx01.qsc.de with esmtp (Exim 3.35 #1)
	id 1EAUvt-0007JX-00; Wed, 31 Aug 2005 17:55:25 +0200
Received: from ths by hattusa.textio with local (Exim 4.52)
	id 1EAUvu-0005WE-Ht; Wed, 31 Aug 2005 17:55:26 +0200
Date:	Wed, 31 Aug 2005 17:55:26 +0200
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	"Stephen P. Becker" <geoman@gentoo.org>,
	'Linux/MIPS Development' <linux-mips@linux-mips.org>
Subject: Re: compiling kernel 2.6.13
Message-ID: <20050831155526.GW21717@hattusa.textio>
References: <200508311459.47273.djd20@kent.ac.uk> <20050831150256.GC3377@linux-mips.org> <4315CD1C.80203@gentoo.org> <20050831153509.GF3377@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050831153509.GF3377@linux-mips.org>
User-Agent: Mutt/1.5.10i
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8844
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Wed, Aug 31, 2005 at 11:30:36AM -0400, Stephen P. Becker wrote:
> 
> > >Daring.  Hardly anybody is using EISA on that machine and even less so on
> > >64-bit, expect to find bugs.
> > 
> > Furthermore, 64-bit kernels are somewhat broken on ip22 right now. 
> > Something is wrong with memory allocation, and it really screws a lot of 
> > things up.  Off the top of my head, you won't be able to turn on swap, 
> > mount a ricerfs partition, or dd large blocks from /dev/zero.  You would 
> > be much better of sticking with 32-bit at this time.
> 
> But that seems an IP22-specific problem.

I _think_ it hits every 64bit kernel which uses mappings in CKSEG0.
Do you know a system where this works?


Thiemo
