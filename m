Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Sep 2004 14:27:13 +0100 (BST)
Received: from lennier.cc.vt.edu ([IPv6:::ffff:198.82.162.213]:51976 "EHLO
	lennier.cc.vt.edu") by linux-mips.org with ESMTP
	id <S8225205AbUIXN1J>; Fri, 24 Sep 2004 14:27:09 +0100
Received: from steiner.cc.vt.edu (IDENT:mirapoint@evil-steiner [10.1.1.14])
	by lennier.cc.vt.edu (8.12.8/8.12.8) with ESMTP id i8ODR6ol269672;
	Fri, 24 Sep 2004 09:27:06 -0400 (EDT)
Received: from [127.0.0.1] (68-232-97-125.chvlva.adelphia.net [68.232.97.125])
	by steiner.cc.vt.edu (MOS 3.4.8-GR)
	with ESMTP id BPS19718 (AUTH spbecker);
	Fri, 24 Sep 2004 09:27:04 -0400 (EDT)
Message-ID: <415420D0.60102@gentoo.org>
Date: Fri, 24 Sep 2004 09:27:44 -0400
From: "Stephen P. Becker" <geoman@gentoo.org>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robin Humble <rjh@cita.utoronto.ca>
CC: linux-mips@linux-mips.org
Subject: Re: Kernel 2.6 for R4600 Indy
References: <4152D58B.608@longlandclan.hopto.org> <4152E4FC.8000408@gentoo.org> <41536765.9000304@longlandclan.hopto.org> <41541B8D.3060500@gentoo.org> <20040924131734.GC26710@lemming.cita.utoronto.ca>
In-Reply-To: <20040924131734.GC26710@lemming.cita.utoronto.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <geoman@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5886
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoman@gentoo.org
Precedence: bulk
X-list: linux-mips

Robin Humble wrote:
> On Fri, Sep 24, 2004 at 09:05:17AM -0400, Stephen P. Becker wrote:
> 
>>Heh...I hope you are prepared for a significant slowdown if you end up 
>>trying to run n64 userland on such a machine.
> 
> 
> why's that?
> 

Mostly, 64-bit binaries are much larger than 32-bit.  Consider that the 
scsi controller in an Indy gets about 2mb/sec throughput MAX (on a good 
day).  Also, Indys don't support a large enough memory configuration 
that 64-bit would be worth it anyhow.

What you would *really* want on such a machine would be n32 userland. 
You get full 64-bit instructions, but the binaries aren't huge.


Steve
