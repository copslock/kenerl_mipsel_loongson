Received:  by oss.sgi.com id <S305155AbQDUSFc>;
	Fri, 21 Apr 2000 11:05:32 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:14100 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305168AbQDUSFM>; Fri, 21 Apr 2000 11:05:12 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id LAA07499; Fri, 21 Apr 2000 11:09:14 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA67372
	for linux-list;
	Fri, 21 Apr 2000 10:56:16 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA57936
	for <linux@engr.sgi.com>;
	Fri, 21 Apr 2000 10:56:14 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA09205
	for <linux@engr.sgi.com>; Fri, 21 Apr 2000 10:56:13 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 56C0781E; Fri, 21 Apr 2000 19:56:11 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id A25538FC4; Fri, 21 Apr 2000 19:49:55 +0200 (CEST)
Date:   Fri, 21 Apr 2000 19:49:55 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Andreas Jaeger <aj@oss.sgi.com>
Cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu, Ulf Carlsson <ulfc@oss.sgi.com>,
        Ralf Baechle <ralf@uni-koblenz.de>
Subject: Re: GLIBC 2.2 should work on MIPS-Linux
Message-ID: <20000421194955.B5240@paradigm.rfc822.org>
References: <ho8zy7mkeq.fsf@awesome.engr.sgi.com> <hozoqnl5d7.fsf@awesome.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <hozoqnl5d7.fsf@awesome.engr.sgi.com>; from Andreas Jaeger on Fri, Apr 21, 2000 at 10:40:36AM -0700
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, Apr 21, 2000 at 10:40:36AM -0700, Andreas Jaeger wrote:

> Upps, I was to fast.  I should have added that the handling of
> floating point numbers seems to be quite broken.  I haven't had time
> to investigate whether this is a bug in glibc, kernel (at least
> partially - we do need a real FPU emulation!) or gcc.

A (full) FPU emulation is in the works and will soon appear on a cvs somewhere 
i was told :), so it will possibly available with kernel 2.4 and though be in
line with glibc 2.2. 

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
