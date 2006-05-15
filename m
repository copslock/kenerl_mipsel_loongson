Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 May 2006 18:23:21 +0200 (CEST)
Received: from vhouten.xs4all.nl ([80.126.144.140]:54953 "HELO
	vhouten.xs4all.nl") by ftp.linux-mips.org with SMTP
	id S8133535AbWEOQXN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 May 2006 18:23:13 +0200
Received: from [10.254.10.11] (faramir.local [10.254.10.11])
	by vhouten.xs4all.nl (Postfix) with ESMTP id 4B8D71FF1B8;
	Mon, 15 May 2006 18:23:02 +0200 (MEST)
Message-ID: <4468AAE6.9060605@vhouten.xs4all.nl>
Date:	Mon, 15 May 2006 18:23:02 +0200
From:	Karel van Houten <Karel@vhouten.xs4all.nl>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Martin Michlmayr <tbm@cyrius.com>, debian-mips@lists.debian.org,
	linux-mips@linux-mips.org
Subject: Re: 2.6 for DECstation, d-i
References: <44635C0D.7040901@vhouten.xs4all.nl> <20060511173350.GM7827@deprecation.cyrius.com> <Pine.LNX.4.64N.0605111853500.20004@blysk.ds.pg.gda.pl> <20060511185446.GB7234@deprecation.cyrius.com> <Pine.LNX.4.64N.0605121142240.14216@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0605121142240.14216@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <Karel@vhouten.xs4all.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Karel@vhouten.xs4all.nl
Precedence: bulk
X-list: linux-mips

Hi all,

I've downloaded a current git source tree, and compiled that natively on 
my /260, using a debian testing/unstable installation (gcc 4.0.3). I 
only used an older version of the dec_esp driver, which gave me no problems.
That kernel boots fine, serial console works as it should.
As time permits I'll try to test some more options that I used in my 2.4 
kernels.

Good work (Maciej and others) !

Regards,
Karel.

Maciej W. Rozycki wrote:

> Of course there is. Just enable SERIAL_NONSTANDARD, SERIAL_DEC,
>
>SERIAL_DEC_CONSOLE and ZS.  They are all in drivers/char/Kconfig and it's 
>not a coincidence the options are the same as in 2.4.
>
> The driver has NOT been ported to use the serial core and frankly I would 
>rather it went away and write the necessary system specific glue 
>(including that horrible stuff for incorrect wiring used in all DEC 
>systems making use of the Zilog chips) to use drivers/net/wan/z85230.c 
>instead which already has a lot of nice stuff like support for synchronous 
>operation and DMA, HDLC framing, etc.
>
>  Maciej
>  
>
