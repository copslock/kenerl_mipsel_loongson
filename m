Received:  by oss.sgi.com id <S42240AbQEYIsj>;
	Thu, 25 May 2000 01:48:39 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:36953 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42238AbQEYIsR>; Thu, 25 May 2000 01:48:17 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id CAA09724; Thu, 25 May 2000 02:52:56 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA93634
	for linux-list;
	Thu, 25 May 2000 02:38:18 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA63110
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 25 May 2000 02:38:17 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA09021
	for <linux@cthulhu.engr.sgi.com>; Thu, 25 May 2000 02:38:11 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 5A0AC7D9; Thu, 25 May 2000 11:38:14 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 3E9858FA7; Thu, 25 May 2000 10:25:27 +0200 (CEST)
Date:   Thu, 25 May 2000 10:25:27 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     nick@ns.snowman.net
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: New indy problems
Message-ID: <20000525102527.A4082@paradigm.rfc822.org>
References: <20000525023802.A8339@uni-koblenz.de> <Pine.LNX.4.05.10005242126570.19874-100000@ns.snowman.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <Pine.LNX.4.05.10005242126570.19874-100000@ns.snowman.net>; from nick@ns.snowman.net on Wed, May 24, 2000 at 09:29:36PM -0400
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, May 24, 2000 at 09:29:36PM -0400, nick@ns.snowman.net wrote:
> 
> Hi, is there any way for me to reset the root password on an indy?  I
> bought an indy cheap from a liquidator, and have no way to get the root
> password.  I can probably set it up, and then rsh into it from a "trusted
> host" (I own the network it's now on, and I could cat it's /.rhosts), but
> that would take alot of effort.  All I need is to make one little change
> to the FS from SASH or bootprom.

The indigo2 has a jumper onboard to "erase" the nvram setting (I multiple
times accidently changes the console setting)

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
