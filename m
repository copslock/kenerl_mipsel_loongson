Received:  by oss.sgi.com id <S553698AbRCMVRB>;
	Tue, 13 Mar 2001 13:17:01 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:32508 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553667AbRCMVQk>;
	Tue, 13 Mar 2001 13:16:40 -0800
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f2DLBl321039;
	Tue, 13 Mar 2001 13:11:47 -0800
Message-ID: <3AAE8DE7.D6F5AB9E@mvista.com>
Date:   Tue, 13 Mar 2001 13:15:19 -0800
From:   Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-14 i586)
X-Accept-Language: en, bg
MIME-Version: 1.0
To:     Karel van Houten <K.H.C.vanHouten@research.kpn.com>
CC:     Ralf Baechle <ralf@oss.sgi.com>, Adrian Bunk <bunk@fs.tum.de>,
        linux-mips@oss.sgi.com, Daniel Jacobowitz <djacobowitz@mvista.com>
Subject: Re: Compile error with current CVS kernel
References: <200103131840.TAA14996@sparta.research.kpn.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Karel van Houten wrote:
> 
> While I wrote my previous mail:
> 
> {standard input}: Assembler messages:
> {standard input}:1993: Error: expression too complex
> {standard input}:1993: Fatal error: internal Error, line 1823, ./config/tc-mips.c
> make[3]: *** [vgacon.o] Error 1
> 
> Again.... :-(

We encountered this exact problem a few days ago. One of our engineers
tracked it down to the combination of complex macros and inline
functions in arch/mips/io.h.  He pinpointed precisely the problem to a
rare gcc "bug", which is not likely to get fixed anytime soon. I believe
a patch was already submitted to Ralf, but it will have to get tested.

Pete
