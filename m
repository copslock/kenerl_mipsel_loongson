Received:  by oss.sgi.com id <S553955AbQKHUDl>;
	Wed, 8 Nov 2000 12:03:41 -0800
Received: from mx.mips.com ([206.31.31.226]:47589 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553766AbQKHUD1>;
	Wed, 8 Nov 2000 12:03:27 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id MAA25409;
	Wed, 8 Nov 2000 12:02:53 -0800 (PST)
Received: from lsf17.mips.com (lsf17 [192.168.10.205])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id MAA00300;
	Wed, 8 Nov 2000 12:03:11 -0800 (PST)
Received: from mips.com (localhost [127.0.0.1])
	by lsf17.mips.com (8.9.3/8.9.0) with ESMTP id MAA16401;
	Wed, 8 Nov 2000 12:03:11 -0800 (PST)
Message-ID: <3A09B17F.7FF3B03B@mips.com>
Date:   Wed, 08 Nov 2000 12:03:11 -0800
From:   "Kevin D. Kissell" <kevink@mips.com>
Organization: MIPS Technologies Inc.
X-Mailer: Mozilla 4.61 [en] (X11; U; SunOS 5.6 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ian Chilton <ian@ichilton.co.uk>
CC:     pete <pete@blackhammer.com>, linux-mips@oss.sgi.com
Subject: Re: MIPS linux
References: <20001108185711.A10689@woody.ichilton.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ian Chilton wrote:
> 
> Hello,
> 
> > and noticed that you do not recommend using the hardhat distro based on
> 
> You can use it, but it is old and broken. It will get you booted into Linux, but IIRC you can not even compile a kernel  :(

Sure you can!  I've done it hundreds of times. ;-)
You can even build binutils.  But you can't
build gcc, and any application that depends
on certain subtleties of signal behavior will be 
betrayed by the discrepancy between the
HardHat glibc and the 2.2-3-4 kernels.

So I too am eagerly looking forward to 
a 6.0 or 7.0 based solution - provided that
the glibc disconnects are fixed as well.

	Kevin K.
