Received:  by oss.sgi.com id <S42240AbQEYKBK>;
	Thu, 25 May 2000 03:01:10 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:33884 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42238AbQEYKAu>; Thu, 25 May 2000 03:00:50 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id EAA02973; Thu, 25 May 2000 04:05:30 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA53355
	for linux-list;
	Thu, 25 May 2000 03:52:38 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgoslo.oslo.sgi.com (sgoslo.oslo.sgi.com [144.253.213.2])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA57416
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 25 May 2000 03:52:33 -0700 (PDT)
	mail_from (dagb@oslo.sgi.com)
Received: from dagb.oslo.sgi.com (dagb.oslo.sgi.com [144.253.213.35]) by sgoslo.oslo.sgi.com (980427.SGI.8.8.8/19990607.SGI.AUTOCF.hoststrip-1.1) via ESMTP id MAA57238; Thu, 25 May 2000 12:52:36 +0200 (MEST)
Received: (from dagb@localhost) by dagb.oslo.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) id MAA01370; Thu, 25 May 2000 12:52:21 +0200 (CEST)
Date:   Thu, 25 May 2000 12:52:21 +0200 (CEST)
From:   dagb@oslo.sgi.com (Dag Bakke)
Message-Id: <10005251252.ZM1368@dagb.oslo.sgi.com>
In-Reply-To: Florian Lohoff <flo@rfc822.org>
        "Re: New indy problems" (May 25, 10:25)
References: <20000525023802.A8339@uni-koblenz.de> 
	<Pine.LNX.4.05.10005242126570.19874-100000@ns.snowman.net> 
	<20000525102527.A4082@paradigm.rfc822.org>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To:     Florian Lohoff <flo@rfc822.org>, nick@ns.snowman.net
Subject: Re: New indy problems
Cc:     linux@cthulhu.engr.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On May 25, 10:25, Florian Lohoff wrote:
> Subject: Re: New indy problems
> On Wed, May 24, 2000 at 09:29:36PM -0400, nick@ns.snowman.net wrote:
> >
> > Hi, is there any way for me to reset the root password on an indy?  I
> > bought an indy cheap from a liquidator, and have no way to get the root
> > password.  I can probably set it up, and then rsh into it from a "trusted
> > host" (I own the network it's now on, and I could cat it's /.rhosts), but
> > that would take alot of effort.  All I need is to make one little change
> > to the FS from SASH or bootprom.
>
> The indigo2 has a jumper onboard to "erase" the nvram setting (I multiple
> times accidently changes the console setting)

The nvram pw is unrelated to the root pw on the systemdisk. (Which I am sure
you are aware of.  :-)

This question is a FAQ and not even related to Linux. You really should read
the SGI FAQs.

The fix is to boot miniroot from network or a CD. Then enter a shell by typing
'shroot' at the Inst> prompt. From here you can edit the passwd file.


Dag B
