Received:  by oss.sgi.com id <S305162AbQBUPhr>;
	Mon, 21 Feb 2000 07:37:47 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:8233 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305159AbQBUPhU>; Mon, 21 Feb 2000 07:37:20 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id HAA06286; Mon, 21 Feb 2000 07:40:19 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA31167
	for linux-list;
	Mon, 21 Feb 2000 07:19:56 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA17963
	for <linux@engr.sgi.com>;
	Mon, 21 Feb 2000 07:19:20 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA03160
	for <linux@engr.sgi.com>; Mon, 21 Feb 2000 07:19:04 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-15.uni-koblenz.de (cacc-15.uni-koblenz.de [141.26.131.15])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id QAA25248;
	Mon, 21 Feb 2000 16:18:36 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407892AbQBUL6U>;
	Mon, 21 Feb 2000 12:58:20 +0100
Date:   Mon, 21 Feb 2000 12:58:20 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: CVS Update@oss.sgi.com: linux
Message-ID: <20000221125820.A11469@uni-koblenz.de>
References: <20000219003324Z305163-11638+186@oss.sgi.com> <Pine.GSO.4.10.10002211054270.29481-100000@dandelion.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <Pine.GSO.4.10.10002211054270.29481-100000@dandelion.sonytel.be>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, Feb 21, 2000 at 10:54:45AM +0100, Geert Uytterhoeven wrote:

> > Modified files:
> > 	include/asm-mips: uaccess.h 
> > 	include/asm-mips64: uaccess.h 
> > 
> > Log message:
> > 	Fix copy_from_user() in modules and 64-bit kernel.
> 
> Now the assembler complains with
> 
>     Warning: Used $at without ".set noat"

I just tried to build an Indy kernel and did not get this warning.

  Ralf
