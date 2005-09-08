Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Sep 2005 14:55:27 +0100 (BST)
Received: from relay01.pair.com ([IPv6:::ffff:209.68.5.15]:56081 "HELO
	relay01.pair.com") by linux-mips.org with SMTP id <S8225273AbVIHNzF>;
	Thu, 8 Sep 2005 14:55:05 +0100
Received: (qmail 885 invoked from network); 8 Sep 2005 14:02:08 -0000
Received: from unknown (HELO ?192.168.123.1?) (unknown)
  by unknown with SMTP; 8 Sep 2005 14:02:08 -0000
X-pair-Authenticated: 24.126.76.52
Message-ID: <43204123.8000204@kegel.com>
Date:	Thu, 08 Sep 2005 06:48:19 -0700
From:	Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/4.0 (compatible;MSIE 5.5; Windows 98)
X-Accept-Language: en, de-de
MIME-Version: 1.0
To:	Matej Kupljen <matej.kupljen@ultra.si>
CC:	David Daney <ddaney@avtrex.com>, crossgcc@sources.redhat.com,
	linux-mips@linux-mips.org
Subject: Re: MIPS SF toolchain
References: <1126098584.12696.19.camel@localhost.localdomain>	 <431F0850.8090804@avtrex.com>	 <1126168866.25388.11.camel@orionlinux.starfleet.com>	 <1126179199.25389.20.camel@orionlinux.starfleet.com> <1126182122.25393.27.camel@orionlinux.starfleet.com>
In-Reply-To: <1126182122.25393.27.camel@orionlinux.starfleet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dank@kegel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8901
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dank@kegel.com
Precedence: bulk
X-list: linux-mips

Matej Kupljen wrote:
> I think I found the problem.
> 
> ....
> 
> This code is written in  sysdeps/mips/setjmp_aux.c in 
> inline assembly.  ...
> 
> This code is written in sysdeps/mips/__longjmp.c in 
> inline assembly.
> 
> Because I am using sf, there is no need to store those
> registers, or is it?
> Can I just #ifdef this code if compiled for sf?

Other architectures do things like this, e.g.

sysdeps/powerpc/powerpc32/__longjmp-common.S:#ifdef __NO_VMX__

so I don't see why not.

In fact, I had to do something similar once to make life
possible for ppc405.  See

http://kegel.com/xgcc3/glibc-ppc-nofpu.patch3

(Hmm, wonder if something like that ever made it in to
mainline glibc.)

- Dan

-- 
Trying to get a job as a c++ developer?  See http://kegel.com/academy/getting-hired.html
