Received:  by oss.sgi.com id <S305172AbQDUSFW>;
	Fri, 21 Apr 2000 11:05:22 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:10260 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305155AbQDUSFH>; Fri, 21 Apr 2000 11:05:07 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id LAA05431; Fri, 21 Apr 2000 11:09:10 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA42735
	for linux-list;
	Fri, 21 Apr 2000 10:56:16 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA65589
	for <linux@engr.sgi.com>;
	Fri, 21 Apr 2000 10:56:14 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA06600
	for <linux@engr.sgi.com>; Fri, 21 Apr 2000 10:56:10 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 4268A81B; Fri, 21 Apr 2000 19:56:11 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 8F4088FC4; Fri, 21 Apr 2000 19:48:01 +0200 (CEST)
Date:   Fri, 21 Apr 2000 19:48:01 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Andreas Jaeger <aj@oss.sgi.com>
Cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu, Ulf Carlsson <ulfc@oss.sgi.com>,
        Ralf Baechle <ralf@uni-koblenz.de>
Subject: Re: GLIBC 2.2 should work on MIPS-Linux
Message-ID: <20000421194801.A5240@paradigm.rfc822.org>
References: <ho8zy7mkeq.fsf@awesome.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <ho8zy7mkeq.fsf@awesome.engr.sgi.com>; from Andreas Jaeger on Fri, Apr 21, 2000 at 10:30:21AM -0700
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, Apr 21, 2000 at 10:30:21AM -0700, Andreas Jaeger wrote:
> I would appreciate if you could build glibc and test it really hard.
> I do expect problems in the following areas:
> - definitions don't match between kernel and glibc.  I've used the
>   latest 2.3 release.  The glibc will not run with Linux 2.0.x.

Linux 2.0 is low priority IMHO as there is a "Standalone" Mips
port for 2.0 mainly used for the cobalts which has nevern been really
developed much further. Nobody (except the embedded people) will
use the 2.0 series now (And the embedded will use a smaller
libc anyways)

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
