Received:  by oss.sgi.com id <S42264AbQEVUKy>;
	Mon, 22 May 2000 13:10:54 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:54846 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42260AbQEVUK1>;
	Mon, 22 May 2000 13:10:27 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id NAA09904; Mon, 22 May 2000 13:05:35 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id NAA88065; Mon, 22 May 2000 13:09:56 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA99834
	for linux-list;
	Mon, 22 May 2000 12:57:46 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA28161
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 22 May 2000 12:57:43 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA09851
	for <linux@cthulhu.engr.sgi.com>; Mon, 22 May 2000 12:57:42 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-18.uni-koblenz.de (cacc-18.uni-koblenz.de [141.26.131.18])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id VAA16922;
	Mon, 22 May 2000 21:57:42 +0200 (MET DST)
Received:  by lappi.waldorf-gmbh.de id <S1403830AbQEVT5F>;
	Mon, 22 May 2000 21:57:05 +0200
Date:   Mon, 22 May 2000 21:57:05 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Guido Guenther <guido.guenther@uni-konstanz.de>,
        Hiroyuki Machida <machida@sm.sony.co.jp>,
        Ralf Baechle <ralf@oss.sgi.com>, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com
Subject: Re: SIGIO Handler
Message-ID: <20000522215705.B4856@uni-koblenz.de>
References: <20000518161135.A26055@bert.physik.uni-konstanz.de> <20000522113213A.machida@sm.sony.co.jp> <20000522133149.A4036@uni-koblenz.de> <20000522153004.A173@bert.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000522153004.A173@bert.physik.uni-konstanz.de>; from agx@bert.physik.uni-konstanz.de on Mon, May 22, 2000 at 03:30:05PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, May 22, 2000 at 03:30:05PM +0200, Guido Guenther wrote:

> As a temporary workaround I changed the definition in asm/fcntl.h and 
> recomiled the kernel, this makes the little test program work. Hope it
> works for the xserver too...

Ok, but you changed the wrong side, libc's definition is what is broken.

  Ralf
