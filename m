Received:  by oss.sgi.com id <S305162AbQA3LtH>;
	Sun, 30 Jan 2000 03:49:07 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:40499 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305160AbQA3Lsp>; Sun, 30 Jan 2000 03:48:45 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id DAA04382; Sun, 30 Jan 2000 03:54:08 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA84140
	for linux-list;
	Sun, 30 Jan 2000 03:34:05 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA00269
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 30 Jan 2000 03:33:57 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA01248
	for <linux@cthulhu.engr.sgi.com>; Sun, 30 Jan 2000 03:33:55 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 602C8816; Sun, 30 Jan 2000 12:33:49 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 940588FC4; Sun, 30 Jan 2000 12:05:42 +0100 (CET)
Date:   Sun, 30 Jan 2000 12:05:42 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     Ralf Baechle <ralf@oss.sgi.com>, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr, linux-mips@vger.rutgers.edu
Subject: Re: WCHAN on R3000
Message-ID: <20000130120542.C1514@paradigm.rfc822.org>
References: <000801bf6b14$51b2e620$0ceca8c0@satanas.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <000801bf6b14$51b2e620$0ceca8c0@satanas.mips.com>; from Kevin D. Kissell on Sun, Jan 30, 2000 at 12:22:27PM +0100
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Sun, Jan 30, 2000 at 12:22:27PM +0100, Kevin D. Kissell wrote:
> Note, however, that the incident below happened
> on an R4000 platform, not an R3K.   It's probably
> more significant that it was on a DECstation, thus
> a little-endian platform.  Which set of binaries are
> you running?   From your ps output, I don't think
> they are the same as I run, and I don't see this
> behaviour on my little-endian system.   Most of
> the fixes for little-endian kernels that we've made at
> MIPS have found their way into the SGI repository,
> but one may have been missed, or we may have
> an as-yet-undiscovered bug on our hands.
> 
> Why on earth would ps be doing a floating point
> conversion in the course of displaying wchan,
> anyway???

The binariers are homebrewed - Debian potato source package.

The system is based on the decroot something + a lot debian packages
i built myself ...

(root@repeat)~# ps -V
Unknown HZ value! (0) Assume 100.
procps version 2.0.3
(root@repeat)~#

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
