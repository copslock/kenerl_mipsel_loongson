Received:  by oss.sgi.com id <S305194AbQDBTs1>;
	Sun, 2 Apr 2000 12:48:27 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:8507 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305164AbQDBTsL>; Sun, 2 Apr 2000 12:48:11 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id MAA05352; Sun, 2 Apr 2000 12:51:54 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA57850
	for linux-list;
	Sun, 2 Apr 2000 12:35:28 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA54595
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 2 Apr 2000 12:35:26 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA01459
	for <linux@cthulhu.engr.sgi.com>; Sun, 2 Apr 2000 12:35:24 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 553307D9; Sun,  2 Apr 2000 21:35:08 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 90F138FC3; Sun,  2 Apr 2000 20:48:55 +0200 (CEST)
Date:   Sun, 2 Apr 2000 20:48:55 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     "Andrew R. Baker" <andrewb@uab.edu>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: kernel for indigo2
Message-ID: <20000402204855.L11880@paradigm.rfc822.org>
References: <20000331194525.A20241@paradigm.rfc822.org> <Pine.LNX.3.96.1000402133834.24412A-100000@lithium>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <Pine.LNX.3.96.1000402133834.24412A-100000@lithium>; from Andrew R. Baker on Sun, Apr 02, 2000 at 01:40:51PM -0500
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Sun, Apr 02, 2000 at 01:40:51PM -0500, Andrew R. Baker wrote:
> On Fri, 31 Mar 2000, Florian Lohoff wrote:
> > Hi,
> > i recently (a couple of days ago) got an Indigo2 Impact and i thought
> > of beginning to bootstrap debian-mips (I already have >900 Package for
> > debian-mipsel) but i cant even boot a kernel. The standard (and old)
> > kernel on oss.sgi.com simple halt the machine after tftp boot - When
> > building a kernel from the current CVS the machine
> > crashes with a UTLB Miss as mentioned in the MIPS-FAQ as the 
> > -N binutils bugs although there is no -N in the makefile.
> > 
> > Does anyone have a working kernel for the Indigo2 ?
> 
> I have not gotten any of the recent 2.3 kernels to boot on my Indigo2.
> The last one I know worked was 2.3.19.  I have not had a chance to sort
> this out yet as I have been out of town for two weeks.  The 2.2 kernels do
> work however.

Could you dump one of the working 2.2. kernels into ftp.rfc822.org/incoming
as i would like to start beginning in userspace ....

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
