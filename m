Received: (from majordomo@localhost)
	by oss.sgi.com (8.9.3/8.9.3) id HAA08658
	for linuxmips-outgoing; Tue, 26 Oct 1999 07:35:49 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linuxmips@oss.sgi.com using -f
Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by oss.sgi.com (8.9.3/8.9.3) with ESMTP id HAA08655
	for <linuxmips@oss.sgi.com>; Tue, 26 Oct 1999 07:35:48 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id HAA05889
	for <linuxmips@oss.sgi.com>; Tue, 26 Oct 1999 07:40:34 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA81916
	for linux-list;
	Tue, 26 Oct 1999 07:21:21 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA78214
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 26 Oct 1999 07:21:17 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA4135365
	for <linux@cthulhu.engr.sgi.com>; Tue, 26 Oct 1999 07:21:15 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 6FE217DD; Tue, 26 Oct 1999 16:21:08 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 981769011; Tue, 26 Oct 1999 16:20:26 +0200 (CEST)
Date: Tue, 26 Oct 1999 16:20:26 +0200
From: Florian Lohoff <flo@rfc822.org>
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: latest binutils cygnus CVS 991025
Message-ID: <19991026162026.I1207@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk

Hi,
does anyone have experiences with the latest (e.g. 991025) binutils from 
cygnus CVS ?

I got it build for "mipsel-unknown-linux-gnu" and got a libgmp2
build (Which fails with binutils 2.8.1 -> segfault ld)

The resulting library links against ssh (with 2.8.1) without problems
and seems to work (SSH works)

Are there any other known problems i might not have noticed ?

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
  ...  The failure can be random; however, when it does occur, it is
  catastrophic and is repeatable  ...             Cisco Field Notice
