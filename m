Received:  by oss.sgi.com id <S42281AbQEXKJB>;
	Wed, 24 May 2000 03:09:01 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:34661 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42277AbQEXKIu>;
	Wed, 24 May 2000 03:08:50 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id DAA07437; Wed, 24 May 2000 03:03:57 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA16847
	for linux-list;
	Wed, 24 May 2000 02:59:34 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA14696
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 24 May 2000 02:59:24 -0700 (PDT)
	mail_from (agx@bert.physik.uni-konstanz.de)
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.30]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA08662
	for <linux@cthulhu.engr.sgi.com>; Wed, 24 May 2000 02:59:22 -0700 (PDT)
	mail_from (agx@bert.physik.uni-konstanz.de)
Received: from bert.physik.uni-konstanz.de [134.34.144.20] 
	by gandalf.physik.uni-konstanz.de with smtp (Exim 2.05 #1 (Debian))
	id 12uXwO-0007Ww-00; Wed, 24 May 2000 11:59:04 +0200
Received: by bert.physik.uni-konstanz.de (sSMTP sendmail emulation); Wed, 24 May 2000 11:57:54 +0200
Date:   Wed, 24 May 2000 11:57:54 +0200
From:   Guido Guenther <agx@bert.physik.uni-konstanz.de>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     Guido Guenther <Guido.Guenther@uni-konstanz.de>,
        Hiroyuki Machida <machida@sm.sony.co.jp>, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com
Subject: Re: SIGIO Handler
Message-ID: <20000524115754.A3614@bert.physik.uni-konstanz.de>
Mail-Followup-To: Guido Guenther <guido.guenther@uni-konstanz.de>,
	Ralf Baechle <ralf@oss.sgi.com>,
	Hiroyuki Machida <machida@sm.sony.co.jp>, linux-mips@fnet.fr,
	linux@cthulhu.engr.sgi.com
References: <20000518161135.A26055@bert.physik.uni-konstanz.de> <20000522113213A.machida@sm.sony.co.jp> <20000522133149.A4036@uni-koblenz.de> <20000522153004.A173@bert.physik.uni-konstanz.de> <20000522215705.B4856@uni-koblenz.de> <20000522220754.A12960@bert.physik.uni-konstanz.de> <20000522221341.C4856@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.9i
In-Reply-To: <20000522221341.C4856@uni-koblenz.de>; from ralf@oss.sgi.com on Mon, May 22, 2000 at 10:13:41PM +0200
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, May 22, 2000 at 10:13:41PM +0200, Ralf Baechle wrote:
> On Mon, May 22, 2000 at 10:07:55PM +0200, Guido Guenther wrote:
> 
> > > Ok, but you changed the wrong side, libc's definition is what is broken.
> >
> > I know, but kernel recompiling is much quicker and easier for me to do -
> > therefore I stated it as "workaround" above (until you release a new glibc ;)
> 
> Is uploading as I write this.
> 
> > Xserver works now btw, but is incredible slow(will try to play with dma
> > transfers to speed things up). 
> 
> Excellent.  Even if it's slow as molasses, how about making a first release?
I've stitched together some binaries which are completely untested due
to time constraints. They can be found at:
 http://honk.physik.uni-konstanz.de/~agx/mipslinux/x/binaries

Note that the driver code is really messy, has still a problem with the colormap 
in PseudoColor visual and has never been tested on the 24bit newport since
I don't have such a card(exactly speaking I don't even have an Indy but
that's another story ;). I hope I'll find the time to clean up and test
a bit of the code near the weekend.
Regards,
 -- Guido

-- 
GPG-Public Key: http://honk.physik.uni-konstanz.de/~agx/guenther.gpg.asc
