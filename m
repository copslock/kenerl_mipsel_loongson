Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id BAA15565
	for <pstadt@stud.fh-heilbronn.de>; Mon, 26 Jul 1999 01:00:12 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA22449; Sun, 25 Jul 1999 15:56:05 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA21392
	for linux-list;
	Sun, 25 Jul 1999 15:52:03 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA57486
	for <linux@engr.sgi.com>;
	Sun, 25 Jul 1999 15:51:59 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA02002
	for <linux@engr.sgi.com>; Sun, 25 Jul 1999 15:51:56 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-21.uni-koblenz.de [141.26.131.21])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id AAA15114
	for <linux@engr.sgi.com>; Mon, 26 Jul 1999 00:51:53 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id AAA02782;
	Mon, 26 Jul 1999 00:51:26 +0200
Date: Mon, 26 Jul 1999 00:51:26 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Mat Kovach <mkovach@alpha.theshagster.com>
Cc: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: Unimplemented Exception for insn 4620a0a4
Message-ID: <19990726005126.E31878@uni-koblenz.de>
References: <19990721103205.A25219@mini.gt.owl.de> <19990722005000.J14367@uni-koblenz.de> <19990722134126.J29846@mini.gt.owl.de> <19990723011059.W14367@uni-koblenz.de> <19990723141127.K15510@mini.gt.owl.de> <19990725150204.C31878@uni-koblenz.de> <19990725181727.A15348@mini.gt.owl.de> <19990725225305.D31878@uni-koblenz.de> <20190725125741.A1122@mkovach.nacs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <20190725125741.A1122@mkovach.nacs.net>; from Mat Kovach on Thu, Jul 25, 2019 at 12:57:41PM -0400
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Jul 25, 2019 at 12:57:41PM -0400, Mat Kovach wrote:

> sh Configure -des -Dprefix=/usr -Darchname=${RPM_ARCH}-linux -Dd_dosuid \
>         -Ud_setresuid -Ud_setresgid -Dd_semctl_semun
> make
> 
> strip perl
> strip suidperl
> strip x2p/a2p
> 
> %install
> rm -rf $RPM_BUILD_ROOT
> mkdir -p $RPM_BUILD_ROOT
> make install
> 
> So, it appears that RedHat doesn't run make test when it builds perl ...

Hmm...  Looking over the kernel source I just spotted a kernel bug which
affects both 2.2 and 2.3.  It will however only affect buggy software.
No C code will for example ever be hit.

  Ralf
