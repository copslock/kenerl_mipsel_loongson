Received:  by oss.sgi.com id <S305166AbQCOOsw>;
	Wed, 15 Mar 2000 06:48:52 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:62019 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbQCOOsb>; Wed, 15 Mar 2000 06:48:31 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id GAA08913; Wed, 15 Mar 2000 06:51:54 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA99880
	for linux-list;
	Wed, 15 Mar 2000 06:35:40 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA62583
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 15 Mar 2000 06:35:29 -0800 (PST)
	mail_from (KevinK@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA08766
	for <linux@cthulhu.engr.sgi.com>; Wed, 15 Mar 2000 06:35:29 -0800 (PST)
	mail_from (KevinK@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id GAA18032;
	Wed, 15 Mar 2000 06:35:23 -0800 (PST)
Received: from mips.com (copsun21 [192.168.205.31])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id GAA22295;
	Wed, 15 Mar 2000 06:35:19 -0800 (PST)
Message-ID: <38CF9FA5.D6C74F1F@mips.com>
Date:   Wed, 15 Mar 2000 15:35:17 +0100
From:   "Kevin D. Kissell" <KevinK@mips.com>
Organization: MIPS Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; I; SunOS 5.6 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To:     Dominic Sweetman <dom@algor.co.uk>
CC:     "Andrew R. Baker" <andrewb@uab.edu>,
        Ralf Baechle <ralf@oss.sgi.com>,
        Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
        linux-mips@vger.rutgers.edu, linux-mips@fnet.fr,
        Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: FP emulation patch available
References: <20000313144657.E845@uni-koblenz.de>
		<Pine.LNX.3.96.1000314123742.24923A-100000@lithium> <200003142317.XAA00644@gladsmuir.algor.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Dominic Sweetman wrote:

> Andrew R. Baker (andrewb@uab.edu) writes:
>
> > ... It will also only handle operations that should produce an
> > unimplemented exception (this is not quite all of the fp ops).
>
> Denormalised operands (for example) will cause any computational
> operation to blow up (change sign, load, store and move will survive -
> can you think of much else?).  The requirement for MIPS hardware is
> something like "you can throw an unimplemented exception in response
> to any combination of operands and operation you don't like, so long
> as it's rare".  That's why a complete emulator is probably a good
> idea.
>
> Dominic Sweetman
> dom@algor.co.uk

OK, I'm convinced.  I believe I know how to make the Algorithmics
emulator SMP-safe *and* more efficient in the general case, thanks
in part to a suggestion from Ralf.  Time permitting, I will also wire it
up to the unimplemented operation handler.  Give me a week or so
to accumulate enough spare time...
