Received:  by oss.sgi.com id <S305160AbQCNSS5>;
	Tue, 14 Mar 2000 10:18:57 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:45135 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbQCNSSe>; Tue, 14 Mar 2000 10:18:34 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id KAA04499; Tue, 14 Mar 2000 10:21:57 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA73402
	for linux-list;
	Tue, 14 Mar 2000 10:10:01 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA15508
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 14 Mar 2000 10:09:48 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from lappi (animaniacs.conectiva.com.br [200.250.58.146]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA00810
	for <linux@cthulhu.engr.sgi.com>; Tue, 14 Mar 2000 10:09:33 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S407911AbQCNSJJ>;
	Tue, 14 Mar 2000 15:09:09 -0300
Date:   Tue, 14 Mar 2000 15:09:09 -0300
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Andrea Endrizzi <andreae@praim.com>
Cc:     "linux-mips@fnet.f" <linux-mips@fnet.fr>,
        "linux-mips@vger.rutgers.edu" <linux-mips@vger.rutgers.edu>,
        Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: Help mips-tx39-elf-{tool}
Message-ID: <20000314150909.A2418@uni-koblenz.de>
References: <2472.000314@praim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <2472.000314@praim.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Tue, Mar 14, 2000 at 11:20:06AM +0100, Andrea Endrizzi wrote:

> Hello Mips,

;-)

1) don't cc everybody on the planet ....
2) don't cc everybody on the planet ...

>   Excuse me, i have found your address in my long search in Mips
>   Developers Group. I make my apologies if i have wrong the address.
> 
>   I use a TX3927 Board , i try to write some little program ( led on/off ) and
>   work fine. I try to compile Mips Linux Kernel ( R3000 ) with mips-tx39-elf
>   compiler and i have some problem ...
> 
>   Is There anyone that have some experiences with Cygnus 98r2 for
>   Linux with target mips-tx39-elf-{tool} ???

Use the Linux/MIPS compiler for compiling the kernel or applications for
it.  Another compiler will most probably not work.

  Ralf
