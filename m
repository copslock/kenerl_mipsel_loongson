Received:  by oss.sgi.com id <S42264AbQEVUQx>;
	Mon, 22 May 2000 13:16:53 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:23065 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42260AbQEVUQt>; Mon, 22 May 2000 13:16:49 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id NAA00705; Mon, 22 May 2000 13:21:27 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id NAA95943; Mon, 22 May 2000 13:16:18 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA01697
	for linux-list;
	Mon, 22 May 2000 13:08:16 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA18283
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 22 May 2000 13:08:13 -0700 (PDT)
	mail_from (agx@bert.physik.uni-konstanz.de)
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.30]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA09860
	for <linux@cthulhu.engr.sgi.com>; Mon, 22 May 2000 13:08:11 -0700 (PDT)
	mail_from (agx@bert.physik.uni-konstanz.de)
Received: from bert.physik.uni-konstanz.de [134.34.144.20] 
	by gandalf.physik.uni-konstanz.de with smtp (Exim 2.05 #1 (Debian))
	id 12tyUg-0003cm-00; Mon, 22 May 2000 22:08:06 +0200
Received: by bert.physik.uni-konstanz.de (sSMTP sendmail emulation); Mon, 22 May 2000 22:07:55 +0200
Date:   Mon, 22 May 2000 22:07:55 +0200
From:   Guido Guenther <agx@bert.physik.uni-konstanz.de>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     Hiroyuki Machida <machida@sm.sony.co.jp>, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com
Subject: Re: SIGIO Handler
Message-ID: <20000522220754.A12960@bert.physik.uni-konstanz.de>
Mail-Followup-To: Guido Guenther <guido.guenther@uni-konstanz.de>,
	Ralf Baechle <ralf@oss.sgi.com>,
	Hiroyuki Machida <machida@sm.sony.co.jp>, linux-mips@fnet.fr,
	linux@cthulhu.engr.sgi.com
References: <20000518161135.A26055@bert.physik.uni-konstanz.de> <20000522113213A.machida@sm.sony.co.jp> <20000522133149.A4036@uni-koblenz.de> <20000522153004.A173@bert.physik.uni-konstanz.de> <20000522215705.B4856@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.9i
In-Reply-To: <20000522215705.B4856@uni-koblenz.de>; from ralf@oss.sgi.com on Mon, May 22, 2000 at 09:57:05PM +0200
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, May 22, 2000 at 09:57:05PM +0200, Ralf Baechle wrote:
> On Mon, May 22, 2000 at 03:30:05PM +0200, Guido Guenther wrote:
> 
> > As a temporary workaround I changed the definition in asm/fcntl.h and 
> > recomiled the kernel, this makes the little test program work. Hope it
> > works for the xserver too...
> 
> Ok, but you changed the wrong side, libc's definition is what is broken.
I know, but kernel recompiling is much quicker and easier for me to do -
therefore I stated it as "workaround" above (until you release a new glibc ;)
Xserver works now btw, but is incredible slow(will try to play with dma
transfers to speed things up). 
 -- Guido

-- 
GPG-Public Key: http://honk.physik.uni-konstanz.de/~agx/guenther.gpg.asc
