Received:  by oss.sgi.com id <S42270AbQEWCVg>;
	Mon, 22 May 2000 19:21:36 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:58693 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42269AbQEWCVY>; Mon, 22 May 2000 19:21:24 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id TAA07501; Mon, 22 May 2000 19:26:01 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id TAA62381; Mon, 22 May 2000 19:20:53 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA86481
	for linux-list;
	Mon, 22 May 2000 19:11:31 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA05811
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 22 May 2000 19:11:28 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA06374
	for <linux@cthulhu.engr.sgi.com>; Mon, 22 May 2000 19:11:27 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-18.uni-koblenz.de (cacc-18.uni-koblenz.de [141.26.131.18])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id EAA16656;
	Tue, 23 May 2000 04:11:27 +0200 (MET DST)
Received:  by lappi.waldorf-gmbh.de id <S1403830AbQEWCLJ>;
	Tue, 23 May 2000 04:11:09 +0200
Date:   Tue, 23 May 2000 04:11:09 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Guido Guenther <guido.guenther@uni-konstanz.de>,
        Hiroyuki Machida <machida@sm.sony.co.jp>, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com
Subject: Re: SIGIO Handler
Message-ID: <20000523041109.A8266@uni-koblenz.de>
References: <20000518161135.A26055@bert.physik.uni-konstanz.de> <20000522113213A.machida@sm.sony.co.jp> <20000522133149.A4036@uni-koblenz.de> <20000522153004.A173@bert.physik.uni-konstanz.de> <20000522215705.B4856@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000522215705.B4856@uni-koblenz.de>; from ralf@oss.sgi.com on Mon, May 22, 2000 at 09:57:05PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, May 22, 2000 at 09:57:05PM +0200, Ralf Baechle wrote:

> > As a temporary workaround I changed the definition in asm/fcntl.h and 
> > recomiled the kernel, this makes the little test program work. Hope it
> > works for the xserver too...
> 
> Ok, but you changed the wrong side, libc's definition is what is broken.

Ok, glibc 2.0.6-5lm can be downloaded from oss.sgi.com, directory
/pub/linux/mips/test-glibc.

  Ralf
