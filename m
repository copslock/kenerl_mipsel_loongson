Received:  by oss.sgi.com id <S305160AbPLCM76>;
	Fri, 3 Dec 1999 04:59:58 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:16200 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305156AbPLCM7s>;
	Fri, 3 Dec 1999 04:59:48 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA08013; Fri, 3 Dec 1999 05:06:46 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA70219
	for linux-list;
	Fri, 3 Dec 1999 04:52:04 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA28755
	for <linux@engr.sgi.com>;
	Fri, 3 Dec 1999 04:52:00 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from lappi (animaniacs.conectiva.com.br [200.250.58.146]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA07849
	for <linux@engr.sgi.com>; Fri, 3 Dec 1999 04:51:54 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S407621AbPLCMre>;
	Fri, 3 Dec 1999 10:47:34 -0200
Date:   Fri, 3 Dec 1999 10:47:33 -0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     SeungHoon Jung <shjung@sysmail.sec.samsung.co.kr>
Cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
Subject: Re: linux/mips cross compiling error
Message-ID: <19991203104733.A982@uni-koblenz.de>
References: <004701bf3bd6$65af2340$8501fb0a@seunghoon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <004701bf3bd6$65af2340$8501fb0a@seunghoon>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, Dec 01, 1999 at 05:30:55PM +0900, SeungHoon Jung wrote:

> I'm Seunghoon Jung. I'm currently working on mips based emdedded linux
> system.  In the porting process, we are helped very much by your
> linux/MIPS howto document.  Thank you very much for your efforts.
> 
> We use cross-compilers and binutils from ftp.linux.sgi.com.
> And we successfully made linux 2.2.12 kernel.
> 
> After making kernel, we are trying to make glibc and mips applications.
> 
> We are following your steps with glibc-2.1.2.

This is a genuine linker bug which is rather difficult to fix.  Also the
MIPS support for glib 2.1 isn't complete, somebody is working on it.

(Due to size constraints glibc 2.1 is a bad choice for most MIPS systems
anyway; the recommendation is to use glibc 2.0.)

  Ralf
