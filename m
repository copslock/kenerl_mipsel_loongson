Received:  by oss.sgi.com id <S305168AbQEPU2X>;
	Tue, 16 May 2000 20:28:23 +0000
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:55057 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305154AbQEPU2T>; Tue, 16 May 2000 20:28:19 +0000
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id NAA09363; Tue, 16 May 2000 13:32:50 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA93409
	for linux-list;
	Tue, 16 May 2000 13:23:44 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA66450
	for <linux@engr.sgi.com>;
	Tue, 16 May 2000 13:23:43 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA03368
	for <linux@engr.sgi.com>; Tue, 16 May 2000 13:23:42 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-18.uni-koblenz.de (cacc-18.uni-koblenz.de [141.26.131.18])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id WAA08541;
	Tue, 16 May 2000 22:23:39 +0200 (MET DST)
Received:  by lappi.waldorf-gmbh.de id <S1403827AbQEPUXA>;
	Tue, 16 May 2000 22:23:00 +0200
Date:   Tue, 16 May 2000 22:23:00 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Klaus Naumann <spock@mgnet.de>
Cc:     "Linux MIPS engr . sgi . com" <linux@cthulhu.engr.sgi.com>,
        Linux MIPS <linux-mips@fnet.fr>
Subject: Re: SGI Seeq byte accounting patch
Message-ID: <20000516222300.A6537@uni-koblenz.de>
References: <20000516173712.A598@spock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000516173712.A598@spock>; from spock@mgnet.de on Tue, May 16, 2000 at 05:37:12PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Tue, May 16, 2000 at 05:37:12PM +0200, Klaus Naumann wrote:

> Flo and me worked on a patch for the SGI Seeq driver the other day.
> The result is attached. Basically the patch fixes the byte accounting
> in /proc/net/dev. Without this patch RX and TX byte were 0 all time.
> The initialization of the static variable is just a cleanup of the code,
> so you can ignore it b/c it has nothing to do with the actual fix.
> Can anyone please test this patch on a system with a SGI Seeq and tell
> us if the values are correct or if it works ?
> We are very sure that the RX values are correct - discussion about TX is
> ongoing ;).
> Any help is appriciated. Also if you don't have a SGI Seeq board but
> know a save way to find out if the values are correct please tell us.

Looks good, applied.

  Ralf
