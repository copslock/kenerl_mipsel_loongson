Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Sep 2004 16:13:34 +0100 (BST)
Received: from lennier.cc.vt.edu ([IPv6:::ffff:198.82.162.213]:50183 "EHLO
	lennier.cc.vt.edu") by linux-mips.org with ESMTP
	id <S8225216AbUIXPNa>; Fri, 24 Sep 2004 16:13:30 +0100
Received: from zidane.cc.vt.edu (IDENT:mirapoint@evil-zidane [10.1.1.13])
	by lennier.cc.vt.edu (8.12.8/8.12.8) with ESMTP id i8OFDTol317448;
	Fri, 24 Sep 2004 11:13:29 -0400 (EDT)
Received: from [128.173.184.75] (gs75.geol.vt.edu [128.173.184.75])
	by zidane.cc.vt.edu (MOS 3.4.8-GR)
	with ESMTP id BQB50375;
	Fri, 24 Sep 2004 11:13:27 -0400 (EDT)
Message-ID: <4154398E.3070806@gentoo.org>
Date: Fri, 24 Sep 2004 11:13:18 -0400
From: "Stephen P. Becker" <geoman@gentoo.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robin Humble <rjh@cita.utoronto.ca>
CC: linux-mips@linux-mips.org
Subject: Re: Kernel 2.6 for R4600 Indy
References: <4152D58B.608@longlandclan.hopto.org> <4152E4FC.8000408@gentoo.org> <41536765.9000304@longlandclan.hopto.org> <41541B8D.3060500@gentoo.org> <20040924131734.GC26710@lemming.cita.utoronto.ca> <415420D0.60102@gentoo.org> <20040924134334.GB27739@lemming.cita.utoronto.ca>
In-Reply-To: <20040924134334.GB27739@lemming.cita.utoronto.ca>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <geoman@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5889
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoman@gentoo.org
Precedence: bulk
X-list: linux-mips

>>day).  Also, Indys don't support a large enough memory configuration 
>>that 64-bit would be worth it anyhow.
> 
> 
> indeed they don't.
> do you get access to more registers or more efficient instruction sets
> like you do on x86_64?
> 
> 
>>What you would *really* want on such a machine would be n32 userland. 
>>You get full 64-bit instructions, but the binaries aren't huge.
> 

Yeah, that is what n32 is for.  You get more registers, but pointers are 
still 32-bit.  You still need a mips64 CHOST to build n32 binaries, however.

Steve
