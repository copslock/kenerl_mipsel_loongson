Received:  by oss.sgi.com id <S42254AbQEVNmH>;
	Mon, 22 May 2000 06:42:07 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:37994 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42242AbQEVNlt>; Mon, 22 May 2000 06:41:49 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id GAA06721; Mon, 22 May 2000 06:46:26 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id GAA99236; Mon, 22 May 2000 06:41:18 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA76289
	for linux-list;
	Mon, 22 May 2000 06:30:28 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA95090
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 22 May 2000 06:30:18 -0700 (PDT)
	mail_from (agx@bert.physik.uni-konstanz.de)
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.30]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA09987
	for <linux@cthulhu.engr.sgi.com>; Mon, 22 May 2000 06:30:17 -0700 (PDT)
	mail_from (agx@bert.physik.uni-konstanz.de)
Received: from bert.physik.uni-konstanz.de [134.34.144.20] 
	by gandalf.physik.uni-konstanz.de with smtp (Exim 2.05 #1 (Debian))
	id 12tsHW-0002bt-00; Mon, 22 May 2000 15:30:06 +0200
Received: by bert.physik.uni-konstanz.de (sSMTP sendmail emulation); Mon, 22 May 2000 15:30:05 +0200
Date:   Mon, 22 May 2000 15:30:05 +0200
From:   Guido Guenther <agx@bert.physik.uni-konstanz.de>
To:     Hiroyuki Machida <machida@sm.sony.co.jp>,
        Ralf Baechle <ralf@oss.sgi.com>
Cc:     linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: SIGIO Handler
Message-ID: <20000522153004.A173@bert.physik.uni-konstanz.de>
Mail-Followup-To: Guido Guenther <guido.guenther@uni-konstanz.de>,
	Hiroyuki Machida <machida@sm.sony.co.jp>,
	Ralf Baechle <ralf@oss.sgi.com>, linux-mips@fnet.fr,
	linux@cthulhu.engr.sgi.com
References: <20000518161135.A26055@bert.physik.uni-konstanz.de> <20000522113213A.machida@sm.sony.co.jp> <20000522133149.A4036@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.9i
In-Reply-To: <20000522133149.A4036@uni-koblenz.de>; from ralf@oss.sgi.com on Mon, May 22, 2000 at 01:31:49PM +0200
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

As a temporary workaround I changed the definition in asm/fcntl.h and 
recomiled the kernel, this makes the little test program work. Hope it
works for the xserver too...
Thanks a lot,
 -- Guido

On Mon, May 22, 2000 at 01:31:49PM +0200, Ralf Baechle wrote:
> On Mon, May 22, 2000 at 11:32:13AM +0900, Hiroyuki Machida wrote:
> 
> > > I'm still trying to get the mouse to work under X. The problem seems not
> > > to be related to X itself but to a kernel/glibc problem. X uses a SIGIO
> > > handler to "get notified" about mouse events. I wrote my own small SIGIO
> > > handler(see attached program) which works fine on my intel box but not
> > > on an indy (glibc-2.0.6-3lm/linux-2.2.13-20000211). 
> > 
> > I had experienced same SIGIO problem. It that time, the definitions
> > of glibc's FASYNC (in fnctbits.h) and kernel's FASYNC (in
> > asm/fcnt..h) were not same. 
> > 
> > Check those values in your system, first.
> 
> I'll prepare a new glibc 2.0 release with the header file fixed.  Glibc 2.2's
> <bits/fcntl.h> is ok.
> 
>   Ralf

-- 
GPG-Public Key: http://honk.physik.uni-konstanz.de/~agx/guenther.gpg.asc
