Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2004 04:15:54 +0000 (GMT)
Received: from mx2.redhat.com ([IPv6:::ffff:66.187.237.31]:24849 "EHLO
	mx2.redhat.com") by linux-mips.org with ESMTP id <S8224948AbUAREPy>;
	Sun, 18 Jan 2004 04:15:54 +0000
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.11.6/8.11.6) with ESMTP id i0I3qPO15875;
	Sat, 17 Jan 2004 22:52:25 -0500
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i0I4FmM03076;
	Sat, 17 Jan 2004 23:15:48 -0500
Received: from [192.168.123.101] (vpn26-3.sfbay.redhat.com [172.16.26.3])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id i0I4Flb12623;
	Sat, 17 Jan 2004 20:15:47 -0800
Subject: Re: Trouble compiling MIPS cross-compiler
From: Eric Christopher <echristo@redhat.com>
To: Adam Nielsen <a.nielsen@optushome.com.au>
Cc: linux-mips@linux-mips.org
In-Reply-To: <200401181119.15234@korath>
References: <200401171711.34964@korath> <200401171736.49803@korath>
	 <20040117163355.GE5288@linux-mips.org>  <200401181119.15234@korath>
Content-Type: text/plain
Message-Id: <1074399252.3602.8.camel@dzur.sfbay.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 17 Jan 2004 20:14:12 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <echristo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: echristo@redhat.com
Precedence: bulk
X-list: linux-mips


> 
> /usr/mips-linux/bin/as: unrecognized option `-mcpu=r3000'
> 
> I saw that this option was removed a while back, so I guess downgrading the 
> binutils is the only way to go (or upgrading gcc, but I got a ton of errors 
> compiling 3.3.2 so I guess that doesn't work...)
> 

You do? What errors? How'd you build the toolchain?

At any rate, I'm using gcc and binutils HEAD to build quite a few
things. The last kernel I have is from broadcom (sibyte division) and
rebuilt and booted on the swarm board. (In fact, the compiler also
bootstraps on the board).

-eric

-- 
Eric Christopher <echristo@redhat.com>
