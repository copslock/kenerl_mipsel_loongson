Received:  by oss.sgi.com id <S42365AbQFUXZa>;
	Wed, 21 Jun 2000 16:25:30 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:7018 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42245AbQFUXZG>;
	Wed, 21 Jun 2000 16:25:06 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA05729
	for <linux-mips@oss.sgi.com>; Wed, 21 Jun 2000 16:20:02 -0700 (PDT)
	mail_from (paul@clubi.ie)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA54499
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 21 Jun 2000 16:24:30 -0700 (PDT)
	mail_from (paul@clubi.ie)
Received: from hibernia.jakma.org (hibernia.clubi.ie [212.17.32.129]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA03674
	for <linux@cthulhu.engr.sgi.com>; Wed, 21 Jun 2000 16:24:13 -0700 (PDT)
	mail_from (paul@clubi.ie)
Received: from fogarty.jakma.org (IDENT:root@fogarty.jakma.org [192.168.0.4])
	by hibernia.jakma.org (8.10.0/8.10.0) with ESMTP id e5LNOhf21775;
	Thu, 22 Jun 2000 00:24:43 +0100
Received: from localhost (paul@localhost)
	by fogarty.jakma.org (8.10.0/8.10.0) with ESMTP id e5LNOhp05573;
	Thu, 22 Jun 2000 00:24:43 +0100
X-Authentication-Warning: fogarty.jakma.org: paul owned process doing -bs
Date:   Thu, 22 Jun 2000 00:24:43 +0100 (IST)
From:   Paul Jakma <paul@clubi.ie>
X-Sender: paul@fogarty.jakma.org
To:     "J.K. Hill" <kenh@knoxville.sgi.com>
cc:     Ian Chilton <mailinglist@ichilton.co.uk>, spock@mgnet.de,
        Linux Debian MIPS <debian-mips@lists.debian.org>,
        Linux MIPS cthulhu <linux@cthulhu.engr.sgi.com>,
        Linux MIPS <linux-mips@fnet.fr>,
        MIPS vger <linux-mips@vger.rutgers.edu>
Subject: Re: Problems with multiple harddisks on my Indigo2
In-Reply-To: <10006211911.ZM32099@enigma.knoxville.sgi.com>
Message-ID: <Pine.LNX.4.21.0006220022560.5050-100000@fogarty.jakma.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 21 Jun 2000, J.K. Hill wrote:

> All,
> 
> Try looking up the jumper'ing information for the drive... There
> is probably a delay for spinning the drive up at boot (or some
> such nonsense).
> 

checked that.. and it's not it. the jumper isn't set. (i think).

however, this drive used to be in an Alpha, and ARCSBIOS on Alpha had
a problem with not recognising it from cold too, sometimes.

so maybe the drive just doesn't spin up fast enough.

> Regards,
> 
> Ken

thanks,
-- 
Paul Jakma	paul@clubi.ie
PGP5 key: http://www.clubi.ie/jakma/publickey.txt
-------------------------------------------
Fortune:
The price one pays for pursuing any profession, or calling, is an intimate
knowledge of its ugly side.
		-- James Baldwin
