Received:  by oss.sgi.com id <S42264AbQEVUVN>;
	Mon, 22 May 2000 13:21:13 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:19226 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42260AbQEVUU4>; Mon, 22 May 2000 13:20:56 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id NAA05630; Mon, 22 May 2000 13:25:33 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA58173
	for linux-list;
	Mon, 22 May 2000 13:14:39 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA66587
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 22 May 2000 13:14:38 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA08684
	for <linux@cthulhu.engr.sgi.com>; Mon, 22 May 2000 13:14:37 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-18.uni-koblenz.de (cacc-18.uni-koblenz.de [141.26.131.18])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id WAA18850;
	Mon, 22 May 2000 22:14:33 +0200 (MET DST)
Received:  by lappi.waldorf-gmbh.de id <S1403830AbQEVUNl>;
	Mon, 22 May 2000 22:13:41 +0200
Date:   Mon, 22 May 2000 22:13:41 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Guido Guenther <guido.guenther@uni-konstanz.de>,
        Hiroyuki Machida <machida@sm.sony.co.jp>, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com
Subject: Re: SIGIO Handler
Message-ID: <20000522221341.C4856@uni-koblenz.de>
References: <20000518161135.A26055@bert.physik.uni-konstanz.de> <20000522113213A.machida@sm.sony.co.jp> <20000522133149.A4036@uni-koblenz.de> <20000522153004.A173@bert.physik.uni-konstanz.de> <20000522215705.B4856@uni-koblenz.de> <20000522220754.A12960@bert.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000522220754.A12960@bert.physik.uni-konstanz.de>; from agx@bert.physik.uni-konstanz.de on Mon, May 22, 2000 at 10:07:55PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, May 22, 2000 at 10:07:55PM +0200, Guido Guenther wrote:

> > Ok, but you changed the wrong side, libc's definition is what is broken.
>
> I know, but kernel recompiling is much quicker and easier for me to do -
> therefore I stated it as "workaround" above (until you release a new glibc ;)

Is uploading as I write this.

> Xserver works now btw, but is incredible slow(will try to play with dma
> transfers to speed things up). 

Excellent.  Even if it's slow as molasses, how about making a first release?

  Ralf
