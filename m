Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jan 2003 23:13:45 +0000 (GMT)
Received: from holly.csn.ul.ie ([IPv6:::ffff:136.201.105.4]:52136 "EHLO
	holly.csn.ul.ie") by linux-mips.org with ESMTP id <S8225282AbTATXNo>;
	Mon, 20 Jan 2003 23:13:44 +0000
Received: from skynet.csn.ul.ie (skynet [136.201.105.2])
	by holly.csn.ul.ie (Postfix) with ESMTP
	id B59383F4AE; Mon, 20 Jan 2003 23:15:30 +0000 (GMT)
Received: by skynet.csn.ul.ie (Postfix, from userid 2139)
	id 3D05EE959; Mon, 20 Jan 2003 23:13:40 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by skynet.csn.ul.ie (Postfix) with ESMTP
	id 338207779; Mon, 20 Jan 2003 23:13:40 +0000 (GMT)
Date: Mon, 20 Jan 2003 23:13:40 +0000 (GMT)
From: Dave Airlie <airlied@csn.ul.ie>
X-X-Sender: airlied@skynet
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: [CFT] DECstation SCSI driver clean-ups
In-Reply-To: <Pine.GSO.3.96.1030120172610.4801E-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.44.0301202312430.28219-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <airlied@csn.ul.ie>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1193
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: airlied@csn.ul.ie
Precedence: bulk
X-list: linux-mips


>  I'm going to commit the changes in a few days, but having no SCSI devices
> attached to my DECstations, I cannot test the code at all.  I'd prefer to
> avoid a non-working driver in the CVS, so I would appreciate if someone
> with a suitable setup could test the new code.  A patch follows.
>
>  The single PMAZ-A limitation of the driver still applies, but it should
> be fairly easy to relax in the next step.

can someone try it on a 5000/200 if they have one also .. it's been a long
while since that code was written ... if it works on a PMAZ it'll probably
work on a 5000/200 anyways..

Dave.
>
>

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person
