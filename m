Received:  by oss.sgi.com id <S305168AbQDUTFW>;
	Fri, 21 Apr 2000 12:05:22 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:10526 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305155AbQDUTE7>; Fri, 21 Apr 2000 12:04:59 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id MAA04685; Fri, 21 Apr 2000 12:09:02 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA75510
	for linux-list;
	Fri, 21 Apr 2000 11:55:08 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from lappi (dhcp-163-154-5-221.engr.sgi.com [163.154.5.221])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA84177
	for <linux@engr.sgi.com>;
	Fri, 21 Apr 2000 11:55:07 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S1405412AbQDUSvV>;
	Fri, 21 Apr 2000 11:51:21 -0700
Date:   Fri, 21 Apr 2000 11:51:21 -0700
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Andreas Jaeger <aj@oss.sgi.com>
Cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu, Ulf Carlsson <ulfc@oss.sgi.com>
Subject: Re: GLIBC 2.2 should work on MIPS-Linux
Message-ID: <20000421115121.A1498@uni-koblenz.de>
References: <ho8zy7mkeq.fsf@awesome.engr.sgi.com> <hozoqnl5d7.fsf@awesome.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <hozoqnl5d7.fsf@awesome.engr.sgi.com>; from aj@oss.sgi.com on Fri, Apr 21, 2000 at 10:40:36AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, Apr 21, 2000 at 10:40:36AM -0700, Andreas Jaeger wrote:

> Upps, I was to fast.  I should have added that the handling of
> floating point numbers seems to be quite broken.  I haven't had time
> to investigate whether this is a bug in glibc, kernel (at least
> partially - we do need a real FPU emulation!) or gcc.

To keep you people up to date on this - I've got free shopping for
the kernel FPU support software, that's is there are four solutions
available:

 - two different ones from IRIX which I'm allowed to recycle for Linux
 - the Algorithmics code which already has been integrated into Linux
   by MIPS.
 - Write something new that is based on include/math-emu/.

It used to be a relativly hard thing but it's no longer :-)

  Ralf
