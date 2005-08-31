Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Aug 2005 16:24:48 +0100 (BST)
Received: from lennier.cc.vt.edu ([IPv6:::ffff:198.82.162.213]:41448 "EHLO
	lennier.cc.vt.edu") by linux-mips.org with ESMTP
	id <S8225326AbVHaPY2>; Wed, 31 Aug 2005 16:24:28 +0100
Received: from zidane.cc.vt.edu (IDENT:mirapoint@evil-zidane.cc.vt.edu [10.1.1.13])
	by lennier.cc.vt.edu (8.12.11/8.12.11) with ESMTP id j7VFUdb1016285
	for <linux-mips@linux-mips.org>; Wed, 31 Aug 2005 11:30:39 -0400
Received: from [128.173.184.73] (gs4073.geos.vt.edu [128.173.184.73])
	by zidane.cc.vt.edu (MOS 3.6.4-CR)
	with ESMTP id DYB20572;
	Wed, 31 Aug 2005 11:30:37 -0400 (EDT)
Message-ID: <4315CD1C.80203@gentoo.org>
Date:	Wed, 31 Aug 2005 11:30:36 -0400
From:	"Stephen P. Becker" <geoman@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050807)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: Re: compiling kernel 2.6.13
References: <200508311459.47273.djd20@kent.ac.uk> <20050831150256.GC3377@linux-mips.org>
In-Reply-To: <20050831150256.GC3377@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <geoman@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoman@gentoo.org
Precedence: bulk
X-list: linux-mips

>>eisa support is enabled and i'm compiling a 64 bit kernel.
> 
> 
> Daring.  Hardly anybody is using EISA on that machine and even less so on
> 64-bit, expect to find bugs.

Furthermore, 64-bit kernels are somewhat broken on ip22 right now. 
Something is wrong with memory allocation, and it really screws a lot of 
things up.  Off the top of my head, you won't be able to turn on swap, 
mount a ricerfs partition, or dd large blocks from /dev/zero.  You would 
be much better of sticking with 32-bit at this time.

-Steve
