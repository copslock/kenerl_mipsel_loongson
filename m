Received:  by oss.sgi.com id <S305160AbQDTQ23>;
	Thu, 20 Apr 2000 09:28:29 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:65291 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305157AbQDTQ2X>;
	Thu, 20 Apr 2000 09:28:23 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id JAA06463; Thu, 20 Apr 2000 09:23:38 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA48799
	for linux-list;
	Thu, 20 Apr 2000 09:19:33 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA70630
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 20 Apr 2000 09:19:29 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA08462
	for <linux@cthulhu.engr.sgi.com>; Thu, 20 Apr 2000 09:19:15 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id D54A1808; Thu, 20 Apr 2000 18:19:14 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 4487B8FC4; Thu, 20 Apr 2000 18:13:52 +0200 (CEST)
Date:   Thu, 20 Apr 2000 18:13:52 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: Should send SIGFPE to .*
Message-ID: <20000420181352.A7304@paradigm.rfc822.org>
References: <00bf01bfaad1$fc42b460$0ceca8c0@satanas.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <00bf01bfaad1$fc42b460$0ceca8c0@satanas.mips.com>; from Kevin D. Kissell on Thu, Apr 20, 2000 at 04:08:58PM +0200
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Thu, Apr 20, 2000 at 04:08:58PM +0200, Kevin D. Kissell wrote:

> If, having tried that trick, the trap handler gets invoked again,
> things are more serious, and the limited emulator is invoked.

I understood that aftersome loops over the code :)

> if it was actually a problem), and as such the force_sig() should
> use the value returned by compute_return_epc() as the signal

I dont think compute_return_epc returns a signal value.

> number, and not SIGFPE, and the signal should really be
> sent to the process, not just noted as a signal wannabe.

I think this was due to a annoyed user whos process died
always when the fpu instruction got emulated :)

> I was going to make another cleanup pass over traps.c this
> week, so it looks like you've found me another nit to excise.
> (Although we've got the full-blown Algorithmics emulator
> in our source base - coming soon to a repository near you -
> we kept the old stuff around for people wanting to build for
> a minimal footprint).

How much is the full emulator as binary ?

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
